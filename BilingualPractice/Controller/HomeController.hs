{-# LANGUAGE OverloadedStrings, NamedFieldPuns #-}

module BilingualPractice.Controller.HomeController where

import BilingualPractice.Controller.Base (blaze)
import BilingualPractice.Model.RelationalBusinessLogic (LexiconEntry (..), numeralsTable, AnsweredQuestion (..), conferPracticeCertificate)
import BilingualPractice.View.HomeView     (homeView)
import BilingualPractice.View.DumpView     (dumpView)
import BilingualPractice.View.RandView     (randView)
import BilingualPractice.View.ExamenView   (examenView)
import BilingualPractice.View.QuestionView (questionView, resultView) -- !!
import Database.SimpleHackDB.FileStorage   (readTable, writeTable)
import System.RandomX (randQuery)
import Data.ListX (maybeHead)
import Web.Scotty (ActionM, param, redirect)
import Control.Monad.Trans (liftIO)
import Data.List ((\\))
import Data.Time (getCurrentTime, formatTime, defaultTimeLocale)

homeAction :: ActionM ()
homeAction = blaze homeView

dumpAction :: ActionM ()
dumpAction = blaze $ dumpView numeralsTable

randAction :: ActionM ()
randAction = liftIO (randQuery 10 numeralsTable) >>= (blaze . randView)

proposeExamenAction :: ActionM ()
proposeExamenAction = blaze examenView

performExamenAction :: ActionM ()
performExamenAction = do
    liftIO prepareExamenEtalon
    redirect "/question"


prepareExamenEtalon :: IO ()
prepareExamenEtalon = do
    etalon <- randQuery 10 numeralsTable
    writeTable "etalon.table" etalon
    writeTable "personal.table" ([] :: [LexiconEntry])

poseFirstRemainingExamenQuestionOrAnounceResultAction :: ActionM ()
poseFirstRemainingExamenQuestionOrAnounceResultAction = do
    etalon   <- liftIO $ readTable "etalon.table"   :: ActionM [LexiconEntry]
    personal <- liftIO $ readTable "personal.table" :: ActionM [AnsweredQuestion]
    let etalon_questions     = map en etalon
        answered_questions   = map ansEn personal
        unanswered_questions = etalon_questions \\ answered_questions
    maybe (announceResult etalon personal) (blaze . questionView) (maybeHead unanswered_questions)

receiveAnswerForQuestion :: ActionM ()
receiveAnswerForQuestion = do
    ansEn       <- param "en"
    ansHu       <- param "hu"
    personal <- liftIO $ do
                             ansTimeEnd <- formatTime defaultTimeLocale "%H:%M:%S"  <$> getCurrentTime
                             personal <- readTable "personal.table" :: IO [AnsweredQuestion]
                             -- personal       <- read <$> hGetContents personalHandle :: IO [AnsweredQuestion]
                             writeTable "personal.table" $ personal ++ [AnsQu {ansEn, ansHu, ansTimeStart = "", ansTimeEnd}]
                             -- liftIO $ writeTable "personal.table" $ personal ++ [(en, hu, "", "")]
    redirect "/question"

announceResult :: [LexiconEntry] -> [AnsweredQuestion] -> ActionM ()
announceResult etalon personal = blaze $ resultView $ conferPracticeCertificate etalon personal
