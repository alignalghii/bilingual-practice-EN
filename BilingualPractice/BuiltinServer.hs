module BilingualPractice.BuiltinServer (builtinServerOptions) where

import Network.Wai (Middleware)
import Network.Wai.Middleware.RequestLogger (logStdoutDev)
import Network.Wai.Middleware.Static (staticPolicy, (>->), noDots, addBase)


builtinServerOptions :: [Middleware]
builtinServerOptions = [staticPolicy (noDots >-> addBase "static"), logStdoutDev]
