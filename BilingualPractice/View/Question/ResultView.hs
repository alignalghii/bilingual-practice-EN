{-# LANGUAGE OverloadedStrings, NamedFieldPuns #-}

module BilingualPractice.View.Question.ResultView (resultView) where

import BilingualPractice.Model.ViewModel (QuestionAnswerMatchView (..))
import Prelude hiding (head, span)
import Text.Blaze.Html5 as H hiding (map, mark)
import Text.Blaze.Html5.Attributes as HA hiding (title, form, span, label)
import Control.Monad (forM_)
import Data.Bool (bool)
import Data.Time


resultView :: [QuestionAnswerMatchView] -> Html
resultView confer = docTypeHtml $ do
    head $ do
        meta ! charset "UTF-8"
        link ! rel "icon" ! href "img/favicon.ico"
        link ! rel "stylesheet" ! href "style/table.css"
        title "English-German word- and sentence practice — Announcing results"
    body $ do
        h1 "English-German word- and sentence practice — Announcing results"
        p $ do
            a ! href "/examen" $ "New practice"
            span " ||| "
            a ! href "/" $ "Back to the main page"
        table $ do
            tr $ do
                th "English"
                th "German"
                th "Your answer"
                th "Is it O.K. or wrong?"
                th "Time of asking the question"
                th "Time of receiving Your answer"
                th "Word or sentence?"
                th "Difficulty level"
            forM_ confer $ \QuAnsMtchVw {dictEnView, dictDeView, yourDeView, markView = (markMsg, markStl), askedAtTimeView, answeredAtTimeView, dictEntityView, dictDifficultyView} -> do
                tr $ do
                    td $ toHtml dictEnView
                    td $ toHtml dictDeView
                    td ! class_ (toValue markStl) $ toHtml yourDeView
                    td $ toHtml markMsg
                    td $ toHtml $ askedAtTimeView
                    td $ toHtml $ answeredAtTimeView
                    td $ toHtml dictEntityView
                    td $ toHtml dictDifficultyView
