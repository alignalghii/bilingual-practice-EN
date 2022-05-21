module Data.BoolX where

straightVsReverse :: a -> a -> Bool -> (a, a)
straightVsReverse a1 a2 True  = (a1, a2)
straightVsReverse a1 a2 False = (a2, a1)
