module Database.SimpleHackDB.FileStorage where

import System.IO.Strict (readFile)
import Prelude hiding (readFile)


writeTable :: Show a => FilePath -> a -> IO ()
writeTable tableName = writeFile tableName . show

readTable :: Read a => FilePath -> IO a
readTable tableName = read <$> readFile tableName
