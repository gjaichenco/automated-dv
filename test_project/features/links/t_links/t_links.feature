@fixture.set_workdir
Feature: Transactional Links

        @fixture.t_link_bigquery
  Scenario: [BASE-LOAD] Load a non-existent Transactional Link
    Given the T_LINK table does not exist
    And the RAW_STAGE table contains data
      | CUSTOMER_ID | ORDER_ID | TRANSACTION_NUMBER | TRANSACTION_DATE | TYPE | AMOUNT   | LOAD_DATE  | SOURCE |
      | 1234        | 4321     | 12345678           | 2019-09-19       | DR   | 2340.50  | 2019-09-21 | SAP    |
      | 1234        | 4322     | 12345679           | 2019-09-19       | CR   | 123.40   | 2019-09-21 | SAP    |
      | 1234        | 4323     | 12345680           | 2019-09-19       | DR   | 2546.23  | 2019-09-21 | SAP    |
      | 1234        | 4324     | 12345681           | 2019-09-19       | CR   | -123.40  | 2019-09-21 | SAP    |
      | 1235        | 4325     | 12345682           | 2019-09-19       | CR   | 37645.34 | 2019-09-21 | SAP    |
      | 1236        | 4326     | 12345683           | 2019-09-19       | CR   | 236.55   | 2019-09-21 | SAP    |
      | 1237        | 4327     | 12345684           | 2019-09-19       | DR   | 3567.34  | 2019-09-21 | SAP    |
    And I create the STG_CUSTOMER stage
    When I load the T_LINK t_link
    Then the T_LINK table should contain expected data
      | TRANSACTION_PK                  | CUSTOMER_FK | ORDER_FK    | TRANSACTION_NUMBER | TRANSACTION_DATE | TYPE | AMOUNT   | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | md5('1234\|\|4321\|\|12345678') | md5('1234') | md5('4321') | 12345678           | 2019-09-19       | DR   | 2340.50  | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1234\|\|4322\|\|12345679') | md5('1234') | md5('4322') | 12345679           | 2019-09-19       | CR   | 123.40   | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1234\|\|4323\|\|12345680') | md5('1234') | md5('4323') | 12345680           | 2019-09-19       | DR   | 2546.23  | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1234\|\|4324\|\|12345681') | md5('1234') | md5('4324') | 12345681           | 2019-09-19       | CR   | -123.40  | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1235\|\|4325\|\|12345682') | md5('1235') | md5('4325') | 12345682           | 2019-09-19       | CR   | 37645.34 | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1236\|\|4326\|\|12345683') | md5('1236') | md5('4326') | 12345683           | 2019-09-19       | CR   | 236.55   | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1237\|\|4327\|\|12345684') | md5('1237') | md5('4327') | 12345684           | 2019-09-19       | DR   | 3567.34  | 2019-09-19     | 2019-09-21 | SAP    |

  @fixture.disable_payload
  @fixture.t_link
  Scenario: [BASE-LOAD] Load a non-existent Transactional Link without a payload
    Given the T_LINK table does not exist
    And the RAW_STAGE table contains data
      | CUSTOMER_ID | ORDER_ID | TRANSACTION_NUMBER | TRANSACTION_DATE | TYPE | AMOUNT   | LOAD_DATE  | SOURCE |
      | 1234        | 4321     | 12345678           | 2019-09-19       | DR   | 2340.50  | 2019-09-21 | SAP    |
      | 1234        | 4322     | 12345679           | 2019-09-19       | CR   | 123.40   | 2019-09-21 | SAP    |
      | 1234        | 4323     | 12345680           | 2019-09-19       | DR   | 2546.23  | 2019-09-21 | SAP    |
      | 1234        | 4324     | 12345681           | 2019-09-19       | CR   | -123.40  | 2019-09-21 | SAP    |
      | 1235        | 4325     | 12345682           | 2019-09-19       | CR   | 37645.34 | 2019-09-21 | SAP    |
      | 1236        | 4326     | 12345683           | 2019-09-19       | CR   | 236.55   | 2019-09-21 | SAP    |
      | 1237        | 4327     | 12345684           | 2019-09-19       | DR   | 3567.34  | 2019-09-21 | SAP    |
    And I create the STG_CUSTOMER stage
    When I load the T_LINK t_link
    Then the T_LINK table should contain expected data
      | TRANSACTION_PK                  | CUSTOMER_FK | ORDER_FK    | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | md5('1234\|\|4321\|\|12345678') | md5('1234') | md5('4321') | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1234\|\|4322\|\|12345679') | md5('1234') | md5('4322') | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1234\|\|4323\|\|12345680') | md5('1234') | md5('4323') | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1234\|\|4324\|\|12345681') | md5('1234') | md5('4324') | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1235\|\|4325\|\|12345682') | md5('1235') | md5('4325') | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1236\|\|4326\|\|12345683') | md5('1236') | md5('4326') | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1237\|\|4327\|\|12345684') | md5('1237') | md5('4327') | 2019-09-19     | 2019-09-21 | SAP    |

  @fixture.t_link_bigquery
  Scenario: [BASE-LOAD] Load an empty Transactional Link
    Given the T_LINK table does not exist
    And the RAW_STAGE table contains data
      | CUSTOMER_ID | ORDER_ID | TRANSACTION_NUMBER | TRANSACTION_DATE | TYPE | AMOUNT   | LOAD_DATE  | SOURCE |
      | 1234        | 4321     | 12345678           | 2019-09-19       | DR   | 2340.50  | 2019-09-21 | SAP    |
      | 1234        | 4322     | 12345679           | 2019-09-19       | CR   | 123.40   | 2019-09-21 | SAP    |
      | 1234        | 4323     | 12345680           | 2019-09-19       | DR   | 2546.23  | 2019-09-21 | SAP    |
      | 1234        | 4324     | 12345681           | 2019-09-19       | CR   | -123.40  | 2019-09-21 | SAP    |
      | 1235        | 4325     | 12345682           | 2019-09-19       | CR   | 37645.34 | 2019-09-21 | SAP    |
      | 1236        | 4326     | 12345683           | 2019-09-19       | CR   | 236.55   | 2019-09-21 | SAP    |
      | 1237        | 4327     | 12345684           | 2019-09-19       | DR   | 3567.34  | 2019-09-21 | SAP    |
    And I create the STG_CUSTOMER stage
    When I load the T_LINK t_link
    Then the T_LINK table should contain expected data
      | TRANSACTION_PK                  | CUSTOMER_FK | ORDER_FK    | TRANSACTION_NUMBER | TRANSACTION_DATE | TYPE | AMOUNT   | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | md5('1234\|\|4321\|\|12345678') | md5('1234') | md5('4321') | 12345678           | 2019-09-19       | DR   | 2340.50  | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1234\|\|4322\|\|12345679') | md5('1234') | md5('4322') | 12345679           | 2019-09-19       | CR   | 123.40   | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1234\|\|4323\|\|12345680') | md5('1234') | md5('4323') | 12345680           | 2019-09-19       | DR   | 2546.23  | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1234\|\|4324\|\|12345681') | md5('1234') | md5('4324') | 12345681           | 2019-09-19       | CR   | -123.40  | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1235\|\|4325\|\|12345682') | md5('1235') | md5('4325') | 12345682           | 2019-09-19       | CR   | 37645.34 | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1236\|\|4326\|\|12345683') | md5('1236') | md5('4326') | 12345683           | 2019-09-19       | CR   | 236.55   | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1237\|\|4327\|\|12345684') | md5('1237') | md5('4327') | 12345684           | 2019-09-19       | DR   | 3567.34  | 2019-09-19     | 2019-09-21 | SAP    |

  @fixture.t_link_bigquery
  Scenario: [BASE-LOAD] Load an empty Transactional Link without loading records where all keys are NULL
    Given the T_LINK table does not exist
    And the RAW_STAGE table contains data
      | CUSTOMER_ID | ORDER_ID | TRANSACTION_NUMBER | TRANSACTION_DATE | TYPE | AMOUNT   | LOAD_DATE  | SOURCE |
      | 1234        | 4321     | 12345678           | 2019-09-19       | DR   | 2340.50  | 2019-09-21 | SAP    |
      | 1234        | 4322     | 12345679           | 2019-09-19       | CR   | 123.40   | 2019-09-21 | SAP    |
      | 1234        | 4323     | 12345680           | 2019-09-19       | DR   | 2546.23  | 2019-09-21 | SAP    |
      | 1234        | 4324     | 12345681           | 2019-09-19       | CR   | -123.40  | 2019-09-21 | SAP    |
      | 1235        | 4325     | 12345682           | 2019-09-19       | CR   | 37645.34 | 2019-09-21 | SAP    |
      | 1236        | 4326     | 12345683           | 2019-09-19       | CR   | 236.55   | 2019-09-21 | SAP    |
      | <null>      | <null>   | <null>             | 2019-09-19       | DR   | 3567.34  | 2019-09-21 | SAP    |
    And I create the STG_CUSTOMER stage
    When I load the T_LINK t_link
    Then the T_LINK table should contain expected data
      | TRANSACTION_PK                  | CUSTOMER_FK | ORDER_FK    | TRANSACTION_NUMBER | TRANSACTION_DATE | TYPE | AMOUNT   | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | md5('1234\|\|4321\|\|12345678') | md5('1234') | md5('4321') | 12345678           | 2019-09-19       | DR   | 2340.50  | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1234\|\|4322\|\|12345679') | md5('1234') | md5('4322') | 12345679           | 2019-09-19       | CR   | 123.40   | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1234\|\|4323\|\|12345680') | md5('1234') | md5('4323') | 12345680           | 2019-09-19       | DR   | 2546.23  | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1234\|\|4324\|\|12345681') | md5('1234') | md5('4324') | 12345681           | 2019-09-19       | CR   | -123.40  | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1235\|\|4325\|\|12345682') | md5('1235') | md5('4325') | 12345682           | 2019-09-19       | CR   | 37645.34 | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1236\|\|4326\|\|12345683') | md5('1236') | md5('4326') | 12345683           | 2019-09-19       | CR   | 236.55   | 2019-09-19     | 2019-09-21 | SAP    |

  @fixture.t_link_bigquery
  Scenario: [BASE-LOAD] Load an empty Transactional Link without loading records where foreign keys are NULL
    Given the T_LINK table does not exist
    And the RAW_STAGE table contains data
      | CUSTOMER_ID | ORDER_ID | TRANSACTION_NUMBER | TRANSACTION_DATE | TYPE | AMOUNT   | LOAD_DATE  | SOURCE |
      | 1234        | 4321     | 12345678           | 2019-09-19       | DR   | 2340.50  | 2019-09-21 | SAP    |
      | 1234        | 4322     | 12345679           | 2019-09-19       | CR   | 123.40   | 2019-09-21 | SAP    |
      | 1234        | 4323     | 12345680           | 2019-09-19       | DR   | 2546.23  | 2019-09-21 | SAP    |
      | 1234        | 4324     | 12345681           | 2019-09-19       | CR   | -123.40  | 2019-09-21 | SAP    |
      | 1235        | 4325     | 12345682           | 2019-09-19       | CR   | 37645.34 | 2019-09-21 | SAP    |
      | 1236        | 4326     | 12345683           | 2019-09-19       | CR   | 236.55   | 2019-09-21 | SAP    |
      | <null>      | <null>   | 12345684           | 2019-09-19       | DR   | 3567.34  | 2019-09-21 | SAP    |
    And I create the STG_CUSTOMER stage
    When I load the T_LINK t_link
    Then the T_LINK table should contain expected data
      | TRANSACTION_PK                  | CUSTOMER_FK | ORDER_FK    | TRANSACTION_NUMBER | TRANSACTION_DATE | TYPE | AMOUNT   | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | md5('1234\|\|4321\|\|12345678') | md5('1234') | md5('4321') | 12345678           | 2019-09-19       | DR   | 2340.50  | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1234\|\|4322\|\|12345679') | md5('1234') | md5('4322') | 12345679           | 2019-09-19       | CR   | 123.40   | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1234\|\|4323\|\|12345680') | md5('1234') | md5('4323') | 12345680           | 2019-09-19       | DR   | 2546.23  | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1234\|\|4324\|\|12345681') | md5('1234') | md5('4324') | 12345681           | 2019-09-19       | CR   | -123.40  | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1235\|\|4325\|\|12345682') | md5('1235') | md5('4325') | 12345682           | 2019-09-19       | CR   | 37645.34 | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1236\|\|4326\|\|12345683') | md5('1236') | md5('4326') | 12345683           | 2019-09-19       | CR   | 236.55   | 2019-09-19     | 2019-09-21 | SAP    |

  @fixture.t_link_bigquery
  Scenario: [BASE-LOAD] Load an empty Transactional Link without loading records where the primary key is NULL
    Given the T_LINK table does not exist
    And the RAW_STAGE table contains data
      | CUSTOMER_ID | ORDER_ID | TRANSACTION_NUMBER | TRANSACTION_DATE | TYPE | AMOUNT   | LOAD_DATE  | SOURCE |
      | 1234        | 4321     | 12345678           | 2019-09-19       | DR   | 2340.50  | 2019-09-21 | SAP    |
      | 1234        | 4322     | 12345679           | 2019-09-19       | CR   | 123.40   | 2019-09-21 | SAP    |
      | 1234        | 4323     | 12345680           | 2019-09-19       | DR   | 2546.23  | 2019-09-21 | SAP    |
      | 1234        | 4324     | 12345681           | 2019-09-19       | CR   | -123.40  | 2019-09-21 | SAP    |
      | 1235        | 4325     | 12345682           | 2019-09-19       | CR   | 37645.34 | 2019-09-21 | SAP    |
      | 1236        | 4326     | 12345683           | 2019-09-19       | CR   | 236.55   | 2019-09-21 | SAP    |
      | <null>      | 4327     | 12345684           | 2019-09-19       | DR   | 3567.34  | 2019-09-21 | SAP    |
    And I create the STG_CUSTOMER stage
    When I load the T_LINK t_link
    Then the T_LINK table should contain expected data
      | TRANSACTION_PK                  | CUSTOMER_FK | ORDER_FK    | TRANSACTION_NUMBER | TRANSACTION_DATE | TYPE | AMOUNT   | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | md5('1234\|\|4321\|\|12345678') | md5('1234') | md5('4321') | 12345678           | 2019-09-19       | DR   | 2340.50  | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1234\|\|4322\|\|12345679') | md5('1234') | md5('4322') | 12345679           | 2019-09-19       | CR   | 123.40   | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1234\|\|4323\|\|12345680') | md5('1234') | md5('4323') | 12345680           | 2019-09-19       | DR   | 2546.23  | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1234\|\|4324\|\|12345681') | md5('1234') | md5('4324') | 12345681           | 2019-09-19       | CR   | -123.40  | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1235\|\|4325\|\|12345682') | md5('1235') | md5('4325') | 12345682           | 2019-09-19       | CR   | 37645.34 | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1236\|\|4326\|\|12345683') | md5('1236') | md5('4326') | 12345683           | 2019-09-19       | CR   | 236.55   | 2019-09-19     | 2019-09-21 | SAP    |

  @fixture.t_link_bigquery
  Scenario: [INCREMENTAL-LOAD] Load a populated Transactional Link
    Given the T_LINK t_link is already populated with data
      | TRANSACTION_PK                  | CUSTOMER_FK | ORDER_FK    | TRANSACTION_NUMBER | TRANSACTION_DATE | TYPE | AMOUNT   | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | md5('1234\|\|4321\|\|12345678') | md5('1234') | md5('4321') | 12345678           | 2019-09-19       | DR   | 2340.50  | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1234\|\|4322\|\|12345679') | md5('1234') | md5('4322') | 12345679           | 2019-09-19       | CR   | 123.40   | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1234\|\|4323\|\|12345680') | md5('1234') | md5('4323') | 12345680           | 2019-09-19       | DR   | 2546.23  | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1234\|\|4324\|\|12345681') | md5('1234') | md5('4324') | 12345681           | 2019-09-19       | CR   | -123.40  | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1235\|\|4325\|\|12345682') | md5('1235') | md5('4325') | 12345682           | 2019-09-19       | CR   | 37645.34 | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1236\|\|4326\|\|12345683') | md5('1236') | md5('4326') | 12345683           | 2019-09-19       | CR   | 236.55   | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1237\|\|4327\|\|12345684') | md5('1237') | md5('4327') | 12345684           | 2019-09-19       | DR   | 3567.34  | 2019-09-19     | 2019-09-21 | SAP    |
    And the RAW_STAGE table contains data
      | CUSTOMER_ID | ORDER_ID | TRANSACTION_NUMBER | TRANSACTION_DATE | TYPE | AMOUNT   | LOAD_DATE  | SOURCE |
      | 1234        | 1238     | 12345685           | 2019-09-20       | DR   | 3478.50  | 2019-09-22 | SAP    |
      | 1234        | 1239     | 12345686           | 2019-09-20       | DR   | 10.00    | 2019-09-22 | SAP    |
      | 1235        | 1240     | 12345687           | 2019-09-20       | DR   | 1734.65  | 2019-09-22 | SAP    |
      | 1236        | 1241     | 12345688           | 2019-09-20       | DR   | 4832.56  | 2019-09-22 | SAP    |
      | 1237        | 1242     | 12345689           | 2019-09-20       | DR   | 10000.00 | 2019-09-22 | SAP    |
      | 1238        | 1243     | 12345690           | 2019-09-20       | CR   | 6823.55  | 2019-09-22 | SAP    |
      | 1238        | 1244     | 12345691           | 2019-09-20       | CR   | 4578.34  | 2019-09-22 | SAP    |
    And I create the STG_CUSTOMER stage
    When I load the T_LINK t_link
    Then the T_LINK table should contain expected data
      | TRANSACTION_PK                  | CUSTOMER_FK | ORDER_FK    | TRANSACTION_NUMBER | TRANSACTION_DATE | TYPE | AMOUNT   | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | md5('1234\|\|4321\|\|12345678') | md5('1234') | md5('4321') | 12345678           | 2019-09-19       | DR   | 2340.50  | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1234\|\|4322\|\|12345679') | md5('1234') | md5('4322') | 12345679           | 2019-09-19       | CR   | 123.40   | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1234\|\|4323\|\|12345680') | md5('1234') | md5('4323') | 12345680           | 2019-09-19       | DR   | 2546.23  | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1234\|\|4324\|\|12345681') | md5('1234') | md5('4324') | 12345681           | 2019-09-19       | CR   | -123.40  | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1235\|\|4325\|\|12345682') | md5('1235') | md5('4325') | 12345682           | 2019-09-19       | CR   | 37645.34 | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1236\|\|4326\|\|12345683') | md5('1236') | md5('4326') | 12345683           | 2019-09-19       | CR   | 236.55   | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1237\|\|4327\|\|12345684') | md5('1237') | md5('4327') | 12345684           | 2019-09-19       | DR   | 3567.34  | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1234\|\|1238\|\|12345685') | md5('1234') | md5('1238') | 12345685           | 2019-09-20       | DR   | 3478.50  | 2019-09-20     | 2019-09-22 | SAP    |
      | md5('1234\|\|1239\|\|12345686') | md5('1234') | md5('1239') | 12345686           | 2019-09-20       | DR   | 10.00    | 2019-09-20     | 2019-09-22 | SAP    |
      | md5('1235\|\|1240\|\|12345687') | md5('1235') | md5('1240') | 12345687           | 2019-09-20       | DR   | 1734.65  | 2019-09-20     | 2019-09-22 | SAP    |
      | md5('1236\|\|1241\|\|12345688') | md5('1236') | md5('1241') | 12345688           | 2019-09-20       | DR   | 4832.56  | 2019-09-20     | 2019-09-22 | SAP    |
      | md5('1237\|\|1242\|\|12345689') | md5('1237') | md5('1242') | 12345689           | 2019-09-20       | DR   | 10000.00 | 2019-09-20     | 2019-09-22 | SAP    |
      | md5('1238\|\|1243\|\|12345690') | md5('1238') | md5('1243') | 12345690           | 2019-09-20       | CR   | 6823.55  | 2019-09-20     | 2019-09-22 | SAP    |
      | md5('1238\|\|1244\|\|12345691') | md5('1238') | md5('1244') | 12345691           | 2019-09-20       | CR   | 4578.34  | 2019-09-20     | 2019-09-22 | SAP    |

  @fixture.t_link_bigquery
  Scenario: [INCREMENTAL-LOAD] Load populated Transactional Link over two cycles
    Given the T_LINK t_link is already populated with data
      | TRANSACTION_PK                  | CUSTOMER_FK | ORDER_FK    | TRANSACTION_NUMBER | TRANSACTION_DATE | TYPE | AMOUNT   | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | md5('1234\|\|4321\|\|12345678') | md5('1234') | md5('4321') | 12345678           | 2019-09-19       | DR   | 2340.50  | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1234\|\|4322\|\|12345679') | md5('1234') | md5('4322') | 12345679           | 2019-09-19       | CR   | 123.40   | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1234\|\|4323\|\|12345680') | md5('1234') | md5('4323') | 12345680           | 2019-09-19       | DR   | 2546.23  | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1234\|\|4324\|\|12345681') | md5('1234') | md5('4324') | 12345681           | 2019-09-19       | CR   | -123.40  | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1235\|\|4325\|\|12345682') | md5('1235') | md5('4325') | 12345682           | 2019-09-19       | CR   | 37645.34 | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1236\|\|4326\|\|12345683') | md5('1236') | md5('4326') | 12345683           | 2019-09-19       | CR   | 236.55   | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1237\|\|4327\|\|12345684') | md5('1237') | md5('4327') | 12345684           | 2019-09-19       | DR   | 3567.34  | 2019-09-19     | 2019-09-21 | SAP    |
    And the RAW_STAGE table contains data
      | CUSTOMER_ID | ORDER_ID | TRANSACTION_NUMBER | TRANSACTION_DATE | TYPE | AMOUNT   | LOAD_DATE  | SOURCE |
      | 1234        | 1238     | 12345685           | 2019-09-20       | DR   | 3478.50  | 2019-09-22 | SAP    |
      | 1234        | 1239     | 12345686           | 2019-09-20       | DR   | 10.00    | 2019-09-22 | SAP    |
      | 1235        | 1240     | 12345687           | 2019-09-20       | DR   | 1734.65  | 2019-09-22 | SAP    |
      | 1236        | 1241     | 12345688           | 2019-09-20       | DR   | 4832.56  | 2019-09-22 | SAP    |
      | 1237        | 1242     | 12345689           | 2019-09-20       | DR   | 10000.00 | 2019-09-22 | SAP    |
      | 1238        | 1243     | 12345690           | 2019-09-20       | CR   | 6823.55  | 2019-09-22 | SAP    |
      | 1238        | 1244     | 12345691           | 2019-09-20       | CR   | 4578.34  | 2019-09-22 | SAP    |
    And I create the STG_CUSTOMER stage
    And I load the T_LINK t_link
    And the RAW_STAGE is loaded
      | CUSTOMER_ID | ORDER_ID | TRANSACTION_NUMBER | TRANSACTION_DATE | TYPE | AMOUNT   | LOAD_DATE  | SOURCE |
      | 1234        | 1245     | 12345692           | 2019-09-21       | CR   | 234.56   | 2019-09-23 | SAP    |
      | 1234        | 1246     | 12345693           | 2019-09-21       | DR   | 30.00    | 2019-09-23 | SAP    |
      | 1236        | 1247     | 12345694           | 2019-09-21       | CR   | 456.65   | 2019-09-23 | SAP    |
      | 1236        | 1248     | 12345695           | 2019-09-21       | DR   | 453.98   | 2019-09-23 | SAP    |
      | 1237        | 1249     | 12345696           | 2019-09-21       | CR   | 40000.00 | 2019-09-23 | SAP    |
      | 1239        | 1250     | 12345697           | 2019-09-21       | DR   | 34.87    | 2019-09-23 | SAP    |
      | 1239        | 1251     | 12345698           | 2019-09-21       | CR   | 4567.87  | 2019-09-23 | SAP    |
    And I load the T_LINK t_link
    Then the T_LINK table should contain expected data
      | TRANSACTION_PK                  | CUSTOMER_FK | ORDER_FK    | TRANSACTION_NUMBER | TRANSACTION_DATE | TYPE | AMOUNT   | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | md5('1234\|\|4321\|\|12345678') | md5('1234') | md5('4321') | 12345678           | 2019-09-19       | DR   | 2340.50  | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1234\|\|4322\|\|12345679') | md5('1234') | md5('4322') | 12345679           | 2019-09-19       | CR   | 123.40   | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1234\|\|4323\|\|12345680') | md5('1234') | md5('4323') | 12345680           | 2019-09-19       | DR   | 2546.23  | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1234\|\|4324\|\|12345681') | md5('1234') | md5('4324') | 12345681           | 2019-09-19       | CR   | -123.40  | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1235\|\|4325\|\|12345682') | md5('1235') | md5('4325') | 12345682           | 2019-09-19       | CR   | 37645.34 | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1236\|\|4326\|\|12345683') | md5('1236') | md5('4326') | 12345683           | 2019-09-19       | CR   | 236.55   | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1237\|\|4327\|\|12345684') | md5('1237') | md5('4327') | 12345684           | 2019-09-19       | DR   | 3567.34  | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1234\|\|1238\|\|12345685') | md5('1234') | md5('1238') | 12345685           | 2019-09-20       | DR   | 3478.50  | 2019-09-20     | 2019-09-22 | SAP    |
      | md5('1234\|\|1239\|\|12345686') | md5('1234') | md5('1239') | 12345686           | 2019-09-20       | DR   | 10.00    | 2019-09-20     | 2019-09-22 | SAP    |
      | md5('1235\|\|1240\|\|12345687') | md5('1235') | md5('1240') | 12345687           | 2019-09-20       | DR   | 1734.65  | 2019-09-20     | 2019-09-22 | SAP    |
      | md5('1236\|\|1241\|\|12345688') | md5('1236') | md5('1241') | 12345688           | 2019-09-20       | DR   | 4832.56  | 2019-09-20     | 2019-09-22 | SAP    |
      | md5('1237\|\|1242\|\|12345689') | md5('1237') | md5('1242') | 12345689           | 2019-09-20       | DR   | 10000.00 | 2019-09-20     | 2019-09-22 | SAP    |
      | md5('1238\|\|1243\|\|12345690') | md5('1238') | md5('1243') | 12345690           | 2019-09-20       | CR   | 6823.55  | 2019-09-20     | 2019-09-22 | SAP    |
      | md5('1238\|\|1244\|\|12345691') | md5('1238') | md5('1244') | 12345691           | 2019-09-20       | CR   | 4578.34  | 2019-09-20     | 2019-09-22 | SAP    |
      | md5('1234\|\|1245\|\|12345692') | md5('1234') | md5('1245') | 12345692           | 2019-09-21       | CR   | 234.56   | 2019-09-21     | 2019-09-23 | SAP    |
      | md5('1234\|\|1246\|\|12345693') | md5('1234') | md5('1246') | 12345693           | 2019-09-21       | DR   | 30.00    | 2019-09-21     | 2019-09-23 | SAP    |
      | md5('1236\|\|1247\|\|12345694') | md5('1236') | md5('1247') | 12345694           | 2019-09-21       | CR   | 456.65   | 2019-09-21     | 2019-09-23 | SAP    |
      | md5('1236\|\|1248\|\|12345695') | md5('1236') | md5('1248') | 12345695           | 2019-09-21       | DR   | 453.98   | 2019-09-21     | 2019-09-23 | SAP    |
      | md5('1237\|\|1249\|\|12345696') | md5('1237') | md5('1249') | 12345696           | 2019-09-21       | CR   | 40000.00 | 2019-09-21     | 2019-09-23 | SAP    |
      | md5('1239\|\|1250\|\|12345697') | md5('1239') | md5('1250') | 12345697           | 2019-09-21       | DR   | 34.87    | 2019-09-21     | 2019-09-23 | SAP    |
      | md5('1239\|\|1251\|\|12345698') | md5('1239') | md5('1251') | 12345698           | 2019-09-21       | CR   | 4567.87  | 2019-09-21     | 2019-09-23 | SAP    |

  @fixture.t_link_bigquery
  Scenario: [ERROR-LOAD] Erroneous duplicate load of Transactional Link does not load duplicates
    Given the T_LINK t_link is already populated with data
      | TRANSACTION_PK                  | CUSTOMER_FK | ORDER_FK    | TRANSACTION_NUMBER | TRANSACTION_DATE | TYPE | AMOUNT   | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | md5('1234\|\|4321\|\|12345678') | md5('1234') | md5('4321') | 12345678           | 2019-09-19       | DR   | 2340.50  | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1234\|\|4322\|\|12345679') | md5('1234') | md5('4322') | 12345679           | 2019-09-19       | CR   | 123.40   | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1234\|\|4323\|\|12345680') | md5('1234') | md5('4323') | 12345680           | 2019-09-19       | DR   | 2546.23  | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1234\|\|4324\|\|12345681') | md5('1234') | md5('4324') | 12345681           | 2019-09-19       | CR   | -123.40  | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1235\|\|4325\|\|12345682') | md5('1235') | md5('4325') | 12345682           | 2019-09-19       | CR   | 37645.34 | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1236\|\|4326\|\|12345683') | md5('1236') | md5('4326') | 12345683           | 2019-09-19       | CR   | 236.55   | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1237\|\|4327\|\|12345684') | md5('1237') | md5('4327') | 12345684           | 2019-09-19       | DR   | 3567.34  | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1234\|\|1238\|\|12345685') | md5('1234') | md5('1238') | 12345685           | 2019-09-20       | DR   | 3478.50  | 2019-09-20     | 2019-09-22 | SAP    |
      | md5('1234\|\|1239\|\|12345686') | md5('1234') | md5('1239') | 12345686           | 2019-09-20       | DR   | 10.00    | 2019-09-20     | 2019-09-22 | SAP    |
      | md5('1235\|\|1240\|\|12345687') | md5('1235') | md5('1240') | 12345687           | 2019-09-20       | DR   | 1734.65  | 2019-09-20     | 2019-09-22 | SAP    |
      | md5('1236\|\|1241\|\|12345688') | md5('1236') | md5('1241') | 12345688           | 2019-09-20       | DR   | 4832.56  | 2019-09-20     | 2019-09-22 | SAP    |
      | md5('1237\|\|1242\|\|12345689') | md5('1237') | md5('1242') | 12345689           | 2019-09-20       | DR   | 10000.00 | 2019-09-20     | 2019-09-22 | SAP    |
      | md5('1238\|\|1243\|\|12345690') | md5('1238') | md5('1243') | 12345690           | 2019-09-20       | CR   | 6823.55  | 2019-09-20     | 2019-09-22 | SAP    |
      | md5('1238\|\|1244\|\|12345691') | md5('1238') | md5('1244') | 12345691           | 2019-09-20       | CR   | 4578.34  | 2019-09-20     | 2019-09-22 | SAP    |
    And the RAW_STAGE table contains data
      | CUSTOMER_ID | ORDER_ID | TRANSACTION_NUMBER | TRANSACTION_DATE | TYPE | AMOUNT   | LOAD_DATE  | SOURCE |
      | 1234        | 4321     | 12345678           | 2019-09-20       | DR   | 2340.50  | 2019-09-22 | SAP    |
      | 1234        | 4322     | 12345679           | 2019-09-20       | CR   | 123.40   | 2019-09-22 | SAP    |
      | 1234        | 4323     | 12345680           | 2019-09-20       | DR   | 2546.23  | 2019-09-22 | SAP    |
      | 1234        | 4324     | 12345681           | 2019-09-20       | CR   | -123.40  | 2019-09-22 | SAP    |
      | 1235        | 4325     | 12345682           | 2019-09-20       | CR   | 37645.34 | 2019-09-22 | SAP    |
      | 1236        | 4326     | 12345683           | 2019-09-20       | CR   | 236.55   | 2019-09-22 | SAP    |
      | 1237        | 4327     | 12345684           | 2019-09-20       | DR   | 3567.34  | 2019-09-22 | SAP    |
    And I create the STG_CUSTOMER stage
    And I load the T_LINK t_link
    Then the T_LINK table should contain expected data
      | TRANSACTION_PK                  | CUSTOMER_FK | ORDER_FK    | TRANSACTION_NUMBER | TRANSACTION_DATE | TYPE | AMOUNT   | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | md5('1234\|\|4321\|\|12345678') | md5('1234') | md5('4321') | 12345678           | 2019-09-19       | DR   | 2340.50  | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1234\|\|4322\|\|12345679') | md5('1234') | md5('4322') | 12345679           | 2019-09-19       | CR   | 123.40   | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1234\|\|4323\|\|12345680') | md5('1234') | md5('4323') | 12345680           | 2019-09-19       | DR   | 2546.23  | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1234\|\|4324\|\|12345681') | md5('1234') | md5('4324') | 12345681           | 2019-09-19       | CR   | -123.40  | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1235\|\|4325\|\|12345682') | md5('1235') | md5('4325') | 12345682           | 2019-09-19       | CR   | 37645.34 | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1236\|\|4326\|\|12345683') | md5('1236') | md5('4326') | 12345683           | 2019-09-19       | CR   | 236.55   | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1237\|\|4327\|\|12345684') | md5('1237') | md5('4327') | 12345684           | 2019-09-19       | DR   | 3567.34  | 2019-09-19     | 2019-09-21 | SAP    |
      | md5('1234\|\|1238\|\|12345685') | md5('1234') | md5('1238') | 12345685           | 2019-09-20       | DR   | 3478.50  | 2019-09-20     | 2019-09-22 | SAP    |
      | md5('1234\|\|1239\|\|12345686') | md5('1234') | md5('1239') | 12345686           | 2019-09-20       | DR   | 10.00    | 2019-09-20     | 2019-09-22 | SAP    |
      | md5('1235\|\|1240\|\|12345687') | md5('1235') | md5('1240') | 12345687           | 2019-09-20       | DR   | 1734.65  | 2019-09-20     | 2019-09-22 | SAP    |
      | md5('1236\|\|1241\|\|12345688') | md5('1236') | md5('1241') | 12345688           | 2019-09-20       | DR   | 4832.56  | 2019-09-20     | 2019-09-22 | SAP    |
      | md5('1237\|\|1242\|\|12345689') | md5('1237') | md5('1242') | 12345689           | 2019-09-20       | DR   | 10000.00 | 2019-09-20     | 2019-09-22 | SAP    |
      | md5('1238\|\|1243\|\|12345690') | md5('1238') | md5('1243') | 12345690           | 2019-09-20       | CR   | 6823.55  | 2019-09-20     | 2019-09-22 | SAP    |
      | md5('1238\|\|1244\|\|12345691') | md5('1238') | md5('1244') | 12345691           | 2019-09-20       | CR   | 4578.34  | 2019-09-20     | 2019-09-22 | SAP    |
