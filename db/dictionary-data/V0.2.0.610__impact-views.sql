CREATE MATERIALIZED VIEW impact_commodity_aggregation as

-- Calcium
    -- rank top 5 commodities for Calcium
    SELECT 'calcium' AS nutrient
        , country
        , scenario
        , commodity
        , year
        , calcium AS value
        , rank 
        FROM (
            SELECT year, scenario, impact_commodity.name AS commodity, country, calcium, row_number () OVER (
                PARTITION BY 
                year, country, scenario order by calcium DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
        ) ranked_scores
    WHERE rank <=5
    UNION
    -- aggregate remaining commodities
    SELECT 'calcium' AS nutrient
        , country
        , scenario
        , 'Other' AS commodity
        , year
        , sum(calcium) AS value
        , 6 AS rank 
        FROM (
            SELECT year, scenario, commodity, country, calcium, row_number () OVER (
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
        , folate AS value
        , rank 
        FROM (
            SELECT year, scenario, impact_commodity.name AS commodity, country, folate, row_number () OVER (
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
        , sum(folate) AS value
        , 6 AS rank 
        FROM (
            SELECT year, scenario, commodity, country, folate, row_number () OVER (
                PARTITION BY 
                year, country, scenario order by folate DESC) AS rank 
                FROM impact_food_availability
        ) ranked_scores
    WHERE rank >5 GROUP BY country, scenario, year
--  End folate
UNION
-- iron
    -- rank top 5 commodities for iron
    SELECT 'iron' AS nutrient
        , country
        , scenario
        , commodity
        , year
        , iron AS value
        , rank 
        FROM (
            SELECT year, scenario, impact_commodity.name AS commodity, country, iron, row_number () OVER (
                PARTITION BY 
                year, country, scenario order by iron DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
        ) ranked_scores
    WHERE rank <=5
    UNION
    -- aggregate remaining commodities
    SELECT 'iron' AS nutrient
        , country
        , scenario
        , 'Other' AS commodity
        , year
        , sum(iron) AS value
        , 6 AS rank 
        FROM (
            SELECT year, scenario, commodity, country, iron, row_number () OVER (
                PARTITION BY 
                year, country, scenario order by iron DESC) AS rank 
                FROM impact_food_availability
        ) ranked_scores
    WHERE rank >5 GROUP BY country, scenario, year
--  End iron
UNION
-- magnesium
    -- rank top 5 commodities for magnesium
    SELECT 'magnesium' AS nutrient
        , country
        , scenario
        , commodity
        , year
        , magnesium AS value
        , rank 
        FROM (
            SELECT year, scenario, impact_commodity.name AS commodity, country, magnesium, row_number () OVER (
                PARTITION BY 
                year, country, scenario order by magnesium DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
        ) ranked_scores
    WHERE rank <=5
    UNION
    -- aggregate remaining commodities
    SELECT 'magnesium' AS nutrient
        , country
        , scenario
        , 'Other' AS commodity
        , year
        , sum(magnesium) AS value
        , 6 AS rank 
        FROM (
            SELECT year, scenario, commodity, country, magnesium, row_number () OVER (
                PARTITION BY 
                year, country, scenario order by magnesium DESC) AS rank 
                FROM impact_food_availability
        ) ranked_scores
    WHERE rank >5 GROUP BY country, scenario, year
--  End magnesium
UNION
-- niacin
    -- rank top 5 commodities for niacin
    SELECT 'niacin' AS nutrient
        , country
        , scenario
        , commodity
        , year
        , niacin AS value
        , rank 
        FROM (
            SELECT year, scenario, impact_commodity.name AS commodity, country, niacin, row_number () OVER (
                PARTITION BY 
                year, country, scenario order by niacin DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
        ) ranked_scores
    WHERE rank <=5
    UNION
    -- aggregate remaining commodities
    SELECT 'niacin' AS nutrient
        , country
        , scenario
        , 'Other' AS commodity
        , year
        , sum(niacin) AS value
        , 6 AS rank 
        FROM (
            SELECT year, scenario, commodity, country, niacin, row_number () OVER (
                PARTITION BY 
                year, country, scenario order by niacin DESC) AS rank 
                FROM impact_food_availability
        ) ranked_scores
    WHERE rank >5 GROUP BY country, scenario, year
--  End niacin
UNION
-- phosphorus
    -- rank top 5 commodities for phosphorus
    SELECT 'phosphorus' AS nutrient
        , country
        , scenario
        , commodity
        , year
        , phosphorus AS value
        , rank 
        FROM (
            SELECT year, scenario, impact_commodity.name AS commodity, country, phosphorus, row_number () OVER (
                PARTITION BY 
                year, country, scenario order by phosphorus DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
        ) ranked_scores
    WHERE rank <=5
    UNION
    -- aggregate remaining commodities
    SELECT 'phosphorus' AS nutrient
        , country
        , scenario
        , 'Other' AS commodity
        , year
        , sum(phosphorus) AS value
        , 6 AS rank 
        FROM (
            SELECT year, scenario, commodity, country, phosphorus, row_number () OVER (
                PARTITION BY 
                year, country, scenario order by phosphorus DESC) AS rank 
                FROM impact_food_availability
        ) ranked_scores
    WHERE rank >5 GROUP BY country, scenario, year
--  End phosphorus
UNION
-- potassium
    -- rank top 5 commodities for potassium
    SELECT 'potassium' AS nutrient
        , country
        , scenario
        , commodity
        , year
        , potassium AS value
        , rank 
        FROM (
            SELECT year, scenario, impact_commodity.name AS commodity, country, potassium, row_number () OVER (
                PARTITION BY 
                year, country, scenario order by potassium DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
        ) ranked_scores
    WHERE rank <=5
    UNION
    -- aggregate remaining commodities
    SELECT 'potassium' AS nutrient
        , country
        , scenario
        , 'Other' AS commodity
        , year
        , sum(potassium) AS value
        , 6 AS rank 
        FROM (
            SELECT year, scenario, commodity, country, potassium, row_number () OVER (
                PARTITION BY 
                year, country, scenario order by potassium DESC) AS rank 
                FROM impact_food_availability
        ) ranked_scores
    WHERE rank >5 GROUP BY country, scenario, year
--  End potassium
UNION
-- protein
    -- rank top 5 commodities for protein
    SELECT 'protein' AS nutrient
        , country
        , scenario
        , commodity
        , year
        , protein AS value
        , rank 
        FROM (
            SELECT year, scenario, impact_commodity.name AS commodity, country, protein, row_number () OVER (
                PARTITION BY 
                year, country, scenario order by protein DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
        ) ranked_scores
    WHERE rank <=5
    UNION
    -- aggregate remaining commodities
    SELECT 'protein' AS nutrient
        , country
        , scenario
        , 'Other' AS commodity
        , year
        , sum(protein) AS value
        , 6 AS rank 
        FROM (
            SELECT year, scenario, commodity, country, protein, row_number () OVER (
                PARTITION BY 
                year, country, scenario order by protein DESC) AS rank 
                FROM impact_food_availability
        ) ranked_scores
    WHERE rank >5 GROUP BY country, scenario, year
--  End protein
UNION
-- riboflavin
    -- rank top 5 commodities for riboflavin
    SELECT 'riboflavin' AS nutrient
        , country
        , scenario
        , commodity
        , year
        , riboflavin AS value
        , rank 
        FROM (
            SELECT year, scenario, impact_commodity.name AS commodity, country, riboflavin, row_number () OVER (
                PARTITION BY 
                year, country, scenario order by riboflavin DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
        ) ranked_scores
    WHERE rank <=5
    UNION
    -- aggregate remaining commodities
    SELECT 'riboflavin' AS nutrient
        , country
        , scenario
        , 'Other' AS commodity
        , year
        , sum(riboflavin) AS value
        , 6 AS rank 
        FROM (
            SELECT year, scenario, commodity, country, riboflavin, row_number () OVER (
                PARTITION BY 
                year, country, scenario order by riboflavin DESC) AS rank 
                FROM impact_food_availability
        ) ranked_scores
    WHERE rank >5 GROUP BY country, scenario, year
--  End riboflavin
UNION
-- thiamin
    -- rank top 5 commodities for thiamin
    SELECT 'thiamin' AS nutrient
        , country
        , scenario
        , commodity
        , year
        , thiamin AS value
        , rank 
        FROM (
            SELECT year, scenario, impact_commodity.name AS commodity, country, thiamin, row_number () OVER (
                PARTITION BY 
                year, country, scenario order by thiamin DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
        ) ranked_scores
    WHERE rank <=5
    UNION
    -- aggregate remaining commodities
    SELECT 'thiamin' AS nutrient
        , country
        , scenario
        , 'Other' AS commodity
        , year
        , sum(thiamin) AS value
        , 6 AS rank 
        FROM (
            SELECT year, scenario, commodity, country, thiamin, row_number () OVER (
                PARTITION BY 
                year, country, scenario order by thiamin DESC) AS rank 
                FROM impact_food_availability
        ) ranked_scores
    WHERE rank >5 GROUP BY country, scenario, year
--  End thiamin
UNION
-- vit_a
    -- rank top 5 commodities for vit_a
    SELECT 'vit_a' AS nutrient
        , country
        , scenario
        , commodity
        , year
        , vit_a AS value
        , rank 
        FROM (
            SELECT year, scenario, impact_commodity.name AS commodity, country, vit_a, row_number () OVER (
                PARTITION BY 
                year, country, scenario order by vit_a DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
        ) ranked_scores
    WHERE rank <=5
    UNION
    -- aggregate remaining commodities
    SELECT 'vit_a' AS nutrient
        , country
        , scenario
        , 'Other' AS commodity
        , year
        , sum(vit_a) AS value
        , 6 AS rank 
        FROM (
            SELECT year, scenario, commodity, country, vit_a, row_number () OVER (
                PARTITION BY 
                year, country, scenario order by vit_a DESC) AS rank 
                FROM impact_food_availability
        ) ranked_scores
    WHERE rank >5 GROUP BY country, scenario, year
--  End vit_a
UNION
-- vit_b6
    -- rank top 5 commodities for vit_b6
    SELECT 'vit_b6' AS nutrient
        , country
        , scenario
        , commodity
        , year
        , vit_b6 AS value
        , rank 
        FROM (
            SELECT year, scenario, impact_commodity.name AS commodity, country, vit_b6, row_number () OVER (
                PARTITION BY 
                year, country, scenario order by vit_b6 DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
        ) ranked_scores
    WHERE rank <=5
    UNION
    -- aggregate remaining commodities
    SELECT 'vit_b6' AS nutrient
        , country
        , scenario
        , 'Other' AS commodity
        , year
        , sum(vit_b6) AS value
        , 6 AS rank 
        FROM (
            SELECT year, scenario, commodity, country, vit_b6, row_number () OVER (
                PARTITION BY 
                year, country, scenario order by vit_b6 DESC) AS rank 
                FROM impact_food_availability
        ) ranked_scores
    WHERE rank >5 GROUP BY country, scenario, year
--  End vit_b6
UNION
-- vit_c
    -- rank top 5 commodities for vit_c
    SELECT 'vit_c' AS nutrient
        , country
        , scenario
        , commodity
        , year
        , vit_c AS value
        , rank 
        FROM (
            SELECT year, scenario, impact_commodity.name AS commodity, country, vit_c, row_number () OVER (
                PARTITION BY 
                year, country, scenario order by vit_c DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
        ) ranked_scores
    WHERE rank <=5
    UNION
    -- aggregate remaining commodities
    SELECT 'vit_c' AS nutrient
        , country
        , scenario
        , 'Other' AS commodity
        , year
        , sum(vit_c) AS value
        , 6 AS rank 
        FROM (
            SELECT year, scenario, commodity, country, vit_c, row_number () OVER (
                PARTITION BY 
                year, country, scenario order by vit_c DESC) AS rank 
                FROM impact_food_availability
        ) ranked_scores
    WHERE rank >5 GROUP BY country, scenario, year
--  End vit_c
UNION
-- zinc
    -- rank top 5 commodities for zinc
    SELECT 'zinc' AS nutrient
        , country
        , scenario
        , commodity
        , year
        , zinc AS value
        , rank 
        FROM (
            SELECT year, scenario, impact_commodity.name AS commodity, country, zinc, row_number () OVER (
                PARTITION BY 
                year, country, scenario order by zinc DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
        ) ranked_scores
    WHERE rank <=5
    UNION
    -- aggregate remaining commodities
    SELECT 'zinc' AS nutrient
        , country
        , scenario
        , 'Other' AS commodity
        , year
        , sum(zinc) AS value
        , 6 AS rank 
        FROM (
            SELECT year, scenario, commodity, country, zinc, row_number () OVER (
                PARTITION BY 
                year, country, scenario order by zinc DESC) AS rank 
                FROM impact_food_availability
        ) ranked_scores
    WHERE rank >5 GROUP BY country, scenario, year
--  End zinc

ORDER by nutrient, country, scenario, year, rank ASC;