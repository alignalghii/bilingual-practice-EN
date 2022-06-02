{-# LANGUAGE OverloadedStrings #-}

module BilingualPractice.View.Practice.ExamenView (examenView) where

import Prelude hiding (head, div, span, min, max)
import Text.Blaze.Html5 as H hiding (map)
import Text.Blaze.Html5.Attributes as HA hiding (title, form, span, label)
import Control.Monad (forM_)

examenView :: Html
examenView = docTypeHtml $ do
    head $ do
        meta ! charset "UTF-8"
        link ! rel "icon" ! href "img/favicon.ico"
        link ! rel "stylesheet" ! href "style/form.css"
        title "English-German word- and sentence practice — Practice (series of questions)"
    body $ do
        h1 "English-German word- and sentence practice — Practice (series of questions)"
        p $ do
            a ! href "/" $ "Back to the main page"
        form ! action "/examen" ! method "post" $ do
            div "Start a new practice (delete Your former anwers without processing, if there are any)"
            label "The practice should consist of that  many questions:"
            input ! type_ "number" ! class_ "smallnum" ! min "1" ! max "30" ! name "number_of_questions" ! value "5"
            div "What should we practice: numbers, words or sentences?"
            ul $ do
                li $ do
                    input ! type_ "checkbox" ! name "number" ! checked ""
                    label "Number"
                li $ do
                    input ! type_ "checkbox" ! name "word" ! checked ""
                    label "Word"
                li $ do
                    input ! type_ "checkbox" ! name "sentence" ! checked ""
                    label "Sentence"
            div "On what difficulty level?"
            ul $ do
                li $ do
                    input ! type_ "checkbox" ! name "easy" ! checked ""
                    label "Easy"
                li $ do
                    input ! type_ "checkbox" ! name "difficult" ! checked ""
                    label "Difficult"
            button ! type_ "submit" $ "Go!"
