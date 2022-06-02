module BilingualPractice.Model.Grammar.Numeral where

import BilingualPractice.Model.Grammar.ParadigmCombination (paradigmCombine, paradigmCombineSep, paradigmCombineSep_altLexOrd)
import Data.List (zip4)


numerals_de, numerals_en :: [String]
numerals_de = concat $ (zero_de : ones_de) : zipWith (:) tens_de (teens_de : paradigmCombineSep_altLexOrd "und" andOnes_de (tail tens_de))
numerals_en = concat $ (zero_en : ones_en) : zipWith (:) tens_en (teens_en : paradigmCombineSep "-" (tail tens_en) ones_en)

zero_de, zero_en, hundred_de, hundred_en :: String
zero_de = "null"
zero_en = "zero"
hundred_de = "hundert"
hundred_en = "hundred"

ones_de, tens_de, teens_de, andOnes_de, ones_en, tens_en, teens_en :: [String]
ones_de    = ["eins", "zwei", "drei", "vier", "fünf", "sechs", "sieben", "acht", "neun"]
tens_de    = ["zehn", "zwanzig", "dreißig", "vierzig", "fünfzig", "sechzig", "siebzig", "achtzig", "neunzig"]
teens_de   = ["elf", "zwölf", "dreizehn", "vierzehn", "fünfzehn", "sechzehn", "siebzehn", "achtzehn", "neunzehn"]
andOnes_de = ["ein", "zwei", "drei", "vier", "fünf", "sechs", "sieben", "acht", "neun"]

ones_en = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
tens_en = ["ten", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"]
teens_en = ["eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"]

cardinalSuffix_en' :: Int -> String
cardinalSuffix_en' n = show n ++ cardinalSuffix_en n

pluralSuffix_en' :: Int -> ShowS
pluralSuffix_en' n word = concat [show n, " ", word, pluralSuffix_en n]

cardinalSuffix_en, pluralSuffix_en :: Int -> String
cardinalSuffix_en n = ("th" : "st" : "nd" : "rd" : repeat "th") !! n
pluralSuffix_en   n = ("s" : "" : "s" : repeat "s") !! n
