{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Lib where

import Data.Function
import Network.Wai
import Network.Wai.Handler.Warp
import Servant

run :: IO ()
run = do
  let port = 1234
      settings = defaultSettings
        & setPort port
        & setBeforeMainLoop (putStrLn ("listening on port " ++ show port))
  runSettings settings app

app :: Application
app = serve api server

type Api =
  "hello-world" :> Get '[PlainText] String :<|>
  "health" :> Get '[JSON] Bool

api :: Proxy Api
api = Proxy

server :: Server Api
server =
  return "hello world" :<|>
  return True
