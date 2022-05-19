module Data.ListX where

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

selectByFlags :: [(a, Bool)] -> [a]
selectByFlags = mapMaybe $ uncurry (flip toMaybe)
