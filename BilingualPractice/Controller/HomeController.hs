{-# LANGUAGE OverloadedStrings, NamedFieldPuns #-}

module BilingualPractice.Controller.HomeController where

import BilingualPractice.Controller.Base (blaze)
import BilingualPractice.Model.RelationalBusinessLogic (numeralsRelation)
import BilingualPractice.View.Home.HomeView     (homeView)
import BilingualPractice.View.Home.DumpView     (dumpView)
import BilingualPractice.View.Home.RandView     (randView)
import System.RandomX (randQuery)
import Web.Scotty (ActionM)
import Control.Monad.Trans (liftIO)


homeAction :: ActionM ()
homeAction = blaze homeView

dumpAction :: ActionM ()
dumpAction = blaze $ dumpView numeralsRelation

randAction :: ActionM ()
randAction = liftIO (randQuery 10 numeralsRelation) >>= (blaze . randView)
