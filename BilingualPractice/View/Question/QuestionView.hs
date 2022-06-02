{-# LANGUAGE OverloadedStrings, NamedFieldPuns #-}

module BilingualPractice.View.Question.QuestionView (questionView) where

import BilingualPractice.Model.Grammar.Numeral (cardinalSuffix_en', pluralSuffix_en')
import Prelude hiding (head, span)
import Text.Blaze.Html5 as H hiding (map, mark)
import Text.Blaze.Html5.Attributes as HA hiding (title, form, span, label)
import Control.Monad (forM_)
import Data.Bool (bool)
import Data.Time


questionView :: Int -> Int -> String -> Html
questionView nth ofAll en = docTypeHtml $ do
    head $ do
        meta ! charset "UTF-8"
        link ! rel "icon" ! href "img/favicon.ico"
        title "English-German word- and sentence practice — Question"
    body $ do
        h1 "English-German word- and sentence practice — Question"
        p $ do
            a ! href "/examen" $ "Restart practice, delete Your former anwers without processing"
            span " ||| "
            a ! href "/" $ "Back to the main page"
        p $ toHtml $ cardinalSuffix_en' nth ++ " question out of " ++ pluralSuffix_en' ofAll "question" ++  ":"
        form ! action "/question" ! method "post" $ do
            label "In English:"
            span $ toHtml en
            br
            label "In German:"
            input ! type_ "hidden" ! name "en" ! value (toValue en)
            input ! type_ "text"   ! name "de" ! autofocus ""
            button ! type_ "submit" $ "Go!"
