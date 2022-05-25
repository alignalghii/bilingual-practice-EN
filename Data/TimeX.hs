module Data.TimeX where

import Data.Time (UTCTime, formatTime, defaultTimeLocale)


abbrevTime :: UTCTime -> String
abbrevTime = formatTime defaultTimeLocale "%H:%M:%S"

abbrevTimeRead :: String -> String
abbrevTimeRead = abbrevTime . read
