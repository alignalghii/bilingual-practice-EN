{-# LANGUAGE OverloadedStrings #-}

module Router where

import Controller.HomeController (homeAction)
import BuiltinServer (builtinServerOptions)
import Web.Scotty (ScottyM, middleware, get)

router :: ScottyM ()
router = do
    mapM_ middleware builtinServerOptions
    get "/" homeAction
