{-# LANGUAGE NamedFieldPuns #-}

module BilingualPractice.Model.RelationalBusinessLogic where

import BilingualPractice.Model.Grammar.Numeral (numerals_en, numerals_de)
import Data.Time (UTCTime)
import Data.ListX (maybeHead)
import Data.List (zipWith4, (\\))
import Data.Bool (bool)


data LinguisticalUnit = LUNumber | LUWord | LUSentence deriving (Eq, Read, Show, Bounded, Enum)

data Difficulty = Easy | Difficult deriving (Eq, Read, Show, Bounded, Enum)

data LexiconEntry = LxcE {en, de :: String, entity :: LinguisticalUnit, difficulty :: Difficulty} deriving (Read, Show) -- Eq

numeralsRelation :: [LexiconEntry]
numeralsRelation = zipWith4 LxcE numerals_en numerals_de  (repeat LUNumber) (repeat Easy)

findYourTranslation :: String -> [AnsweredQuestion] -> AnsweredQuestion
findYourTranslation sameEn = head . filter ((== sameEn) . ansEn)

data AnsweredQuestion = AnsQu {ansEn, ansDe :: String, ansTimeStart, ansTimeEnd :: UTCTime} deriving (Read, Show) -- Eq

data QuestionAnswerMatch = QuAnsMtch {dictEn, dictDe, yourDe :: String, mark :: Bool, askedAtTime, answeredAtTime :: UTCTime, dictEntity :: LinguisticalUnit, dictDifficulty :: Difficulty}

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
conferAnswer personal LxcE {en, de, entity, difficulty} = let AnsQu {ansDe, ansTimeStart, ansTimeEnd} = findYourTranslation en personal
                                                              mark   = de == ansDe
                                                          in QuAnsMtch {dictEn = en, dictDe = de, yourDe = ansDe, mark, askedAtTime = ansTimeStart, answeredAtTime = ansTimeEnd, dictEntity = entity, dictDifficulty = difficulty}
