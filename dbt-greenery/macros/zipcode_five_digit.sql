
{% test zipcode_five_digit(model, column_name) %}


   select *
   from {{ model }}
   where {{ column_name }} < 10000 and > 99999


{% endtest %}