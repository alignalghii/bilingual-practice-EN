{-# LANGUAGE OverloadedStrings #-}

module BilingualPractice.View.Home.HomeView (homeView) where

import Prelude hiding (head, span)
import Text.Blaze.Html5 as H hiding (map)
import Text.Blaze.Html5.Attributes as HA hiding (title, form, span)
import Data.Bool (bool)

homeView :: Html
homeView = docTypeHtml $ do
    head $ do
        meta ! charset "UTF-8"
        link ! rel "icon" ! href "img/favicon.ico"
        title "English-German word- and sentence practice"
    body $ do
        h1 "English-German word- and sentence practice"
        ul $ do
            li $ do
                a ! href "/dump" $ "Dumping whole lexicon"
                span "(for admins and developers)"
            li $ do
                a ! href "/rand" $ "Random selection"
                span "(also a developer-only functionality to test the correctness of randomizings)"
            li $ do
                a ! href "/examen" $ "Begin a practice out of randomly selected questions:"
                span "The real functionality for users: knowledge quiz test, interactive practice: series of questions"
