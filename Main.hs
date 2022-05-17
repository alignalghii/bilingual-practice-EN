{-# LANGUAGE OverloadedStrings #-}

module Main (main) where

import Router (router)
import Web.Scotty (scotty)

main :: IO ()
main = scotty 3000 router
