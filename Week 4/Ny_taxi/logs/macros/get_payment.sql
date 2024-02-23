{#
   this macro return the description of payment_type 
#}

{% macro get_payment(payment_type) -%}
    case payment_type 
        when 1 then 'Credit card'
        when 2 then 'Cash'
        when 3 then 'No charge'
        when 4 then 'Dispute'
        when 5 then 'Unknow'
        when 6 then 'Voided trip'
        ELSE 'Empty'
    END

{%- endmacro %}
