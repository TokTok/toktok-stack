{-# LANGUAGE StrictData #-}
module Network.Tox.TuiSpec where

import           Test.Hspec


a :: Int
a = 33


spec :: Spec
spec =
    describe "tui" $ do
        it "loads ok" $ do
            a `shouldBe` a
