module  BilingualPractice.Model.Grammar.ParadigmCombination where

import Data.ListX (descartesProduct2With, matrixSpanned2With)
import Data.Monoid (Monoid, (<>))

wordCombine :: Monoid a => [a] -> [a] -> [a]
wordCombine = descartesProduct2With (<>)

wordCombineSep :: Monoid a => a -> [a] -> [a] -> [a]
wordCombineSep sep = descartesProduct2With $ separate sep

separate, parenthesize :: Monoid a => a -> a -> a -> a
separate    sep as1 as2 = as1 <> sep  <> as2
parenthesize op cl stem = op  <> stem <> cl

paradigmCombine :: Monoid a => [a] -> [a] -> [[a]]
paradigmCombine = matrixSpanned2With (<>)

paradigmCombineSep :: Monoid a => a -> [a] -> [a] -> [[a]]
paradigmCombineSep sep = matrixSpanned2With (separate sep)
