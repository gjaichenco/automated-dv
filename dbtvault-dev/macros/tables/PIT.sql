{%- macro PIT(src_pk,source_model,as_of_dates_table,satellite) -%}

    {{- adapter.dispatch('PIT', packages = var('adapter_packages', ['dbtvault']))(source_model=source_model,src_pk=src_pk,
                                                                                   as_of_dates_table=as_of_dates_table,
                                                                                   satellite=satellite) -}}

{%- endmacro -%}

{%- macro default__PIT(src_pk,source_model,as_of_dates_table,satellite) -%}

{% set maxdate = '9999-12-31 23:59:59.999999' %}
{% set ghost_pk = cast_binary('0000000000000000') %}
{% set ghost_date = '0000-00-00 00:00:00.000000' %}


Insert into PIT(
    SELECT
        {{ as_of_dates_table -}}.as_of_date,
        {{ src_pk }},
        {% for sats in satellites -%}
            coalesce(max({{- sat.pk -}}),ghost_pk) AS {{ sat -}}_PK,
            coalesce(max({{- sat.LDTS -}}),ghost_date) AS {{ LDTS -}}_LDTS
            {{- ',' if not loop.last -}}
        {%- endfor %}

    From {{ source_model }} AS h

    INNER JOIN {{ as_of_dates_table }} AS x
        ON (1=1)


    {% for sat in satelites -%}
        LEFT JOIN {{ sat }}
            ON {{ h.src_pk }} = {{ sat -}}.{{ sat.pk }},
        WHERE {{ sat -}}.LDTS <= x.as_of_date
    {% endfor %}

    GROUP BY
    x.as_of_date, h.{{- src_pk }},
    ORDER BY 1,2;


{%- endmacro -%}