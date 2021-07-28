@fixture.set_workdir
Feature: Multi Active Satellites - Base loads with actual MAS behaviour with two CDKs

  @fixture.multi_active_satellite_sqlserver
  Scenario: [BASE-LOAD] Load data into a non-existent multi-active satellite, where some customers have the same phone number but different extensions and others have different phone numbers but the same extensions
    Given the MULTI_ACTIVE_SATELLITE_TWO_CDK table does not exist
    And the RAW_STAGE_TWO_CDK table contains data
      | CUSTOMER_ID | CUSTOMER_NAME | CUSTOMER_PHONE  | EXTENSION | LOAD_DATE  | SOURCE |
      | 1001        | Alice         | 17-214-233-1214 | 12301     | 1993-01-01 | *      |
      | 1001        | Alice         | 17-214-233-1214 | 12302     | 1993-01-01 | *      |
      | 1001        | Alice         | 17-214-233-1214 | 12303     | 1993-01-01 | *      |
      | 1002        | Bob           | 17-214-233-1215 | 12311     | 1993-01-01 | *      |
      | 1002        | Bob           | 17-214-233-1215 | 12312     | 1993-01-01 | *      |
      | 1002        | Bob           | 17-214-233-1215 | 12313     | 1993-01-01 | *      |
      | 1003        | Chad          | 17-214-233-1216 | 12321     | 1993-01-01 | *      |
      | 1003        | Chad          | 17-214-233-1226 | 12321     | 1993-01-01 | *      |
      | 1003        | Chad          | 17-214-233-1236 | 12321     | 1993-01-01 | *      |
      | 1004        | Dom           | 17-214-233-1217 | 12331     | 1993-01-01 | *      |
      | 1004        | Dom           | 17-214-233-1227 | 12331     | 1993-01-01 | *      |
      | 1004        | Dom           | 17-214-233-1237 | 12331     | 1993-01-01 | *      |
    And I create the STG_CUSTOMER_TWO_CDK stage
    When I load the MULTI_ACTIVE_SATELLITE_TWO_CDK ma_sat
    Then the MULTI_ACTIVE_SATELLITE_TWO_CDK table should contain expected data
      | CUSTOMER_PK | HASHDIFF                                         | CUSTOMER_NAME | CUSTOMER_PHONE  | EXTENSION | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | md5('1001') | md5('1001\|\|ALICE\|\|17-214-233-1214\|\|12301') | Alice         | 17-214-233-1214 | 12301     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1001') | md5('1001\|\|ALICE\|\|17-214-233-1214\|\|12302') | Alice         | 17-214-233-1214 | 12302     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1001') | md5('1001\|\|ALICE\|\|17-214-233-1214\|\|12303') | Alice         | 17-214-233-1214 | 12303     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1002') | md5('1002\|\|BOB\|\|17-214-233-1215\|\|12311')   | Bob           | 17-214-233-1215 | 12311     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1002') | md5('1002\|\|BOB\|\|17-214-233-1215\|\|12312')   | Bob           | 17-214-233-1215 | 12312     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1002') | md5('1002\|\|BOB\|\|17-214-233-1215\|\|12313')   | Bob           | 17-214-233-1215 | 12313     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1003') | md5('1003\|\|CHAD\|\|17-214-233-1216\|\|12321')  | Chad          | 17-214-233-1216 | 12321     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1003') | md5('1003\|\|CHAD\|\|17-214-233-1226\|\|12321')  | Chad          | 17-214-233-1226 | 12321     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1003') | md5('1003\|\|CHAD\|\|17-214-233-1236\|\|12321')  | Chad          | 17-214-233-1236 | 12321     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1004') | md5('1004\|\|DOM\|\|17-214-233-1217\|\|12331')   | Dom           | 17-214-233-1217 | 12331     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1004') | md5('1004\|\|DOM\|\|17-214-233-1227\|\|12331')   | Dom           | 17-214-233-1227 | 12331     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1004') | md5('1004\|\|DOM\|\|17-214-233-1237\|\|12331')   | Dom           | 17-214-233-1237 | 12331     | 1993-01-01     | 1993-01-01 | *      |

  @fixture.multi_active_satellite_sqlserver
  Scenario: [BASE-LOAD] Load duplicated data into a non-existent multi-active satellite
    Given the MULTI_ACTIVE_SATELLITE_TWO_CDK table does not exist
    And the RAW_STAGE_TWO_CDK table contains data
      | CUSTOMER_ID | CUSTOMER_NAME | CUSTOMER_PHONE  | EXTENSION | LOAD_DATE  | SOURCE |
      | 1001        | Alice         | 17-214-233-1214 | 12301     | 1993-01-01 | *      |
      | 1001        | Alice         | 17-214-233-1214 | 12302     | 1993-01-01 | *      |
      | 1001        | Alice         | 17-214-233-1214 | 12303     | 1993-01-01 | *      |
      | 1001        | Alice         | 17-214-233-1214 | 12303     | 1993-01-01 | *      |
      | 1002        | Bob           | 17-214-233-1215 | 12311     | 1993-01-01 | *      |
      | 1002        | Bob           | 17-214-233-1215 | 12312     | 1993-01-01 | *      |
      | 1002        | Bob           | 17-214-233-1215 | 12313     | 1993-01-01 | *      |
      | 1003        | Chad          | 17-214-233-1216 | 12321     | 1993-01-01 | *      |
      | 1003        | Chad          | 17-214-233-1226 | 12321     | 1993-01-01 | *      |
      | 1003        | Chad          | 17-214-233-1236 | 12321     | 1993-01-01 | *      |
      | 1004        | Dom           | 17-214-233-1217 | 12331     | 1993-01-01 | *      |
      | 1004        | Dom           | 17-214-233-1217 | 12331     | 1993-01-01 | *      |
      | 1004        | Dom           | 17-214-233-1227 | 12331     | 1993-01-01 | *      |
      | 1004        | Dom           | 17-214-233-1237 | 12331     | 1993-01-01 | *      |
    And I create the STG_CUSTOMER_TWO_CDK stage
    When I load the MULTI_ACTIVE_SATELLITE_TWO_CDK ma_sat
    Then the MULTI_ACTIVE_SATELLITE_TWO_CDK table should contain expected data
      | CUSTOMER_PK | HASHDIFF                                         | CUSTOMER_NAME | CUSTOMER_PHONE  | EXTENSION | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | md5('1001') | md5('1001\|\|ALICE\|\|17-214-233-1214\|\|12301') | Alice         | 17-214-233-1214 | 12301     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1001') | md5('1001\|\|ALICE\|\|17-214-233-1214\|\|12302') | Alice         | 17-214-233-1214 | 12302     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1001') | md5('1001\|\|ALICE\|\|17-214-233-1214\|\|12303') | Alice         | 17-214-233-1214 | 12303     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1002') | md5('1002\|\|BOB\|\|17-214-233-1215\|\|12311')   | Bob           | 17-214-233-1215 | 12311     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1002') | md5('1002\|\|BOB\|\|17-214-233-1215\|\|12312')   | Bob           | 17-214-233-1215 | 12312     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1002') | md5('1002\|\|BOB\|\|17-214-233-1215\|\|12313')   | Bob           | 17-214-233-1215 | 12313     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1003') | md5('1003\|\|CHAD\|\|17-214-233-1216\|\|12321')  | Chad          | 17-214-233-1216 | 12321     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1003') | md5('1003\|\|CHAD\|\|17-214-233-1226\|\|12321')  | Chad          | 17-214-233-1226 | 12321     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1003') | md5('1003\|\|CHAD\|\|17-214-233-1236\|\|12321')  | Chad          | 17-214-233-1236 | 12321     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1004') | md5('1004\|\|DOM\|\|17-214-233-1217\|\|12331')   | Dom           | 17-214-233-1217 | 12331     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1004') | md5('1004\|\|DOM\|\|17-214-233-1227\|\|12331')   | Dom           | 17-214-233-1227 | 12331     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1004') | md5('1004\|\|DOM\|\|17-214-233-1237\|\|12331')   | Dom           | 17-214-233-1237 | 12331     | 1993-01-01     | 1993-01-01 | *      |

  @fixture.multi_active_satellite_sqlserver
  Scenario: [BASE-LOAD-EMPTY] Load data into an empty multi-active satellite
    Given the MULTI_ACTIVE_SATELLITE_TWO_CDK ma_sat is empty
    And the RAW_STAGE_TWO_CDK table contains data
      | CUSTOMER_ID | CUSTOMER_NAME | CUSTOMER_PHONE  | EXTENSION | LOAD_DATE  | SOURCE |
      | 1001        | Alice         | 17-214-233-1214 | 12301     | 1993-01-01 | *      |
      | 1001        | Alice         | 17-214-233-1214 | 12302     | 1993-01-01 | *      |
      | 1001        | Alice         | 17-214-233-1214 | 12303     | 1993-01-01 | *      |
      | 1002        | Bob           | 17-214-233-1215 | 12311     | 1993-01-01 | *      |
      | 1002        | Bob           | 17-214-233-1215 | 12312     | 1993-01-01 | *      |
      | 1002        | Bob           | 17-214-233-1215 | 12313     | 1993-01-01 | *      |
      | 1003        | Chad          | 17-214-233-1216 | 12321     | 1993-01-01 | *      |
      | 1003        | Chad          | 17-214-233-1226 | 12321     | 1993-01-01 | *      |
      | 1003        | Chad          | 17-214-233-1236 | 12321     | 1993-01-01 | *      |
      | 1004        | Dom           | 17-214-233-1217 | 12331     | 1993-01-01 | *      |
      | 1004        | Dom           | 17-214-233-1227 | 12331     | 1993-01-01 | *      |
      | 1004        | Dom           | 17-214-233-1237 | 12331     | 1993-01-01 | *      |
    And I create the STG_CUSTOMER_TWO_CDK stage
    When I load the MULTI_ACTIVE_SATELLITE_TWO_CDK ma_sat
    Then the MULTI_ACTIVE_SATELLITE_TWO_CDK table should contain expected data
      | CUSTOMER_PK | HASHDIFF                                         | CUSTOMER_NAME | CUSTOMER_PHONE  | EXTENSION | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | md5('1001') | md5('1001\|\|ALICE\|\|17-214-233-1214\|\|12301') | Alice         | 17-214-233-1214 | 12301     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1001') | md5('1001\|\|ALICE\|\|17-214-233-1214\|\|12302') | Alice         | 17-214-233-1214 | 12302     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1001') | md5('1001\|\|ALICE\|\|17-214-233-1214\|\|12303') | Alice         | 17-214-233-1214 | 12303     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1002') | md5('1002\|\|BOB\|\|17-214-233-1215\|\|12311')   | Bob           | 17-214-233-1215 | 12311     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1002') | md5('1002\|\|BOB\|\|17-214-233-1215\|\|12312')   | Bob           | 17-214-233-1215 | 12312     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1002') | md5('1002\|\|BOB\|\|17-214-233-1215\|\|12313')   | Bob           | 17-214-233-1215 | 12313     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1003') | md5('1003\|\|CHAD\|\|17-214-233-1216\|\|12321')  | Chad          | 17-214-233-1216 | 12321     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1003') | md5('1003\|\|CHAD\|\|17-214-233-1226\|\|12321')  | Chad          | 17-214-233-1226 | 12321     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1003') | md5('1003\|\|CHAD\|\|17-214-233-1236\|\|12321')  | Chad          | 17-214-233-1236 | 12321     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1004') | md5('1004\|\|DOM\|\|17-214-233-1217\|\|12331')   | Dom           | 17-214-233-1217 | 12331     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1004') | md5('1004\|\|DOM\|\|17-214-233-1227\|\|12331')   | Dom           | 17-214-233-1227 | 12331     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1004') | md5('1004\|\|DOM\|\|17-214-233-1237\|\|12331')   | Dom           | 17-214-233-1237 | 12331     | 1993-01-01     | 1993-01-01 | *      |

  @fixture.multi_active_satellite_sqlserver
  Scenario: [BASE-LOAD-EMPTY] Load duplicated data into an empty multi-active satellite
    Given the MULTI_ACTIVE_SATELLITE_TWO_CDK ma_sat is empty
    And the RAW_STAGE_TWO_CDK table contains data
      | CUSTOMER_ID | CUSTOMER_NAME | CUSTOMER_PHONE  | EXTENSION | LOAD_DATE  | SOURCE |
      | 1001        | Alice         | 17-214-233-1214 | 12301     | 1993-01-01 | *      |
      | 1001        | Alice         | 17-214-233-1214 | 12302     | 1993-01-01 | *      |
      | 1001        | Alice         | 17-214-233-1214 | 12303     | 1993-01-01 | *      |
      | 1001        | Alice         | 17-214-233-1214 | 12303     | 1993-01-01 | *      |
      | 1002        | Bob           | 17-214-233-1215 | 12311     | 1993-01-01 | *      |
      | 1002        | Bob           | 17-214-233-1215 | 12312     | 1993-01-01 | *      |
      | 1002        | Bob           | 17-214-233-1215 | 12313     | 1993-01-01 | *      |
      | 1003        | Chad          | 17-214-233-1216 | 12321     | 1993-01-01 | *      |
      | 1003        | Chad          | 17-214-233-1226 | 12321     | 1993-01-01 | *      |
      | 1003        | Chad          | 17-214-233-1236 | 12321     | 1993-01-01 | *      |
      | 1004        | Dom           | 17-214-233-1217 | 12331     | 1993-01-01 | *      |
      | 1004        | Dom           | 17-214-233-1217 | 12331     | 1993-01-01 | *      |
      | 1004        | Dom           | 17-214-233-1227 | 12331     | 1993-01-01 | *      |
      | 1004        | Dom           | 17-214-233-1237 | 12331     | 1993-01-01 | *      |
    And I create the STG_CUSTOMER_TWO_CDK stage
    When I load the MULTI_ACTIVE_SATELLITE_TWO_CDK ma_sat
    Then the MULTI_ACTIVE_SATELLITE_TWO_CDK table should contain expected data
      | CUSTOMER_PK | HASHDIFF                                         | CUSTOMER_NAME | CUSTOMER_PHONE  | EXTENSION | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | md5('1001') | md5('1001\|\|ALICE\|\|17-214-233-1214\|\|12301') | Alice         | 17-214-233-1214 | 12301     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1001') | md5('1001\|\|ALICE\|\|17-214-233-1214\|\|12302') | Alice         | 17-214-233-1214 | 12302     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1001') | md5('1001\|\|ALICE\|\|17-214-233-1214\|\|12303') | Alice         | 17-214-233-1214 | 12303     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1002') | md5('1002\|\|BOB\|\|17-214-233-1215\|\|12311')   | Bob           | 17-214-233-1215 | 12311     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1002') | md5('1002\|\|BOB\|\|17-214-233-1215\|\|12312')   | Bob           | 17-214-233-1215 | 12312     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1002') | md5('1002\|\|BOB\|\|17-214-233-1215\|\|12313')   | Bob           | 17-214-233-1215 | 12313     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1003') | md5('1003\|\|CHAD\|\|17-214-233-1216\|\|12321')  | Chad          | 17-214-233-1216 | 12321     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1003') | md5('1003\|\|CHAD\|\|17-214-233-1226\|\|12321')  | Chad          | 17-214-233-1226 | 12321     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1003') | md5('1003\|\|CHAD\|\|17-214-233-1236\|\|12321')  | Chad          | 17-214-233-1236 | 12321     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1004') | md5('1004\|\|DOM\|\|17-214-233-1217\|\|12331')   | Dom           | 17-214-233-1217 | 12331     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1004') | md5('1004\|\|DOM\|\|17-214-233-1227\|\|12331')   | Dom           | 17-214-233-1227 | 12331     | 1993-01-01     | 1993-01-01 | *      |
      | md5('1004') | md5('1004\|\|DOM\|\|17-214-233-1237\|\|12331')   | Dom           | 17-214-233-1237 | 12331     | 1993-01-01     | 1993-01-01 | *      |

  @fixture.multi_active_satellite_sqlserver
  Scenario: [BASE-LOAD-NULLS] Load data into an empty multi-active satellite where some records have NULL CDK(s) or Attribute(s)
    Given the MULTI_ACTIVE_SATELLITE_TWO_CDK ma_sat is empty
    And the RAW_STAGE_TWO_CDK table contains data
      | CUSTOMER_ID | CUSTOMER_NAME | CUSTOMER_PHONE  | EXTENSION | LOAD_DATE  | SOURCE |
      | 1001        | Alice         | 17-214-233-1214 | 12301     | 1993-01-01 | *      |
      | 1001        | Alice         | 17-214-233-1214 | 12302     | 1993-01-01 | *      |
      | 1001        | Alice         | 17-214-233-1214 | 12303     | 1993-01-01 | *      |
      | 1002        | Bob           | 17-214-233-1215 | 12311     | 1993-01-01 | *      |
      | 1002        | Bob           | 17-214-233-1225 | 12311     | 1993-01-01 | *      |
      | 1002        | Bob           | 17-214-233-1235 | 12311     | 1993-01-01 | *      |
      | 1004        | <null>        | <null>          | <null>    | 1993-01-01 | *      |
      | <null>      | <null>        | <null>          | 12321     | 1993-01-01 | *      |
      | <null>      | <null>        | 17-214-233-1217 | <null>    | 1993-01-01 | *      |
      | <null>      | Dom           | <null>          | <null>    | 1993-01-01 | *      |
      | 1004        | Dom           | <null>          | <null>    | 1993-01-01 | *      |
      | <null>      | <null>        | 17-214-233-1217 | 12321     | 1993-01-01 | *      |
      | 1004        | <null>        | <null>          | 12321     | 1993-01-01 | *      |
      | <null>      | Dom           | 17-214-233-1217 | <null>    | 1993-01-01 | *      |
      | 1004        | Dom           | 17-214-233-1227 | <null>    | 1993-01-01 | *      |
      | 1004        | Dom           | <null>          | 12321     | 1993-01-01 | *      |
      | 1004        | <null>        | 17-214-233-1217 | 12321     | 1993-01-01 | *      |
      | <null>      | Dom           | 17-214-233-1217 | <null>    | 1993-01-01 | *      |
    And I create the STG_CUSTOMER_TWO_CDK stage
    When I load the MULTI_ACTIVE_SATELLITE_TWO_CDK ma_sat
    Then the MULTI_ACTIVE_SATELLITE_TWO_CDK table should contain expected data
      | CUSTOMER_PK | CUSTOMER_NAME | CUSTOMER_PHONE  | EXTENSION | HASHDIFF                                         | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | md5('1001') | Alice         | 17-214-233-1214 | 12301     | md5('1001\|\|ALICE\|\|17-214-233-1214\|\|12301') | 1993-01-01     | 1993-01-01 | *      |
      | md5('1001') | Alice         | 17-214-233-1214 | 12302     | md5('1001\|\|ALICE\|\|17-214-233-1214\|\|12302') | 1993-01-01     | 1993-01-01 | *      |
      | md5('1001') | Alice         | 17-214-233-1214 | 12303     | md5('1001\|\|ALICE\|\|17-214-233-1214\|\|12303') | 1993-01-01     | 1993-01-01 | *      |
      | md5('1002') | Bob           | 17-214-233-1215 | 12311     | md5('1002\|\|BOB\|\|17-214-233-1215\|\|12311')   | 1993-01-01     | 1993-01-01 | *      |
      | md5('1002') | Bob           | 17-214-233-1225 | 12311     | md5('1002\|\|BOB\|\|17-214-233-1225\|\|12311')   | 1993-01-01     | 1993-01-01 | *      |
      | md5('1002') | Bob           | 17-214-233-1235 | 12311     | md5('1002\|\|BOB\|\|17-214-233-1235\|\|12311')   | 1993-01-01     | 1993-01-01 | *      |
      | md5('1004') | <null>        | 17-214-233-1217 | 12321     | md5('1004\|\|^^\|\|17-214-233-1217\|\|12321')    | 1993-01-01     | 1993-01-01 | *      |

