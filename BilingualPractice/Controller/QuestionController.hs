{-# LANGUAGE OverloadedStrings, NamedFieldPuns #-}

module BilingualPractice.Controller.QuestionController where

import BilingualPractice.Controller.Base (blaze)
import BilingualPractice.Model.RelationalBusinessLogic (LexiconEntry, AnsweredQuestion (..),
                                                        withFirstUnansweredQuestionIfAnyOrElse, conferPracticeCertificate)
import BilingualPractice.Model.TableManipulationForBusinessLogic (preparePracticeControllingTables, readPracticeControllingTables)
import BilingualPractice.View.Question.QuestionView (questionView) -- !!
import BilingualPractice.View.Question.ResultView   (resultView) -- !!
import Database.SimpleHackDBMS.FileStorage (insertIntoTable)
import Web.Scotty (ActionM, param, redirect)
import Control.Monad.Trans (liftIO)
import Data.Time (getCurrentTime)


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
        insertIntoTable "personal" AnsQu {ansEn, ansHu, ansTimeStart = "", ansTimeEnd}
    redirect "/question"

announceResult :: [LexiconEntry] -> [AnsweredQuestion] -> ActionM ()
announceResult etalon personal = blaze $ resultView $ conferPracticeCertificate etalon personal
