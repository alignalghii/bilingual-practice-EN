{-# LANGUAGE OverloadedStrings #-}

module BilingualPractice.View.Practice.ExamenView (examenView) where

import Prelude hiding (head, span, min, max)
import Text.Blaze.Html5 as H hiding (map)
import Text.Blaze.Html5.Attributes as HA hiding (title, form, span, label)
import Control.Monad (forM_)

examenView :: Html
examenView = docTypeHtml $ do
    head $ do
        meta ! charset "UTF-8"
        link ! rel "icon" ! href "img/favicon.ico"
        link ! rel "stylesheet" ! href "style/form.css"
        title "Magyar-angol szó- és mondatgyakorló — Gyakorlóvizsga (kérdéssor)"
    body $ do
        h1 "Magyar-angol szó- és mondatgyakorló — Gyakorlóvizsga (kérdéssor)"
        p $ do
            a ! href "/" $ "Vissza a főoldalra"
        form ! action "/examen" ! method "post" $ do
            p "Új gyakorlóvizsga indulhat? (A régi válaszaid, ha vannak, törlődnek.)"
            label "Ennyi kérdésből álljon a gyakorlat:"
            input ! type_ "number" ! class_ "smallnum" ! min "1" ! max "30" ! name "number_of_questions" ! value "5"
            button ! type_ "submit" $ "Mehet"

