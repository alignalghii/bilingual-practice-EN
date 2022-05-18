module Bilingual.Model.Grammar.Numeral where

ones_hu, tens_hu, tensAnd_hu, ones_en, tens_en, teens_en :: [String]

ones_hu = ["egy", "kettő", "három", "négy", "öt", "hat", "hét", "nyolc", "kilenc"]
tens_hu = ["tíz", "húsz", "harminc", "negyven", "ötven", "hatvan", "hetven", "nyolcvan", "kilencven"]
tensAnd_hu = ["tizen", "huszon", "harminc", "negyven", "ötven", "hatvan", "hetven", "nyolcvan", "kilencven"]

ones_en = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
tens_en = ["ten", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"]
teens_en = ["eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"]

hundred_hu, hundred_en :: String
hundred_hu = "száz"
hundred_en = "hundred"
