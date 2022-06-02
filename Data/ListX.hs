{-# LANGUAGE NPlusKPatterns #-}

module Data.ListX where

import Data.List.HT (viewL)
import Data.Maybe.HT (toMaybe)
import Data.Maybe (mapMaybe)


descartesProduct2 :: [a] -> [b] -> [(a, b)]
descartesProduct2 = descartesProduct2With (,)

descartesProduct2With :: (a -> b -> c) -> [a] -> [b] -> [c]
descartesProduct2With f as bs  = concat $ matrixSpanned2With f as bs

matrixSpanned2 :: [a] -> [b] -> [[(a, b)]]
matrixSpanned2 = matrixSpanned2With (,)

matrixSpanned2With :: (a -> b -> c) -> [a] -> [b] -> [[c]]
matrixSpanned2With f as bs = do
    a <- as
    return $ f a <$> bs

matrixSpanned2With_altLexOrd :: (a -> b -> c) -> [a] -> [b] -> [[c]]
matrixSpanned2With_altLexOrd = flip . matrixSpanned2With . flip

selectByFlags :: [(a, Bool)] -> [a]
selectByFlags = mapMaybe $ uncurry (flip toMaybe)

-- A kind of modified zipper related function:

type ListZipper_bothNonrev a = ([a], a, [a])

select :: Int -> [a] -> Maybe (ListZipper_bothNonrev a)
select _       []       = Nothing
select 0       (a : as) = Just ([], a, as)
select (i + 1) (a : as) = havingPassed a <$> select i as

havingPassed :: a -> ListZipper_bothNonrev a -> ListZipper_bothNonrev a
havingPassed a (before, a', after) = (a : before, a', after)


maybeHead :: [a] -> Maybe a
maybeHead = fmap fst . viewL

insertAfter :: [a] -> a -> [a]
insertAfter as a = as ++ [a] -- not efficient

uncurry4 :: (a1 -> a2 -> a3 -> a4 -> a') -> (a1, a2, a3, a4) -> a'
uncurry4 f (a1, a2, a3, a4) = f a1 a2 a3 a4
