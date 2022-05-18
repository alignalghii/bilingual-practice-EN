{-# LANGUAGE OverloadedStrings #-}

module Main (main) where

import BilingualPractice.Router (router)
import Web.Scotty (scotty)

main :: IO ()
main = scotty 3000 router
