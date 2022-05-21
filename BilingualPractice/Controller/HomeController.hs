module BilingualPractice.Controller.HomeController where

import BilingualPractice.Controller.Base (blaze)
import BilingualPractice.Model.Grammar.Numeral (numeralsTable)
import BilingualPractice.View.HomeView (homeView)
import BilingualPractice.View.DumpView (dumpView)
import BilingualPractice.View.RandView (randView)
import Web.Scotty (ActionM)
import System.RandomX (randVariateMaxSM)
import Control.Monad.Trans (liftIO)
import Control.Monad.State.Strict (evalState)
import System.Random (newStdGen)

homeAction :: ActionM ()
homeAction = blaze homeView

dumpAction :: ActionM ()
dumpAction = blaze $ dumpView numeralsTable

randAction :: ActionM ()
randAction = liftIO newStdGen >>= (blaze . randView . fst . evalState (randVariateMaxSM numeralsTable 10))

