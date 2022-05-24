{-# LANGUAGE OverloadedStrings, NamedFieldPuns #-}

module BilingualPractice.View.RandView (randView) where

import BilingualPractice.Model.RelationalBusinessLogic (MainEntity (..))
import Prelude hiding (head, span)
import Text.Blaze.Html5 as H hiding (map)
import Text.Blaze.Html5.Attributes as HA hiding (title, form, span)
import Control.Monad (forM_)

randView :: [MainEntity] -> Html
randView records = docTypeHtml $ do
    head $ do
        meta ! charset "UTF-8"
        link ! rel "icon" ! href "img/favicon.ico"
        link ! rel "stylesheet" ! href "style/table.css"
        title "Magyar-angol szó- és mondatgyakorló — Véletlen kiválasztás"
    body $ do
        h1 "Magyar-angol szó- és mondatgyakorló — Véletlen kiválasztás"
        p $ do
            a ! href "/rand" $ "Újraválogatás"
            span " ||| "
            a ! href "/" $ "Vissza a főoldalra"
        table $ do
            tr $ do
                th "Angol"
                th "Magyar"
                th "Szó vagy mondat?"
                th "Nehézségi szint"
            forM_ records $ \ ME {en, hu, entity, difficulty} -> do
                tr $ do
                    td $ toHtml en
                    td $ toHtml hu
                    td $ toHtml entity
                    td $ toHtml difficulty
