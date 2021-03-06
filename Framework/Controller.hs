-- @TODO Move from BilingualPractice.Controller to Framework

module Framework.Controller where

import Web.Scotty (ActionM, html)
import Text.Blaze.Html5 (Html)
import Text.Blaze.Html.Renderer.Pretty (renderHtml)
import Data.Text.Lazy (Text, pack)

blaze :: Html -> ActionM ()
blaze = html . pack . renderHtml
