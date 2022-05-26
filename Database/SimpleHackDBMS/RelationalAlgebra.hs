module Database.SimpleHackDBMS.RelationalAlgebra where

import Data.Maybe.HT (toMaybe)
import Data.Maybe (mapMaybe)
import Data.ListX (descartesProduct2)


naturalJoin :: Eq a => (r1 -> (r1', a)) -> (r2 -> (r2', a)) -> ((r1', a, r2') -> r) -> [r1] -> [r2] -> [r]
naturalJoin split1 split2 fuse r1s r2s = mapMaybe (uncurry joining) $ descartesProduct2 r1s r2s where
    joining r1 r2 = let (r1', a1) = split1 r1
                        (r2', a2) = split2 r2
                    in toMaybe (a1 == a2) $ fuse (r1', a1, r2')
