"CUSTOMER_REF" AS "CUSTOMER_REF_ORIGINAL",
    IFNULL("CUSTOMER_REF", '-2') AS "CUSTOMER_REF",
"ORDER_LINE" AS "ORDER_LINE_ORIGINAL",
    IFNULL("ORDER_LINE", '-2') AS "ORDER_LINE"