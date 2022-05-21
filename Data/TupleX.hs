module Data.TupleX where

import Control.Arrow (first)

firstFirst :: (a -> a') -> ((a, b), c) -> ((a', b), c)
firstFirst = first . first

