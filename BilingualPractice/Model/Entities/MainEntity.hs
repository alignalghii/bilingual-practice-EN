module BilingualPractice.Model.Entities.MainEntity where

import Data.Bool (bool)


-- TODO: use records with derived Read, Show, Eq

type MainEntity = (String, String, String, String)

project_en, project_hu, project_entity, project_difficulty :: MainEntity -> String
project_en         (en, _, _    , _         ) = en
project_hu         (_, hu, _    , _         ) = hu
project_entity     (_, _, entity, _         ) = entity
project_difficulty (_, _, _     , difficulty) = difficulty

findTranslation :: String -> [MainEntity] -> String
findTranslation en = project_hu . head . filter ((== en) . project_en)

type ConferEntity = (String, String, String, Bool, String, String, String)

conferResults :: [MainEntity] -> [MainEntity] -> [ConferEntity]
conferResults etalon personal = map (conferAnswer personal) etalon

conferAnswer :: [MainEntity] -> MainEntity -> ConferEntity
conferAnswer personal (en, hu, entity, difficulty) = let yourHu = findTranslation en personal
                                                         flag   = hu == yourHu
                                                         mark   = bool "Rossz" "Jó" flag
                                                     in  (en, hu, yourHu, flag, mark, entity, difficulty)
