{-# LANGUAGE OverloadedStrings, NamedFieldPuns #-}

module BilingualPractice.Controller.PracticeController where

import BilingualPractice.Controller.Base (blaze)
import BilingualPractice.Model.RelationalBusinessLogic (numeralsRelation)
import BilingualPractice.Model.TableManipulationForBusinessLogic (preparePracticeControllingTables)
import BilingualPractice.View.Practice.ExamenView   (examenView)
import System.RandomX (randQuery)
import Web.Scotty (ActionM, redirect)
import Control.Monad.Trans (liftIO)


proposeExamenAction :: ActionM ()
proposeExamenAction = blaze examenView

performExamenAction :: ActionM ()
performExamenAction = do
    liftIO $ preparePracticeControllingTables $ randQuery 10 numeralsRelation
    redirect "/question"
