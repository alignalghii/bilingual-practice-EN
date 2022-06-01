module Data.TimeX where

import Data.Time (UTCTime, formatTime, defaultTimeLocale)
import Data.Time.Clock.POSIX (posixSecondsToUTCTime)


abbrevTime :: UTCTime -> String
abbrevTime = formatTime defaultTimeLocale "%H:%M:%S"

abbrevTimeRead :: String -> String
abbrevTimeRead = abbrevTime . read

epoch :: UTCTime
epoch = posixSecondsToUTCTime 0
