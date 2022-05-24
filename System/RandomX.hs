{-# LANGUAGE NPlusKPatterns #-}

module System.RandomX where

import Data.ListX (ListZipper_bothNonrev, select)
import Data.BoolX (straightVsReverse)
import Data.TupleX (firstFirst)
import System.Random (StdGen, newStdGen, randomR)
import Control.Monad.State.Strict (State, state, evalState, StateT) -- Lazy vs Strict seems to be not affecting of our main laziness question here
import Control.Arrow (first)
import Data.Maybe (fromJust)

-- @TODO refactory the whole according to State Monad (and maybe later according to Random monad)

--randSelect' :: [a] -> StdGen -> (Either Bool (ListZipper_bothNonrev a), StdGen)
--randSelect' ....

randSelect :: a -> a -> [a] -> StdGen -> (Either Bool (ListZipper_bothNonrev a), StdGen)
randSelect a1 a2 as seed = first f $ randomR (0, length as + 1) seed where
    f 0        = Left True
    f 1        = Left False
    f (i' + 2) = Right $ fromJust $ select i' as

-- It cannot handle infinite streams due to RandomR, thus, a deep foundational reason
-- Otherwise it seems to be lazy: we could use `take n ... randPermute` instead of `randVariate`
-- Maybe we could also abandon maintaining the remainder list: it could be much faster!
randPermute :: [a] -> StdGen -> ([a], StdGen)
randPermute []             seed = ([] , seed)
randPermute [a]            seed = ([a], seed)
randPermute (a1 : a2 : as) seed = let (ebz, seed') = randSelect a1 a2 as seed
                                      f (Left flag)                 = let (a1', a2') = straightVsReverse a1 a2 flag
                                                                      in  first (a1' :) $ randPermute (a2' : as) seed'
                                      f (Right (before, a', after)) = first (a' :) $ randPermute (a1 : a2 : (before ++ after)) seed'
                                  in f ebz

randVariateMax :: [a] -> Int -> StdGen -> (([a], [a]), StdGen)
randVariateMax []             _       seed = (([] , []), seed)
randVariateMax as             0       seed = (([] , as), seed)
randVariateMax [a]            (k + 1) seed = (([a], []), seed)
randVariateMax (a1 : a2 : as) 1       seed = let (ebz, seed') = randSelect a1 a2 as seed
                                                 f (Left flag)                 = let (a1', a2') = straightVsReverse a1 a2 flag
                                                                                 in  (([a1'], a2' : as), seed')
                                                 f (Right (before, a', after)) = (([a'], a1 : a2 : (before ++ after)), seed')
                                             in f ebz
randVariateMax (a1 : a2 : as) (k + 2) seed = let (ebz, seed') = randSelect a1 a2 as seed
                                                 f (Left flag)                 = let (a1', a2') = straightVsReverse a1 a2 flag
                                                                                 in  firstFirst (a1' :) $ randVariateMax (a2' : as) (k + 1) seed'
                                                 f (Right (before, a', after)) = firstFirst (a' :) $ randVariateMax (a1 : a2 : (before ++ after)) (k + 1) seed'
                                             in f ebz


type SeedState a = State StdGen a

randomRSM :: (Int, Int) -> SeedState Int
randomRSM = state . randomR

randSelectSM :: a -> a -> [a] -> SeedState (Either Bool (ListZipper_bothNonrev a))
randSelectSM a1 a2 = state . randSelect a1 a2

randPermuteSM :: [a] -> SeedState [a]
randPermuteSM = state . randPermute

randVariateMaxSM :: [a] -> Int -> SeedState ([a], [a])
randVariateMaxSM as k = state $ randVariateMax as k

-- To be built into complicated architecture:

type SeedStateT m a = StateT StdGen m a

-- randIterArch :: Monad m => Int -> (StdGen -> m (a, StdGen)) -> StdGen -> m ([a], StdGen)

-- randIterArchSTM :: Monad m => Int -> SeedStateT m a -> SeedStateT m [a]


-- IO:

randQuery :: Int -> [a] ->  IO [a]
randQuery sampleSize relation = fst . evalState (randVariateMaxSM relation sampleSize) <$> newStdGen
