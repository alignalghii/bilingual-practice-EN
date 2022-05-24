{-# LANGUAGE OverloadedStrings, NamedFieldPuns #-}

module BilingualPractice.Controller.HomeController where

import BilingualPractice.Controller.Base (blaze)
import BilingualPractice.Model.RelationalBusinessLogic (LexiconEntry (..), numeralsTable, conferPracticeCertificate)
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
    personal <- liftIO $ readTable "personal.table" :: ActionM [LexiconEntry]
    let etalon_questions     = map en etalon
        answered_questions   = map en personal
        unanswered_questions = etalon_questions \\ answered_questions
    maybe (announceResult etalon personal) (blaze . questionView) (maybeHead unanswered_questions)

receiveAnswerForQuestion :: ActionM ()
receiveAnswerForQuestion = do
    en       <- param "en"
    hu       <- param "hu"
    personal <- liftIO $ do
                             personal <- readTable "personal.table" :: IO [LexiconEntry]
                             -- personal       <- read <$> hGetContents personalHandle :: IO [LexiconEntry]
                             writeTable "personal.table" $ personal ++ [LxcE {en, hu, entity = "", difficulty = ""}]
                             -- liftIO $ writeTable "personal.table" $ personal ++ [(en, hu, "", "")]
    redirect "/question"

announceResult :: [LexiconEntry] -> [LexiconEntry] -> ActionM ()
announceResult etalon personal = blaze $ resultView $ conferPracticeCertificate etalon personal
