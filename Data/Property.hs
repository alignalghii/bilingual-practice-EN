module Data.Property where

import Data.List
import Data.Maybe


type PropertyPredicate a = a -> Bool

type PropertyAssignment a b = (a, b)
type PropertyMapping a b = [PropertyAssignment a b]

(*&&*), (*||*) :: PropertyPredicate a -> PropertyPredicate a -> PropertyPredicate a
p *&&* q = \a -> p a && q a
p *||* q = \a -> p a || q a

propertyConjunction, propertyDisjunction :: [PropertyPredicate a] -> PropertyPredicate a
propertyConjunction = foldr (*&&*) $ const True
propertyDisjunction = foldr (*||*) $ const False

mapProperties :: Eq key => PropertyMapping key value -> [key]-> [value]
mapProperties = mapMaybe . flip lookup

makeSelectorProperty :: Eq value => (record -> value) -> value -> PropertyPredicate record
makeSelectorProperty selector value = (== value) . selector

selectorPropertiesConjunction :: (Eq key, Eq value) => (record -> value) -> PropertyMapping key value -> [key] -> PropertyPredicate record
selectorPropertiesConjunction selector mapping keys = propertyDisjunction $ makeSelectorProperty selector <$> mapProperties mapping keys

selectorsPropertyCNF :: (Eq key, Eq value) => PropertyMapping (record -> value) (PropertyMapping key value) -> [key] -> PropertyPredicate record
selectorsPropertyCNF selectorMappings keys = propertyConjunction $ map (flip id keys . uncurry selectorPropertiesConjunction) selectorMappings
