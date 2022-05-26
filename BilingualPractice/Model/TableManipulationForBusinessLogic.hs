module BilingualPractice.Model.TableManipulationForBusinessLogic where

import BilingualPractice.Model.RelationalBusinessLogic (LexiconEntry, AnsweredQuestion)
import Database.SimpleHackDBMS.FileStorage (readTable, writeTable, truncateTable)


preparePracticeControllingTables :: IO [LexiconEntry] -> IO [AnsweredQuestion] -- return type enables type deduction for truncateTable
preparePracticeControllingTables practiceRandomization = do
    etalon <- practiceRandomization
    writeTable "etalon" etalon
    truncateTable "personal" -- to help type deduction, we return with type [AnsweredQuestion] explicitly

readPracticeControllingTables :: IO ([LexiconEntry], [AnsweredQuestion])
readPracticeControllingTables = do
    etalon   <- readTable "etalon"
    personal <- readTable "personal"
    return (etalon, personal)
