{-# LANGUAGE NamedFieldPuns #-}

module BilingualPractice.Model.RelationalBusinessLogic where

import BilingualPractice.Model.Grammar.Numeral (numerals_en, numerals_hu)
import Data.TimeX (abbrevTimeRead)
import Data.ListX (maybeHead)
import Data.List (zipWith4, (\\))
import Data.Bool (bool)


data LexiconEntry = LxcE {en, hu, entity, difficulty :: String} deriving (Read, Show) -- Eq

numeralsRelation :: [LexiconEntry]
numeralsRelation = zipWith4 LxcE numerals_en numerals_hu (repeat "Szó") (repeat "Könnyű")

findYourTranslation :: String -> [AnsweredQuestion] -> AnsweredQuestion
findYourTranslation sameEn = head . filter ((== sameEn) . ansEn)

data AnsweredQuestion = AnsQu {ansEn, ansHu, ansTimeStart, ansTimeEnd :: String} deriving (Read, Show) -- Eq

data QuestionAnswerMatch = QuAnsMtch {dictEn, dictHu, yourHu :: String, flag :: Bool, mark, askedAtTime, answeredAtTime, dictEntity, dictDifficulty :: String}

-- Governing a practice by the remaining questions:

withFirstUnansweredQuestionIfAnyOrElse :: (String -> a) -> ([LexiconEntry] -> [AnsweredQuestion] -> a) -> [LexiconEntry] -> [AnsweredQuestion] -> a
withFirstUnansweredQuestionIfAnyOrElse ask summarize etalon personal = maybe (summarize etalon personal)
                                                                              ask
                                                                              (maybeFirstUnansweredQuestion etalon personal)

maybeFirstUnansweredQuestion :: [LexiconEntry] -> [AnsweredQuestion] -> Maybe String
maybeFirstUnansweredQuestion etalon personal = let etalon_questions     = map en etalon
                                                   answered_questions   = map ansEn personal
                                                   unanswered_questions = etalon_questions \\ answered_questions
                                               in maybeHead unanswered_questions

-- Summarizing a practice result into a user-readable certificate:

conferPracticeCertificate :: [LexiconEntry] -> [AnsweredQuestion] -> [QuestionAnswerMatch]
conferPracticeCertificate etalon personal = map (conferAnswer personal) etalon

conferAnswer :: [AnsweredQuestion] -> LexiconEntry -> QuestionAnswerMatch
conferAnswer personal LxcE {en, hu, entity, difficulty} = let AnsQu {ansHu, ansTimeStart, ansTimeEnd} = findYourTranslation en personal
                                                              flag   = hu == ansHu
                                                              mark   = bool "Rossz" "Jó" flag
                                                          in QuAnsMtch {dictEn = en, dictHu = hu, yourHu = ansHu, flag, mark, askedAtTime = ansTimeStart, answeredAtTime = abbrevTimeRead ansTimeEnd, dictEntity = entity, dictDifficulty = difficulty}
