module LibSpec where

import Test.Hspec
import Lib

spec :: Spec
spec = do
  describe "add" $ do
    it "adds numbers" $ do
      add 1 1 `shouldBe` 2
