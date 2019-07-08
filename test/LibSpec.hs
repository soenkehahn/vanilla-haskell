module LibSpec where

import Control.Exception
import Lib
import Network.HTTP.Client
import Network.Wai.Handler.Warp
import Servant
import Servant.Client
import Test.Hspec

spec :: Spec
spec = do
  describe "app" $ do
    it "serves a 'hello world' endpoint" $ do
      testApp $ \ clientEnv -> do
        request clientEnv helloWorldEndpoint
          `shouldReturn` "hello world"

    it "serves a health endpoint" $ do
      testApp $ \ clientEnv -> do
        request clientEnv healthEndpoint
          `shouldReturn` True

helloWorldEndpoint :<|> healthEndpoint = client api

testApp :: (ClientEnv -> IO ()) -> IO ()
testApp test = do
  testWithApplication (return app) $ \ port -> do
    manager <- newManager defaultManagerSettings
    let baseUrl = BaseUrl Http "localhost" port ""
    let clientEnv = ClientEnv manager baseUrl Nothing
    test clientEnv

request :: ClientEnv -> ClientM a -> IO a
request clientEnv action =
  runClientM action clientEnv
    >>= either throwIO return
