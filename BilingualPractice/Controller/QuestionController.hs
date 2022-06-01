{-# LANGUAGE OverloadedStrings, NamedFieldPuns #-}

module BilingualPractice.Controller.QuestionController where

import BilingualPractice.Controller.Base (blaze)
import BilingualPractice.Model.RelationalBusinessLogic (LexiconEntry, AnsweredQuestion (..),
                                                        withFirstUnansweredQuestionIfAnyOrElse, conferPracticeCertificate)
import BilingualPractice.Model.TableManipulationForBusinessLogic (preparePracticeControllingTables, readPracticeControllingTables)
import BilingualPractice.Model.ViewModel (viewMatch)
import BilingualPractice.View.Question.QuestionView (questionView) -- !!
import BilingualPractice.View.Question.ResultView   (resultView) -- !!
import Database.SimpleHackDBMS.FileStorage (insertIntoTable)
import Web.Scotty (ActionM, param, redirect)
import Control.Monad.Trans (liftIO)
import Data.TimeX (epoch)
import Data.Time (getCurrentTime)


poseFirstRemainingExamenQuestionOrAnounceResultAction :: ActionM ()
poseFirstRemainingExamenQuestionOrAnounceResultAction = do
    (etalon, personal) <- liftIO readPracticeControllingTables
    let (ofAll, answd) = (length etalon, length personal)
        nth            = answd + 1
    withFirstUnansweredQuestionIfAnyOrElse (blaze . questionView nth ofAll) announceResult etalon personal

receiveAnswerForQuestion :: ActionM ()
receiveAnswerForQuestion = do
    ansHu       <- param "hu"
    ansEn       <- param "en"
    personal <- liftIO $ do
        ansTimeEnd <- getCurrentTime
        insertIntoTable "personal" AnsQu {ansHu, ansEn, ansTimeStart = epoch, ansTimeEnd}
    redirect "/question"

announceResult :: [LexiconEntry] -> [AnsweredQuestion] -> ActionM ()
announceResult etalon personal = blaze $ resultView $ viewMatch <$> conferPracticeCertificate etalon personal
