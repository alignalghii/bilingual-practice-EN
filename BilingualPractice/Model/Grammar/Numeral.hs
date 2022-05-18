module BilingualPractice.Model.Grammar.Numeral where

import BilingualPractice.Model.Grammar.Phonology (paradigmCombine, paradigmCombineSep)


numerals_table :: [(String, String)]
numerals_table = zip numerals_en numerals_hu

numerals_hu, numerals_en :: [String]
numerals_hu = concat $ (zero_hu : ones_hu) : zipWith (:) tens_hu (paradigmCombine tensAnd_hu ones_hu)
numerals_en = concat $ (zero_en : ones_en) : zipWith (:) tens_en (teens_en : paradigmCombineSep "-" (tail tens_en) ones_en)

zero_hu, zero_en, hundred_hu, hundred_en :: String
zero_hu = "nulla"
zero_en = "zero"
hundred_hu = "száz"
hundred_en = "hundred"

ones_hu, tens_hu, tensAnd_hu, ones_en, tens_en, teens_en :: [String]

ones_hu = ["egy", "kettő", "három", "négy", "öt", "hat", "hét", "nyolc", "kilenc"]
tens_hu = ["tíz", "húsz", "harminc", "negyven", "ötven", "hatvan", "hetven", "nyolcvan", "kilencven"]
tensAnd_hu = ["tizen", "huszon", "harminc", "negyven", "ötven", "hatvan", "hetven", "nyolcvan", "kilencven"]

ones_en = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
tens_en = ["ten", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"]
teens_en = ["eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"]
