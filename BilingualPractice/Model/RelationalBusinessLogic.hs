{-# LANGUAGE NamedFieldPuns #-}

module BilingualPractice.Model.RelationalBusinessLogic where

import BilingualPractice.Model.Grammar.Numeral (numerals_en, numerals_hu)
import Data.TimeX (abbrevTimeRead)
import Data.ListX (maybeHead)
import Data.List (zipWith4, (\\))
import Data.Bool (bool)


data LexiconEntry = LxcE {hu, en, entity, difficulty :: String} deriving (Read, Show) -- Eq

numeralsRelation :: [LexiconEntry]
numeralsRelation = zipWith4 LxcE numerals_hu numerals_en  (repeat "Szó") (repeat "Könnyű")

findYourTranslation :: String -> [AnsweredQuestion] -> AnsweredQuestion
findYourTranslation sameHu = head . filter ((== sameHu) . ansHu)

data AnsweredQuestion = AnsQu {ansHu, ansEn, ansTimeStart, ansTimeEnd :: String} deriving (Read, Show) -- Eq

data QuestionAnswerMatch = QuAnsMtch {dictHu, dictEn, yourEn :: String, flag :: Bool, mark, askedAtTime, answeredAtTime, dictEntity, dictDifficulty :: String}

-- Governing a practice by the remaining questions:

withFirstUnansweredQuestionIfAnyOrElse :: (String -> a) -> ([LexiconEntry] -> [AnsweredQuestion] -> a) -> [LexiconEntry] -> [AnsweredQuestion] -> a
withFirstUnansweredQuestionIfAnyOrElse ask summarize etalon personal = maybe (summarize etalon personal)
                                                                              ask
                                                                              (maybeFirstUnansweredQuestion etalon personal)

maybeFirstUnansweredQuestion :: [LexiconEntry] -> [AnsweredQuestion] -> Maybe String
maybeFirstUnansweredQuestion etalon personal = let etalon_questions     = map hu etalon
                                                   answered_questions   = map ansHu personal
                                                   unanswered_questions = etalon_questions \\ answered_questions
                                               in maybeHead unanswered_questions

-- Summarizing a practice result into a user-readable certificate:

conferPracticeCertificate :: [LexiconEntry] -> [AnsweredQuestion] -> [QuestionAnswerMatch]
conferPracticeCertificate etalon personal = map (conferAnswer personal) etalon

conferAnswer :: [AnsweredQuestion] -> LexiconEntry -> QuestionAnswerMatch
conferAnswer personal LxcE {hu, en, entity, difficulty} = let AnsQu {ansEn, ansTimeStart, ansTimeEnd} = findYourTranslation hu personal
                                                              flag   = en == ansEn
                                                              mark   = bool "Rossz" "Jó" flag
                                                          in QuAnsMtch {dictHu = hu, dictEn = en, yourEn = ansEn, flag, mark, askedAtTime = ansTimeStart, answeredAtTime = abbrevTimeRead ansTimeEnd, dictEntity = entity, dictDifficulty = difficulty}
