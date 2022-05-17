module Controller.HomeController where

import Controller.Base (blaze)
import View.HomeView (homeView)
import Web.Scotty (ActionM)

homeAction :: ActionM ()
homeAction = blaze homeView


