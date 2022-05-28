{-# LANGUAGE OverloadedStrings, NamedFieldPuns #-}

module BilingualPractice.Controller.PracticeController where

import BilingualPractice.Controller.Base (blaze)
import BilingualPractice.Model.TableManipulationForBusinessLogic (preparePracticeControllingTables, readExtendedLexiconTable)
import BilingualPractice.Model.RelationalBusinessLogic (LexiconEntry, entity, difficulty)
import BilingualPractice.View.Practice.ExamenView   (examenView)
import System.RandomX (randQuery)
import Data.Property (selectorsPropertyCNF)
import Web.Scotty (ActionM, param, params, redirect)
import Control.Monad.Trans (liftIO)


proposeExamenAction :: ActionM ()
proposeExamenAction = blaze examenView

performExamenAction :: ActionM ()
performExamenAction = do
    pars <- map fst <$> params
    numberOfQuestions <- read <$> param "number_of_questions" -- @TODO: form validation
    liftIO $ preparePracticeControllingTables =<< randQuery numberOfQuestions =<< filter (lexiconEntryProps pars) <$> readExtendedLexiconTable
    redirect "/question"

lexiconEntryProps = selectorsPropertyCNF lexiconEntryProperties

lexiconEntryProperties = [
                           (entity, [("number", "szám"), ("word", "szó"), ("sentence", "mondat")]),
                           (difficulty,  [("easy", "könnyű"), ("difficult", "nehéz")])
                         ]
