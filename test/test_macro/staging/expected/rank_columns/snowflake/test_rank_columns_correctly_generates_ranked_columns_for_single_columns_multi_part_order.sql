RANK() OVER (PARTITION BY CUSTOMER_ID, CUSTOMER_PHONE ORDER BY BOOKING_DATE, LOAD_DATETIME) AS DBTVAULT_RANK