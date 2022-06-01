module Data.ReflectionX where


allInhabitants :: (Enum a, Bounded a) => [a]
allInhabitants = enumFrom minBound

fieldInhabitants :: (Bounded a, Enum a) =>  (record -> a) -> [a]
fieldInhabitants = const allInhabitants
