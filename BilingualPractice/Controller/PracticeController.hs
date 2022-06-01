{-# LANGUAGE OverloadedStrings, NamedFieldPuns #-}

module BilingualPractice.Controller.PracticeController where

import Framework.Controller (blaze)
import BilingualPractice.Model.TableManipulationForBusinessLogic (preparePracticeControllingTables, readExtendedLexiconTable)
import BilingualPractice.Model.RelationalBusinessLogic (LexiconEntry, entity, difficulty)
import BilingualPractice.Model.ViewModel (Viewable (view))
import BilingualPractice.View.Practice.ExamenView   (examenView)
import Framework.Form (CheckList, makeCheckList, useCheckMatrixCNF)
import System.RandomX (randQuery)
import Web.Scotty (ActionM, param, params, redirect)
import Data.Text.Lazy (unpack)
import Control.Monad.Trans (liftIO)


proposeExamenAction :: ActionM ()
proposeExamenAction = blaze examenView

performExamenAction :: ActionM ()
performExamenAction = do
    pars <- map (unpack . fst) <$> params
    numberOfQuestions <- read <$> param "number_of_questions" -- @TODO: form validation
    liftIO $ preparePracticeControllingTables =<< randQuery numberOfQuestions =<< filter (useCheckMatrixCNF lexiconEntryCheckMatrix pars) <$> readExtendedLexiconTable
    redirect "/question"

-- lexiconEntryProps = selectorsPropertyCNF lexiconEntryProperties

lexiconEntryCheckMatrix :: [CheckList LexiconEntry]
lexiconEntryCheckMatrix = [makeCheckList entity, makeCheckList difficulty]
--[("number", matchField entity LUNumber), ("word", matchField entity LUWord), ("sentence", matchField entity LUSentence)]
--[("easy", matchField difficulty Easy), ("difficult", matchField difficulty Difficult)]
