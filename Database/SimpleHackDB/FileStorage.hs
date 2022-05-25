module Database.SimpleHackDB.FileStorage where

import System.IO.Strict (readFile)
import Prelude hiding (readFile)
import Data.ListX (insertAfter)
import Control.Monad (void)


type TableName = FilePath

writeTable :: Show record => FilePath -> [record] -> IO ()
writeTable tableName = writeFile tableName . show

writeTable_typDed :: Show record => FilePath -> [record] -> IO [record]
writeTable_typDed tableName records = writeTable tableName records >> return records

readTable :: Read record => FilePath -> IO [record]
readTable tableName = read <$> readFile tableName

truncateTable :: Show record => FilePath -> IO [record]
truncateTable tableName = writeTable_typDed tableName []

modifyTable :: (Read record, Show record) => FilePath -> ([record] -> [record]) -> IO [record]
modifyTable tableName f = do
    records <- readTable tableName
    writeTable tableName $ f records
    return records

insertIntoTable :: (Read record, Show record) => FilePath -> record -> IO ()
insertIntoTable tableName = void . modifyTable tableName . flip insertAfter
