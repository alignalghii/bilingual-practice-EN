{-# LANGUAGE OverloadedStrings #-}

module BilingualPractice.Router where

import BilingualPractice.Controller.HomeController (homeAction, dumpAction)
import BilingualPractice.BuiltinServer (builtinServerOptions)
import Web.Scotty (ScottyM, middleware, get)

router :: Bool -> ScottyM ()
router logFlag = do
    mapM_ middleware $ builtinServerOptions logFlag
    get "/"     homeAction
    get "/dump" dumpAction
