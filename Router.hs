{-# LANGUAGE OverloadedStrings #-}

module Router where

import Controller.HomeController (homeAction)
import Web.Scotty (ScottyM, middleware, get)
import Network.Wai.Middleware.RequestLogger (logStdoutDev)
import Network.Wai.Middleware.Static (staticPolicy, (>->), noDots, addBase)

router :: ScottyM ()
router = do
    middleware $ staticPolicy (noDots >-> addBase "static")
    middleware logStdoutDev
    get "/" homeAction
