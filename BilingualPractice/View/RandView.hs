{-# LANGUAGE OverloadedStrings #-}

module BilingualPractice.View.RandView (randView) where

import Prelude hiding (head, span)
import Text.Blaze.Html5 as H hiding (map)
import Text.Blaze.Html5.Attributes as HA hiding (title, form, span)
import Control.Monad (forM_)

randView :: [(String, String, String, String)] -> Html
randView records = docTypeHtml $ do
    head $ do
        meta ! charset "UTF-8"
        link ! rel "icon" ! href "img/favicon.ico"
        title "Magyar-angol szó- és mondatgyakorló — Véletlen kiválasztás"
    body $ do
        h1 "Magyar-angol szó- és mondatgyakorló — Véletlen kiválasztás"
        p $
            a ! href "/" $ "Vissza a főoldalra"
        table $ do
            tr $ do
                th "Angol"
                th "Magyar"
                th "Szó vagy mondat?"
                th "Nehézségi szint"
            forM_ records $ \(en, hu, entity, difficulty) -> do
                tr $ do
                    td $ toHtml en
                    td $ toHtml hu
                    td $ toHtml entity
                    td $ toHtml difficulty
