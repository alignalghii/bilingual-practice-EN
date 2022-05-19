module BilingualPractice.BuiltinServer (builtinServerOptions) where

import Network.Wai (Middleware)
import Network.Wai.Middleware.RequestLogger (logStdoutDev)
import Network.Wai.Middleware.Static (staticPolicy, (>->), noDots, addBase)
import Data.ListX


builtinServerOptions :: Bool -> [Middleware]
builtinServerOptions logFlag = selectByFlags [(staticPolicy (noDots >-> addBase "static"), True), (logStdoutDev, logFlag)]
