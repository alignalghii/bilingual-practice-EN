{-# LANGUAGE NamedFieldPuns #-}

module BilingualPractice.Model.ViewModel where

import BilingualPractice.Model.RelationalBusinessLogic (QuestionAnswerMatch (..), LinguisticalUnit (..), Difficulty (..))
import Framework.Form (FormParamable (formParam))
import Data.TimeX (abbrevTime)
import Data.Bool (bool)


class Viewable a where
    view :: a -> String

instance Viewable LinguisticalUnit where
    view LUNumber   = "number"
    view LUWord     = "word"
    view LUSentence = "sentence"

instance Viewable Difficulty where
    view Easy      = "easy"
    view Difficult = "difficult"


instance FormParamable LinguisticalUnit where
    formParam LUNumber   = "number"
    formParam LUWord     = "word"
    formParam LUSentence = "sentence"

instance FormParamable Difficulty where
    formParam Easy      = "easy"
    formParam Difficult = "difficult"


data QuestionAnswerMatchView = QuAnsMtchVw {dictEnView, dictDeView, yourDeView :: String, markView :: (String, String), askedAtTimeView, answeredAtTimeView, dictEntityView, dictDifficultyView :: String}

viewMatch :: QuestionAnswerMatch -> QuestionAnswerMatchView
viewMatch QuAnsMtch {dictEn, dictDe, yourDe, mark, askedAtTime, answeredAtTime, dictEntity, dictDifficulty} = QuAnsMtchVw {dictEnView = dictEn, dictDeView = dictDe, yourDeView = yourDe, markView = viewMark mark, askedAtTimeView = abbrevTime askedAtTime, answeredAtTimeView = abbrevTime answeredAtTime, dictEntityView = view dictEntity, dictDifficultyView = view dictDifficulty}


viewMark :: Bool -> (String, String)
viewMark = bool ("Wrong", "wrong") ("O.K.", "ok")
