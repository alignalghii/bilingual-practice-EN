{-# LANGUAGE NamedFieldPuns #-}

module BilingualPractice.Model.RelationalBusinessLogic where

import BilingualPractice.Model.Grammar.Numeral (numerals_en, numerals_hu)
import Data.List (zipWith4)
import Data.Bool (bool)


-- TODO: use records with derived Read, Show, Eq

data MainEntity = ME {en, hu, entity, difficulty :: String} deriving (Read, Show)

numeralsTable :: [MainEntity]
numeralsTable = zipWith4 ME numerals_en numerals_hu (repeat "Szó") (repeat "Könnyű")

findTranslation :: String -> [MainEntity] -> String
findTranslation sameEn = hu . head . filter ((== sameEn) . en)

data ConferEntity = CE {dictEn, dictHu, yourHu :: String, flag :: Bool, mark, dictEntity, dictDifficulty :: String}

conferResults :: [MainEntity] -> [MainEntity] -> [ConferEntity]
conferResults etalon personal = map (conferAnswer personal) etalon

conferAnswer :: [MainEntity] -> MainEntity -> ConferEntity
conferAnswer personal ME {en, hu, entity, difficulty} = let yourHu = findTranslation en personal
                                                            flag   = hu == yourHu
                                                            mark   = bool "Rossz" "Jó" flag
                                                        in CE {dictEn = en, dictHu = hu, yourHu, flag, mark, dictEntity = entity, dictDifficulty = difficulty}
