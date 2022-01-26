DROP MATERIALIZED VIEW IF EXISTS impact_commodity_aggregation;
CREATE MATERIALIZED VIEW impact_commodity_aggregation as

-- Calcium
    -- rank top 5 commodities for Calcium
    SELECT 'Ca' AS nutrient
        , country
        , scenario
        , commodity
        , year
        , calcium / 365 AS value
        , rank 
        FROM (
            SELECT year, scenario, impact_commodity.name AS commodity, country, calcium, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by calcium DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
        ) ranked_scores
    WHERE rank <=5
    UNION
    -- aggregate remaining commodities
    SELECT 'Ca' AS nutrient
        , country
        , scenario
        , 'Other' AS commodity
        , year
        , sum(calcium) / 365 AS value
        , 6 AS rank 
        FROM (
            SELECT year, scenario, commodity, country, calcium, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by calcium DESC) AS rank 
                FROM impact_food_availability
        ) ranked_scores
    WHERE rank >5 GROUP BY country, scenario, year
--  End Calcium
UNION
-- folate
    -- rank top 5 commodities for folate
    SELECT 'folate' AS nutrient
        , country
        , scenario
        , commodity
        , year
        , folate / 365 AS value
        , rank 
        FROM (
            SELECT year, scenario, impact_commodity.name AS commodity, country, folate, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by folate DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
        ) ranked_scores
    WHERE rank <=5
    UNION
    -- aggregate remaining commodities
    SELECT 'folate' AS nutrient
        , country
        , scenario
        , 'Other' AS commodity
        , year
        , sum(folate) / 365 AS value
        , 6 AS rank 
        FROM (
            SELECT year, scenario, commodity, country, folate, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by folate DESC) AS rank 
                FROM impact_food_availability
        ) ranked_scores
    WHERE rank >5 GROUP BY country, scenario, year
--  End folate
UNION
-- iron
    -- rank top 5 commodities for iron
    SELECT 'Fe' AS nutrient
        , country
        , scenario
        , commodity
        , year
        , iron / 365 AS value
        , rank 
        FROM (
            SELECT year, scenario, impact_commodity.name AS commodity, country, iron, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by iron DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
        ) ranked_scores
    WHERE rank <=5
    UNION
    -- aggregate remaining commodities
    SELECT 'Fe' AS nutrient
        , country
        , scenario
        , 'Other' AS commodity
        , year
        , sum(iron) / 365 AS value
        , 6 AS rank 
        FROM (
            SELECT year, scenario, commodity, country, iron, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by iron DESC) AS rank 
                FROM impact_food_availability
        ) ranked_scores
    WHERE rank >5 GROUP BY country, scenario, year
--  End iron
UNION
-- magnesium
    -- rank top 5 commodities for magnesium
    SELECT 'Mg' AS nutrient
        , country
        , scenario
        , commodity
        , year
        , magnesium / 365 AS value
        , rank 
        FROM (
            SELECT year, scenario, impact_commodity.name AS commodity, country, magnesium, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by magnesium DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
        ) ranked_scores
    WHERE rank <=5
    UNION
    -- aggregate remaining commodities
    SELECT 'Mg' AS nutrient
        , country
        , scenario
        , 'Other' AS commodity
        , year
        , sum(magnesium) / 365 AS value
        , 6 AS rank 
        FROM (
            SELECT year, scenario, commodity, country, magnesium, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by magnesium DESC) AS rank 
                FROM impact_food_availability
        ) ranked_scores
    WHERE rank >5 GROUP BY country, scenario, year
--  End magnesium
UNION
-- niacin
    -- rank top 5 commodities for niacin
    SELECT 'B3' AS nutrient
        , country
        , scenario
        , commodity
        , year
        , niacin / 365 AS value
        , rank 
        FROM (
            SELECT year, scenario, impact_commodity.name AS commodity, country, niacin, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by niacin DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
        ) ranked_scores
    WHERE rank <=5
    UNION
    -- aggregate remaining commodities
    SELECT 'B3' AS nutrient
        , country
        , scenario
        , 'Other' AS commodity
        , year
        , sum(niacin) / 365 AS value
        , 6 AS rank 
        FROM (
            SELECT year, scenario, commodity, country, niacin, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by niacin DESC) AS rank 
                FROM impact_food_availability
        ) ranked_scores
    WHERE rank >5 GROUP BY country, scenario, year
--  End niacin
UNION
-- phosphorus
    -- rank top 5 commodities for phosphorus
    SELECT 'P' AS nutrient
        , country
        , scenario
        , commodity
        , year
        , phosphorus / 365 AS value
        , rank 
        FROM (
            SELECT year, scenario, impact_commodity.name AS commodity, country, phosphorus, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by phosphorus DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
        ) ranked_scores
    WHERE rank <=5
    UNION
    -- aggregate remaining commodities
    SELECT 'P' AS nutrient
        , country
        , scenario
        , 'Other' AS commodity
        , year
        , sum(phosphorus) / 365 AS value
        , 6 AS rank 
        FROM (
            SELECT year, scenario, commodity, country, phosphorus, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by phosphorus DESC) AS rank 
                FROM impact_food_availability
        ) ranked_scores
    WHERE rank >5 GROUP BY country, scenario, year
--  End phosphorus
UNION
-- potassium
    -- rank top 5 commodities for potassium
    SELECT 'K' AS nutrient
        , country
        , scenario
        , commodity
        , year
        , potassium / 365 AS value
        , rank 
        FROM (
            SELECT year, scenario, impact_commodity.name AS commodity, country, potassium, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by potassium DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
        ) ranked_scores
    WHERE rank <=5
    UNION
    -- aggregate remaining commodities
    SELECT 'K' AS nutrient
        , country
        , scenario
        , 'Other' AS commodity
        , year
        , sum(potassium) / 365 AS value
        , 6 AS rank 
        FROM (
            SELECT year, scenario, commodity, country, potassium, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by potassium DESC) AS rank 
                FROM impact_food_availability
        ) ranked_scores
    WHERE rank >5 GROUP BY country, scenario, year
--  End potassium
UNION
-- protein
    -- rank top 5 commodities for protein
    SELECT 'Protein' AS nutrient
        , country
        , scenario
        , commodity
        , year
        , protein / 365 AS value
        , rank 
        FROM (
            SELECT year, scenario, impact_commodity.name AS commodity, country, protein, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by protein DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
        ) ranked_scores
    WHERE rank <=5
    UNION
    -- aggregate remaining commodities
    SELECT 'Protein' AS nutrient
        , country
        , scenario
        , 'Other' AS commodity
        , year
        , sum(protein) / 365 AS value
        , 6 AS rank 
        FROM (
            SELECT year, scenario, commodity, country, protein, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by protein DESC) AS rank 
                FROM impact_food_availability
        ) ranked_scores
    WHERE rank >5 GROUP BY country, scenario, year
--  End protein
UNION
-- riboflavin
    -- rank top 5 commodities for riboflavin
    SELECT 'B2' AS nutrient
        , country
        , scenario
        , commodity
        , year
        , riboflavin / 365 AS value
        , rank 
        FROM (
            SELECT year, scenario, impact_commodity.name AS commodity, country, riboflavin, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by riboflavin DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
        ) ranked_scores
    WHERE rank <=5
    UNION
    -- aggregate remaining commodities
    SELECT 'B2' AS nutrient
        , country
        , scenario
        , 'Other' AS commodity
        , year
        , sum(riboflavin) / 365 AS value
        , 6 AS rank 
        FROM (
            SELECT year, scenario, commodity, country, riboflavin, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by riboflavin DESC) AS rank 
                FROM impact_food_availability
        ) ranked_scores
    WHERE rank >5 GROUP BY country, scenario, year
--  End riboflavin
UNION
-- thiamin
    -- rank top 5 commodities for thiamin
    SELECT 'B1' AS nutrient
        , country
        , scenario
        , commodity
        , year
        , thiamin / 365 AS value
        , rank 
        FROM (
            SELECT year, scenario, impact_commodity.name AS commodity, country, thiamin, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by thiamin DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
        ) ranked_scores
    WHERE rank <=5
    UNION
    -- aggregate remaining commodities
    SELECT 'B1' AS nutrient
        , country
        , scenario
        , 'Other' AS commodity
        , year
        , sum(thiamin) / 365 AS value
        , 6 AS rank 
        FROM (
            SELECT year, scenario, commodity, country, thiamin, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by thiamin DESC) AS rank 
                FROM impact_food_availability
        ) ranked_scores
    WHERE rank >5 GROUP BY country, scenario, year
--  End thiamin
UNION
-- vit_a
    -- rank top 5 commodities for vit_a
    SELECT 'A' AS nutrient
        , country
        , scenario
        , commodity
        , year
        , vit_a / 365 AS value
        , rank 
        FROM (
            SELECT year, scenario, impact_commodity.name AS commodity, country, vit_a, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by vit_a DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
        ) ranked_scores
    WHERE rank <=5
    UNION
    -- aggregate remaining commodities
    SELECT 'A' AS nutrient
        , country
        , scenario
        , 'Other' AS commodity
        , year
        , sum(vit_a) / 365 AS value
        , 6 AS rank 
        FROM (
            SELECT year, scenario, commodity, country, vit_a, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by vit_a DESC) AS rank 
                FROM impact_food_availability
        ) ranked_scores
    WHERE rank >5 GROUP BY country, scenario, year
--  End vit_a
UNION
-- vit_b6
    -- rank top 5 commodities for vit_b6
    SELECT 'B6' AS nutrient
        , country
        , scenario
        , commodity
        , year
        , vit_b6 / 365 AS value
        , rank 
        FROM (
            SELECT year, scenario, impact_commodity.name AS commodity, country, vit_b6, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by vit_b6 DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
        ) ranked_scores
    WHERE rank <=5
    UNION
    -- aggregate remaining commodities
    SELECT 'B6' AS nutrient
        , country
        , scenario
        , 'Other' AS commodity
        , year
        , sum(vit_b6) / 365 AS value
        , 6 AS rank 
        FROM (
            SELECT year, scenario, commodity, country, vit_b6, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by vit_b6 DESC) AS rank 
                FROM impact_food_availability
        ) ranked_scores
    WHERE rank >5 GROUP BY country, scenario, year
--  End vit_b6
UNION
-- vit_c
    -- rank top 5 commodities for vit_c
    SELECT 'C' AS nutrient
        , country
        , scenario
        , commodity
        , year
        , vit_c / 365 AS value
        , rank 
        FROM (
            SELECT year, scenario, impact_commodity.name AS commodity, country, vit_c, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by vit_c DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
        ) ranked_scores
    WHERE rank <=5
    UNION
    -- aggregate remaining commodities
    SELECT 'C' AS nutrient
        , country
        , scenario
        , 'Other' AS commodity
        , year
        , sum(vit_c) / 365 AS value
        , 6 AS rank 
        FROM (
            SELECT year, scenario, commodity, country, vit_c, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by vit_c DESC) AS rank 
                FROM impact_food_availability
        ) ranked_scores
    WHERE rank >5 GROUP BY country, scenario, year
--  End vit_c
UNION
-- zinc
    -- rank top 5 commodities for zinc
    SELECT 'Zn' AS nutrient
        , country
        , scenario
        , commodity
        , year
        , zinc / 365 AS value
        , rank 
        FROM (
            SELECT year, scenario, impact_commodity.name AS commodity, country, zinc, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by zinc DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
        ) ranked_scores
    WHERE rank <=5
    UNION
    -- aggregate remaining commodities
    SELECT 'Zn' AS nutrient
        , country
        , scenario
        , 'Other' AS commodity
        , year
        , sum(zinc) / 365 AS value
        , 6 AS rank 
        FROM (
            SELECT year, scenario, commodity, country, zinc, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by zinc DESC) AS rank 
                FROM impact_food_availability
        ) ranked_scores
    WHERE rank >5 GROUP BY country, scenario, year
--  End zinc

ORDER by nutrient, country, scenario, year, rank ASC;