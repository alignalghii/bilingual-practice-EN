module BilingualPractice.Model.TableManipulationForBusinessLogic where

import BilingualPractice.Model.RelationalBusinessLogic (LexiconEntry, AnsweredQuestion)
import Database.SimpleHackDB.FileStorage (readTable, writeTable, truncateTable)


preparePracticeControllingTables :: IO [LexiconEntry] -> IO [AnsweredQuestion] -- return type enables type deduction for truncateTable
preparePracticeControllingTables practiceRandomization = do
    etalon <- practiceRandomization
    writeTable "etalon.table" etalon
    truncateTable "personal.table" -- to help type deduction, we return with type [AnsweredQuestion] explicitly

readPracticeControllingTables :: IO ([LexiconEntry], [AnsweredQuestion])
readPracticeControllingTables = do
    etalon   <- readTable "etalon.table"
    personal <- readTable "personal.table"
    return (etalon, personal)
