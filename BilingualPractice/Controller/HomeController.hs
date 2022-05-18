module BilingualPractice.Controller.HomeController where

import BilingualPractice.Controller.Base (blaze)
import BilingualPractice.View.HomeView (homeView)
import Web.Scotty (ActionM)

homeAction :: ActionM ()
homeAction = blaze homeView


