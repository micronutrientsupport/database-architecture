DROP MATERIALIZED VIEW IF EXISTS impact_food_group_aggregation;
CREATE MATERIALIZED VIEW impact_food_group_aggregation as

-- Calcium
    -- rank top 5 commodities for Calcium
    SELECT 'Ca' AS nutrient
        , country
        , scenario
        , food_group
        , year
        , calcium AS value
        , rank 
        FROM (
            SELECT year, scenario, food_group.name as food_group, country, sum(calcium) as calcium, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by sum(calcium) DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
                join food_group on food_group.id=impact_commodity.food_group
                group by year, country, scenario, food_group.name
        ) ranked_scores        
    WHERE rank <=5
    UNION
    -- aggregate remaining commodities
    SELECT 'Ca' AS nutrient
        , country
        , scenario
        , 'Other' as food_group
        , year
        , sum(calcium) AS value
        , 6 as rank 
        FROM (
            SELECT year, scenario, food_group.name as food_group, country, sum(calcium) as calcium, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by sum(calcium) DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
                join food_group on food_group.id=impact_commodity.food_group
                group by year, country, scenario, food_group.name
        ) ranked_scores      
    WHERE rank >5 group by year, country, scenario
--  End Calcium
UNION
-- folate
    -- rank top 5 commodities for folate
    SELECT 'Folic Acid' AS nutrient
        , country
        , scenario
        , food_group
        , year
        , folate AS value
        , rank 
        FROM (
            SELECT year, scenario, food_group.name as food_group, country, sum(folate) as folate, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by sum(folate) DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
                join food_group on food_group.id=impact_commodity.food_group
                group by year, country, scenario, food_group.name
        ) ranked_scores
    WHERE rank <=5
    UNION
    -- aggregate remaining commodities
    SELECT 'Folic Acid' AS nutrient
        , country
        , scenario
        , 'Other' as food_group
        , year
        , sum(folate) AS value
        , 6 as rank 
        FROM (
            SELECT year, scenario, food_group.name as food_group, country, sum(folate) as folate, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by sum(folate) DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
                join food_group on food_group.id=impact_commodity.food_group
                group by year, country, scenario, food_group.name
        ) ranked_scores      
    WHERE rank >5 group by year, country, scenario 
--  End folate
UNION
-- iron
    -- rank top 5 commodities for iron
    SELECT 'Fe' AS nutrient
        , country
        , scenario
        , food_group
        , year
        , iron AS value
        , rank 
        FROM (
            SELECT year, scenario, food_group.name as food_group, country, sum(iron) as iron, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by sum(iron) DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
                join food_group on food_group.id=impact_commodity.food_group
                group by year, country, scenario, food_group.name
        ) ranked_scores
    WHERE rank <=5
    UNION
    -- aggregate remaining commodities
    SELECT 'Fe' AS nutrient
        , country
        , scenario
        , 'Other' as food_group
        , year
        , sum(iron) AS value
        , 6 as rank 
        FROM (
            SELECT year, scenario, food_group.name as food_group, country, sum(iron) as iron, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by sum(iron) DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
                join food_group on food_group.id=impact_commodity.food_group
                group by year, country, scenario, food_group.name
        ) ranked_scores      
    WHERE rank >5 group by year, country, scenario 
--  End iron
UNION
-- magnesium
    -- rank top 5 commodities for magnesium
    SELECT 'Mg' AS nutrient
        , country
        , scenario
        , food_group
        , year
        , magnesium AS value
        , rank 
        FROM (
            SELECT year, scenario, food_group.name as food_group, country, sum(magnesium) as magnesium, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by sum(magnesium) DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
                join food_group on food_group.id=impact_commodity.food_group
                group by year, country, scenario, food_group.name
        ) ranked_scores
    WHERE rank <=5
    UNION
    -- aggregate remaining commodities
    SELECT 'Mg' AS nutrient
        , country
        , scenario
        , 'Other' as food_group
        , year
        , sum(magnesium) AS value
        , 6 as rank 
        FROM (
            SELECT year, scenario, food_group.name as food_group, country, sum(magnesium) as magnesium, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by sum(magnesium) DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
                join food_group on food_group.id=impact_commodity.food_group
                group by year, country, scenario, food_group.name
        ) ranked_scores      
    WHERE rank >5 group by year, country, scenario 
--  End magnesium
UNION
-- niacin
    -- rank top 5 commodities for niacin
    SELECT 'B3' AS nutrient
        , country
        , scenario
        , food_group
        , year
        , niacin AS value
        , rank 
        FROM (
            SELECT year, scenario, food_group.name as food_group, country, sum(niacin) as niacin, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by sum(niacin) DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
                join food_group on food_group.id=impact_commodity.food_group
                group by year, country, scenario, food_group.name
        ) ranked_scores
    WHERE rank <=5
    UNION
    -- aggregate remaining commodities
    SELECT 'B3' AS nutrient
        , country
        , scenario
        , 'Other' as food_group
        , year
        , sum(niacin) AS value
        , 6 as rank 
        FROM (
            SELECT year, scenario, food_group.name as food_group, country, sum(niacin) as niacin, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by sum(niacin) DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
                join food_group on food_group.id=impact_commodity.food_group
                group by year, country, scenario, food_group.name
        ) ranked_scores      
    WHERE rank >5 group by year, country, scenario 
--  End niacin
UNION
-- phosphorus
    -- rank top 5 commodities for phosphorus
    SELECT 'P' AS nutrient
        , country
        , scenario
        , food_group
        , year
        , phosphorus AS value
        , rank 
        FROM (
            SELECT year, scenario, food_group.name as food_group, country, sum(phosphorus) as phosphorus, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by sum(phosphorus) DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
                join food_group on food_group.id=impact_commodity.food_group
                group by year, country, scenario, food_group.name
        ) ranked_scores
    WHERE rank <=5
    UNION
    -- aggregate remaining commodities
    SELECT 'P' AS nutrient
        , country
        , scenario
        , 'Other' as food_group
        , year
        , sum(phosphorus) AS value
        , 6 as rank 
        FROM (
            SELECT year, scenario, food_group.name as food_group, country, sum(phosphorus) as phosphorus, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by sum(phosphorus) DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
                join food_group on food_group.id=impact_commodity.food_group
                group by year, country, scenario, food_group.name
        ) ranked_scores      
    WHERE rank >5 group by year, country, scenario 
--  End phosphorus
UNION
-- potassium
    -- rank top 5 commodities for potassium
    SELECT 'K' AS nutrient
        , country
        , scenario
        , food_group
        , year
        , potassium AS value
        , rank 
        FROM (
            SELECT year, scenario, food_group.name as food_group, country, sum(potassium) as potassium, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by sum(potassium) DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
                join food_group on food_group.id=impact_commodity.food_group
                group by year, country, scenario, food_group.name
        ) ranked_scores
    WHERE rank <=5
    UNION
    -- aggregate remaining commodities
    SELECT 'K' AS nutrient
        , country
        , scenario
        , 'Other' as food_group
        , year
        , sum(potassium) AS value
        , 6 as rank 
        FROM (
            SELECT year, scenario, food_group.name as food_group, country, sum(potassium) as potassium, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by sum(potassium) DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
                join food_group on food_group.id=impact_commodity.food_group
                group by year, country, scenario, food_group.name
        ) ranked_scores      
    WHERE rank >5 group by year, country, scenario 
--  End potassium
UNION
-- protein
    -- rank top 5 commodities for protein
    SELECT 'Protein' AS nutrient
        , country
        , scenario
        , food_group
        , year
        , protein AS value
        , rank 
        FROM (
            SELECT year, scenario, food_group.name as food_group, country, sum(protein) as protein, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by sum(protein) DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
                join food_group on food_group.id=impact_commodity.food_group
                group by year, country, scenario, food_group.name
        ) ranked_scores
    WHERE rank <=5
    UNION
    -- aggregate remaining commodities
    SELECT 'Protein' AS nutrient
        , country
        , scenario
        , 'Other' as food_group
        , year
        , sum(protein) AS value
        , 6 as rank 
        FROM (
            SELECT year, scenario, food_group.name as food_group, country, sum(protein) as protein, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by sum(protein) DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
                join food_group on food_group.id=impact_commodity.food_group
                group by year, country, scenario, food_group.name
        ) ranked_scores      
    WHERE rank >5 group by year, country, scenario 
--  End protein
UNION
-- riboflavin
    -- rank top 5 commodities for riboflavin
    SELECT 'B2' AS nutrient
        , country
        , scenario
        , food_group
        , year
        , riboflavin AS value
        , rank 
        FROM (
            SELECT year, scenario, food_group.name as food_group, country, sum(riboflavin) as riboflavin, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by sum(riboflavin) DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
                join food_group on food_group.id=impact_commodity.food_group
                group by year, country, scenario, food_group.name
        ) ranked_scores
    WHERE rank <=5
    UNION
    -- aggregate remaining commodities
    SELECT 'B2' AS nutrient
        , country
        , scenario
        , 'Other' as food_group
        , year
        , sum(riboflavin) AS value
        , 6 as rank 
        FROM (
            SELECT year, scenario, food_group.name as food_group, country, sum(riboflavin) as riboflavin, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by sum(riboflavin) DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
                join food_group on food_group.id=impact_commodity.food_group
                group by year, country, scenario, food_group.name
        ) ranked_scores      
    WHERE rank >5 group by year, country, scenario 
--  End riboflavin
UNION
-- thiamin
    -- rank top 5 commodities for thiamin
    SELECT 'B1' AS nutrient
        , country
        , scenario
        , food_group
        , year
        , thiamin AS value
        , rank 
        FROM (
            SELECT year, scenario, food_group.name as food_group, country, sum(thiamin) as thiamin, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by sum(thiamin) DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
                join food_group on food_group.id=impact_commodity.food_group
                group by year, country, scenario, food_group.name
        ) ranked_scores
    WHERE rank <=5
    UNION
    -- aggregate remaining commodities
    SELECT 'B1' AS nutrient
        , country
        , scenario
        , 'Other' as food_group
        , year
        , sum(thiamin) AS value
        , 6 as rank 
        FROM (
            SELECT year, scenario, food_group.name as food_group, country, sum(thiamin) as thiamin, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by sum(thiamin) DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
                join food_group on food_group.id=impact_commodity.food_group
                group by year, country, scenario, food_group.name
        ) ranked_scores      
    WHERE rank >5 group by year, country, scenario 
--  End thiamin
UNION
-- vit_a
    -- rank top 5 commodities for vit_a
    SELECT 'A' AS nutrient
        , country
        , scenario
        , food_group
        , year
        , vit_a AS value
        , rank 
        FROM (
            SELECT year, scenario, food_group.name as food_group, country, sum(vit_a) as vit_a, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by sum(vit_a) DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
                join food_group on food_group.id=impact_commodity.food_group
                group by year, country, scenario, food_group.name
        ) ranked_scores
    WHERE rank <=5
    UNION
    -- aggregate remaining commodities
    SELECT 'A' AS nutrient
        , country
        , scenario
        , 'Other' as food_group
        , year
        , sum(vit_a) AS value
        , 6 as rank 
        FROM (
            SELECT year, scenario, food_group.name as food_group, country, sum(vit_a) as vit_a, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by sum(vit_a) DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
                join food_group on food_group.id=impact_commodity.food_group
                group by year, country, scenario, food_group.name
        ) ranked_scores      
    WHERE rank >5 group by year, country, scenario 
--  End vit_a
UNION
-- vit_b6
    -- rank top 5 commodities for vit_b6
    SELECT 'B6' AS nutrient
        , country
        , scenario
        , food_group
        , year
        , vit_b6 AS value
        , rank 
        FROM (
            SELECT year, scenario, food_group.name as food_group, country, sum(vit_b6) as vit_b6, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by sum(vit_b6) DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
                join food_group on food_group.id=impact_commodity.food_group
                group by year, country, scenario, food_group.name
        ) ranked_scores
    WHERE rank <=5
    UNION
    -- aggregate remaining commodities
    SELECT 'B6' AS nutrient
        , country
        , scenario
        , 'Other' as food_group
        , year
        , sum(vit_b6) AS value
        , 6 as rank 
        FROM (
            SELECT year, scenario, food_group.name as food_group, country, sum(vit_b6) as vit_b6, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by sum(vit_b6) DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
                join food_group on food_group.id=impact_commodity.food_group
                group by year, country, scenario, food_group.name
        ) ranked_scores      
    WHERE rank >5 group by year, country, scenario 
--  End vit_b6
UNION
-- vit_c
    -- rank top 5 commodities for vit_c
    SELECT 'C' AS nutrient
        , country
        , scenario
        , food_group
        , year
        , vit_c AS value
        , rank 
        FROM (
            SELECT year, scenario, food_group.name as food_group, country, sum(vit_c) as vit_c, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by sum(vit_c) DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
                join food_group on food_group.id=impact_commodity.food_group
                group by year, country, scenario, food_group.name
        ) ranked_scores
    WHERE rank <=5
    UNION
    -- aggregate remaining commodities
    SELECT 'C' AS nutrient
        , country
        , scenario
        , 'Other' as food_group
        , year
        , sum(vit_c) AS value
        , 6 as rank 
        FROM (
            SELECT year, scenario, food_group.name as food_group, country, sum(vit_c) as vit_c, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by sum(vit_c) DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
                join food_group on food_group.id=impact_commodity.food_group
                group by year, country, scenario, food_group.name
        ) ranked_scores      
    WHERE rank >5 group by year, country, scenario 
--  End vit_c
UNION
-- zinc
    -- rank top 5 commodities for zinc
    SELECT 'Zn' AS nutrient
        , country
        , scenario
        , food_group
        , year
        , zinc AS value
        , rank 
        FROM (
            SELECT year, scenario, food_group.name as food_group, country, sum(zinc) as zinc, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by sum(zinc) DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
                join food_group on food_group.id=impact_commodity.food_group
                group by year, country, scenario, food_group.name
        ) ranked_scores
    WHERE rank <=5
    UNION
    -- aggregate remaining commodities
    SELECT 'Zn' AS nutrient
        , country
        , scenario
        , 'Other' as food_group
        , year
        , sum(zinc) AS value
        , 6 as rank 
        FROM (
            SELECT year, scenario, food_group.name as food_group, country, sum(zinc) as zinc, row_number() OVER (
                PARTITION BY 
                year, country, scenario order by sum(zinc) DESC) AS rank 
                FROM impact_food_availability 
                JOIN impact_commodity ON impact_food_availability.commodity=impact_commodity.id
                join food_group on food_group.id=impact_commodity.food_group
                group by year, country, scenario, food_group.name
        ) ranked_scores      
    WHERE rank >5 group by year, country, scenario 
--  End zinc

ORDER by nutrient, country, scenario, year, rank ASC;