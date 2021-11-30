
{% test zipcode_five_digit(model, column_name) %}


   select *
   from {{ model }}
   where {{ column_name }} > 9999 and {{ column_name }} < 99999


{% endtest %}