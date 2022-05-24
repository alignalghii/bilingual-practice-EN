{-# LANGUAGE NamedFieldPuns #-}

module BilingualPractice.Model.RelationalBusinessLogic where

import BilingualPractice.Model.Grammar.Numeral (numerals_en, numerals_hu)
import Data.List (zipWith4)
import Data.Bool (bool)


data LexiconEntry = LxcE {en, hu, entity, difficulty :: String} deriving (Read, Show) -- Eq

numeralsTable :: [LexiconEntry]
numeralsTable = zipWith4 LxcE numerals_en numerals_hu (repeat "Szó") (repeat "Könnyű")

findTranslation :: String -> [LexiconEntry] -> String
findTranslation sameEn = hu . head . filter ((== sameEn) . en)

data QuestionAnswerMatch = QuAnsMtch {dictEn, dictHu, yourHu :: String, flag :: Bool, mark, dictEntity, dictDifficulty :: String}

conferPracticeCertificate :: [LexiconEntry] -> [LexiconEntry] -> [QuestionAnswerMatch]
conferPracticeCertificate etalon personal = map (conferAnswer personal) etalon

conferAnswer :: [LexiconEntry] -> LexiconEntry -> QuestionAnswerMatch
conferAnswer personal LxcE {en, hu, entity, difficulty} = let yourHu = findTranslation en personal
                                                              flag   = hu == yourHu
                                                              mark   = bool "Rossz" "Jó" flag
                                                          in QuAnsMtch {dictEn = en, dictHu = hu, yourHu, flag, mark, dictEntity = entity, dictDifficulty = difficulty}
