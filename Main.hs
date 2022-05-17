{-# LANGUAGE OverloadedStrings #-}

module Main (main) where

import Web.Scotty as S
import Prelude hiding (head)
import Data.Text.Lazy (Text, pack)
import Text.Blaze.Html5 as H hiding (map, param, main)
import Text.Blaze.Html5.Attributes as HA hiding (title, span, form)
import Text.Blaze.Html.Renderer.Pretty
import Network.Wai.Middleware.RequestLogger (logStdoutDev)
import Network.Wai.Middleware.Static (staticPolicy, (>->), noDots, addBase)

blaze :: Html -> ActionM ()
blaze = S.html . pack . renderHtml

main :: IO ()
main = scotty 3000 router

router :: ScottyM ()
router = do
    middleware $ staticPolicy (noDots >-> addBase "static")
    middleware logStdoutDev
    get "/" homeAction


homeAction :: ActionM ()
homeAction = blaze homeView

homeView :: Html
homeView = docTypeHtml $ do
    head $ do
        meta ! charset "UTF-8"
        link ! rel "icon" ! href "img/favicon.ico"
        title "Magyar-angol szó- és mondatgyakorló"
    H.body $ do
        h1 "Magyar-angol szó- és mondatgyakorló"
        img ! src "img/favicon.png"
