{-# LANGUAGE OverloadedStrings #-}

module Main (main) where

import Web.Scotty as S hiding (body)
-- import Data.Text.Lazy (Text, pack)

main :: IO ()
main = scotty 3000 router

router :: ScottyM ()
router = do
    get "/" home


home :: ActionM ()
home = html "Hello"
