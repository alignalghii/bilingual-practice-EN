{-# LANGUAGE OverloadedStrings, NamedFieldPuns #-}

module BilingualPractice.Controller.PracticeController where

import BilingualPractice.Controller.Base (blaze)
import BilingualPractice.Model.RelationalBusinessLogic (LexiconEntry (..), numeralsRelation, AnsweredQuestion (..),
                                                        withFirstUnansweredQuestionIfAnyOrElse, conferPracticeCertificate)
import BilingualPractice.Model.TableManipulationForBusinessLogic (preparePracticeControllingTables, readPracticeControllingTables)
import BilingualPractice.View.Practice.ExamenView   (examenView)
import BilingualPractice.View.Practice.QuestionView (questionView, resultView) -- !!
import Database.SimpleHackDBMS.FileStorage (insertIntoTable)
import System.RandomX (randQuery)
import Web.Scotty (ActionM, param, redirect)
import Control.Monad.Trans (liftIO)
import Data.Time (getCurrentTime)


proposeExamenAction :: ActionM ()
proposeExamenAction = blaze examenView

performExamenAction :: ActionM ()
performExamenAction = do
    liftIO $ preparePracticeControllingTables $ randQuery 10 numeralsRelation
    redirect "/question"

poseFirstRemainingExamenQuestionOrAnounceResultAction :: ActionM ()
poseFirstRemainingExamenQuestionOrAnounceResultAction = do
    (etalon, personal) <- liftIO readPracticeControllingTables
    withFirstUnansweredQuestionIfAnyOrElse (blaze . questionView) announceResult etalon personal

receiveAnswerForQuestion :: ActionM ()
receiveAnswerForQuestion = do
    ansEn       <- param "en"
    ansHu       <- param "hu"
    personal <- liftIO $ do
        ansTimeEnd <- show <$> getCurrentTime
        insertIntoTable "personal.table" AnsQu {ansEn, ansHu, ansTimeStart = "", ansTimeEnd}
    redirect "/question"

announceResult :: [LexiconEntry] -> [AnsweredQuestion] -> ActionM ()
announceResult etalon personal = blaze $ resultView $ conferPracticeCertificate etalon personal
