{-# LANGUAGE OverloadedStrings, NamedFieldPuns #-}

module BilingualPractice.Controller.HomeController where

import BilingualPractice.Controller.Base (blaze)
import BilingualPractice.Model.TableManipulationForBusinessLogic (readExtendedLexiconTable)
import BilingualPractice.View.Home.HomeView     (homeView)
import BilingualPractice.View.Home.DumpView     (dumpView)
import BilingualPractice.View.Home.RandView     (randView)
import System.RandomX (randQuery)
import Web.Scotty (ActionM)
import Control.Monad.Trans (liftIO)


homeAction :: ActionM ()
homeAction = blaze homeView

dumpAction :: ActionM ()
dumpAction = liftIO readExtendedLexiconTable >>= (blaze . dumpView)

randAction :: ActionM ()
randAction = liftIO (readExtendedLexiconTable >>= randQuery 10) >>= (blaze . randView)
