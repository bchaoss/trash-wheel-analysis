{% set numeric_cols_to_cast = [
    'weight',
    'volume',
    'plastic_bottles',
    'polystyrene',
    'cigarette_butts',
    'glass_bottles',
    'plastic_bags',
    'wrappers',
    'sports_balls',
    'homes_powered'
] %}

WITH cleaned as (
SELECT
    dumpster_id
    , wheel_id
    , date
    {% for col in numeric_cols_to_cast %}
    , TRY_CAST(REPLACE(REPLACE({{ col }}, ' ', ''), ',', '') AS DECIMAL) AS {{ col }}
    {% endfor %}
    , load_time
FROM
    {{ ref('stg_trash_unique') }}
)

SELECT *
FROM cleaned
WHERE 1=1
    {% for col in numeric_cols_to_cast %}
    and {{ col }} IS NOT NULL
    {% endfor %}
