module BilingualPractice.Model.TableManipulationForBusinessLogic where

import BilingualPractice.Model.RelationalBusinessLogic (LexiconEntry, AnsweredQuestion, numeralsRelation)
import Database.SimpleHackDBMS.FileStorage (readTable, writeTable, truncateTable)


readLexiconTable, readExtendedLexiconTable :: IO [LexiconEntry]
readLexiconTable         = readTable "lexicon"
readExtendedLexiconTable = (++ numeralsRelation) <$> readLexiconTable

preparePracticeControllingTables :: [LexiconEntry] -> IO [AnsweredQuestion] -- return type enables type deduction for truncateTable
preparePracticeControllingTables etalon = do
    writeTable "etalon" etalon
    truncateTable "personal" -- to help type deduction, we return with type [AnsweredQuestion] explicitly

readPracticeControllingTables :: IO ([LexiconEntry], [AnsweredQuestion])
readPracticeControllingTables = do
    etalon   <- readTable "etalon"
    personal <- readTable "personal"
    return (etalon, personal)
