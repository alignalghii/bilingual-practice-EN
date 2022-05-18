{-# LANGUAGE OverloadedStrings #-}

module BilingualPractice.Router where

import BilingualPractice.Controller.HomeController (homeAction)
import BilingualPractice.BuiltinServer (builtinServerOptions)
import Web.Scotty (ScottyM, middleware, get)

router :: ScottyM ()
router = do
    mapM_ middleware builtinServerOptions
    get "/" homeAction
