module BilingualPractice.Controller.HomeController where

import BilingualPractice.Controller.Base (blaze)
import BilingualPractice.Model.Grammar.Numeral (numeralsTable)
import BilingualPractice.View.HomeView (homeView)
import BilingualPractice.View.DumpView (dumpView)
import Web.Scotty (ActionM)

homeAction :: ActionM ()
homeAction = blaze homeView

dumpAction :: ActionM ()
dumpAction = blaze $ dumpView numeralsTable


