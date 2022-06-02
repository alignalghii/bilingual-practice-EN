{-# LANGUAGE OverloadedStrings, NamedFieldPuns #-}

module BilingualPractice.View.Home.DumpView (dumpView) where

import BilingualPractice.Model.RelationalBusinessLogic (LexiconEntry (..))
import BilingualPractice.Model.ViewModel (view)
import Prelude hiding (head)
import Text.Blaze.Html5 as H hiding (map)
import Text.Blaze.Html5.Attributes as HA hiding (title, span, form)
import Control.Monad (forM_)

dumpView :: [LexiconEntry] -> Html
dumpView vocabularyData = docTypeHtml $ do
    head $ do
        meta ! charset "UTF-8"
        link ! rel "icon" ! href "img/favicon.ico"
        link ! rel "stylesheet" ! href "style/table.css"
        title "English-German word- and sentence practice — Dumping whole lexicon"
    body $ do
        h1 "English-German word- and sentence practice — Dumping whole lexicon"
        p $
            a ! href "/" $ "Back to the main page"
        table $ do
            tr $ do
                th "English"
                th "German"
                th "Word or sentence?"
                th "Difficulty level"
            forM_ vocabularyData $ \ LxcE {en, de, entity, difficulty} -> do
                tr $ do
                    td $ toHtml en
                    td $ toHtml de
                    td $ toHtml $ view entity
                    td $ toHtml $ view difficulty
