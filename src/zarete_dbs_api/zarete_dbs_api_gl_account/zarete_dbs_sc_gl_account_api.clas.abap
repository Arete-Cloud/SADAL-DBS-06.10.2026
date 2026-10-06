"! <p class="shorttext synchronized">Consumption model for client proxy - generated</p>
"! This class has been generated based on the metadata with namespace
"! <em>API_GLACCOUNTINCHARTOFACCOUNTS_SRV</em>
CLASS zarete_dbs_sc_gl_account_api DEFINITION
  PUBLIC
  INHERITING FROM /iwbep/cl_v4_abs_pm_model_prov
  CREATE PUBLIC.

  PUBLIC SECTION.

    TYPES:
      "! <p class="shorttext synchronized">A_GLAccountInChartOfAccountsType</p>
      BEGIN OF tys_a_glaccount_in_chart_of__2,
        "! <em>Key property</em> ChartOfAccounts
        chart_of_accounts          TYPE c LENGTH 4,
        "! <em>Key property</em> GLAccount
        glaccount                  TYPE c LENGTH 10,
        "! IsBalanceSheetAccount
        is_balance_sheet_account   TYPE abap_bool,
        "! GLAccountGroup
        glaccount_group            TYPE c LENGTH 4,
        "! CorporateGroupAccount
        corporate_group_account    TYPE c LENGTH 10,
        "! ProfitLossAccountType
        profit_loss_account_type   TYPE c LENGTH 2,
        "! SampleGLAccount
        sample_glaccount           TYPE c LENGTH 10,
        "! AccountIsMarkedForDeletion
        account_is_marked_for_dele TYPE abap_bool,
        "! AccountIsBlockedForCreation
        account_is_blocked_for_cre TYPE abap_bool,
        "! AccountIsBlockedForPosting
        account_is_blocked_for_pos TYPE abap_bool,
        "! AccountIsBlockedForPlanning
        account_is_blocked_for_pla TYPE abap_bool,
        "! PartnerCompany
        partner_company            TYPE c LENGTH 6,
        "! FunctionalArea
        functional_area            TYPE c LENGTH 16,
        "! CreationDate
        creation_date              TYPE datn,
        "! CreatedByUser
        created_by_user            TYPE c LENGTH 12,
        "! LastChangeDateTime
        last_change_date_time      TYPE timestamp,
        "! GLAccountType
        glaccount_type             TYPE c LENGTH 1,
        "! GLAccountExternal
        glaccount_external         TYPE c LENGTH 10,
        "! IsProfitLossAccount
        is_profit_loss_account     TYPE abap_bool,
      END OF tys_a_glaccount_in_chart_of__2,
      "! <p class="shorttext synchronized">List of A_GLAccountInChartOfAccountsType</p>
      tyt_a_glaccount_in_chart_of__2 TYPE STANDARD TABLE OF tys_a_glaccount_in_chart_of__2 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">A_GLAccountTextType</p>
      BEGIN OF tys_a_glaccount_text_type,
        "! <em>Key property</em> ChartOfAccounts
        chart_of_accounts     TYPE c LENGTH 4,
        "! <em>Key property</em> GLAccount
        glaccount             TYPE c LENGTH 10,
        "! <em>Key property</em> Language
        language              TYPE c LENGTH 2,
        "! GLAccountName
        glaccount_name        TYPE c LENGTH 20,
        "! GLAccountLongName
        glaccount_long_name   TYPE c LENGTH 50,
        "! LastChangeDateTime
        last_change_date_time TYPE timestamp,
      END OF tys_a_glaccount_text_type,
      "! <p class="shorttext synchronized">List of A_GLAccountTextType</p>
      tyt_a_glaccount_text_type TYPE STANDARD TABLE OF tys_a_glaccount_text_type WITH DEFAULT KEY.


    CONSTANTS:
      "! <p class="shorttext synchronized">Internal Names of the entity sets</p>
      BEGIN OF gcs_entity_set,
        "! A_GLAccountInChartOfAccounts
        "! <br/> Collection of type 'A_GLAccountInChartOfAccountsType'
        a_glaccount_in_chart_of_ac TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'A_GLACCOUNT_IN_CHART_OF_AC',
        "! A_GLAccountText
        "! <br/> Collection of type 'A_GLAccountTextType'
        a_glaccount_text           TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'A_GLACCOUNT_TEXT',
      END OF gcs_entity_set .

    CONSTANTS:
      "! <p class="shorttext synchronized">Internal names for entity types</p>
      BEGIN OF gcs_entity_type,
        "! <p class="shorttext synchronized">Internal names for A_GLAccountInChartOfAccountsType</p>
        "! See also structure type {@link ..tys_a_glaccount_in_chart_of__2}
        BEGIN OF a_glaccount_in_chart_of__2,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! to_Text
            to_text TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'TO_TEXT',
          END OF navigation,
        END OF a_glaccount_in_chart_of__2,
        "! <p class="shorttext synchronized">Internal names for A_GLAccountTextType</p>
        "! See also structure type {@link ..tys_a_glaccount_text_type}
        BEGIN OF a_glaccount_text_type,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! to_GLAccountInChartOfAccounts
            to_glaccount_in_chart_of_a TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'TO_GLACCOUNT_IN_CHART_OF_A',
          END OF navigation,
        END OF a_glaccount_text_type,
      END OF gcs_entity_type.


    METHODS /iwbep/if_v4_mp_basic_pm~define REDEFINITION.


  PRIVATE SECTION.

    "! <p class="shorttext synchronized">Model</p>
    DATA mo_model TYPE REF TO /iwbep/if_v4_pm_model.


    "! <p class="shorttext synchronized">Define A_GLAccountInChartOfAccountsType</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_a_glaccount_in_chart_of__2 RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define A_GLAccountTextType</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_a_glaccount_text_type RAISING /iwbep/cx_gateway.

ENDCLASS.



CLASS ZARETE_DBS_SC_GL_ACCOUNT_API IMPLEMENTATION.


  METHOD /iwbep/if_v4_mp_basic_pm~define.

    mo_model = io_model.
    mo_model->set_schema_namespace( 'API_GLACCOUNTINCHARTOFACCOUNTS_SRV' ) ##NO_TEXT.

    def_a_glaccount_in_chart_of__2( ).
    def_a_glaccount_text_type( ).

  ENDMETHOD.


  METHOD def_a_glaccount_in_chart_of__2.

    DATA:
      lo_complex_property    TYPE REF TO /iwbep/if_v4_pm_cplx_prop,
      lo_entity_type         TYPE REF TO /iwbep/if_v4_pm_entity_type,
      lo_entity_set          TYPE REF TO /iwbep/if_v4_pm_entity_set,
      lo_navigation_property TYPE REF TO /iwbep/if_v4_pm_nav_prop,
      lo_primitive_property  TYPE REF TO /iwbep/if_v4_pm_prim_prop.


    lo_entity_type = mo_model->create_entity_type_by_struct(
                                    iv_entity_type_name       = 'A_GLACCOUNT_IN_CHART_OF__2'
                                    is_structure              = VALUE tys_a_glaccount_in_chart_of__2( )
                                    iv_do_gen_prim_props         = abap_true
                                    iv_do_gen_prim_prop_colls    = abap_true
                                    iv_do_add_conv_to_prim_props = abap_true ).

    lo_entity_type->set_edm_name( 'A_GLAccountInChartOfAccountsType' ) ##NO_TEXT.


    lo_entity_set = lo_entity_type->create_entity_set( 'A_GLACCOUNT_IN_CHART_OF_AC' ).
    lo_entity_set->set_edm_name( 'A_GLAccountInChartOfAccounts' ) ##NO_TEXT.


    lo_primitive_property = lo_entity_type->get_primitive_property( 'CHART_OF_ACCOUNTS' ).
    lo_primitive_property->set_edm_name( 'ChartOfAccounts' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'GLACCOUNT' ).
    lo_primitive_property->set_edm_name( 'GLAccount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'IS_BALANCE_SHEET_ACCOUNT' ).
    lo_primitive_property->set_edm_name( 'IsBalanceSheetAccount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'GLACCOUNT_GROUP' ).
    lo_primitive_property->set_edm_name( 'GLAccountGroup' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CORPORATE_GROUP_ACCOUNT' ).
    lo_primitive_property->set_edm_name( 'CorporateGroupAccount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PROFIT_LOSS_ACCOUNT_TYPE' ).
    lo_primitive_property->set_edm_name( 'ProfitLossAccountType' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'SAMPLE_GLACCOUNT' ).
    lo_primitive_property->set_edm_name( 'SampleGLAccount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ACCOUNT_IS_MARKED_FOR_DELE' ).
    lo_primitive_property->set_edm_name( 'AccountIsMarkedForDeletion' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ACCOUNT_IS_BLOCKED_FOR_CRE' ).
    lo_primitive_property->set_edm_name( 'AccountIsBlockedForCreation' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ACCOUNT_IS_BLOCKED_FOR_POS' ).
    lo_primitive_property->set_edm_name( 'AccountIsBlockedForPosting' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ACCOUNT_IS_BLOCKED_FOR_PLA' ).
    lo_primitive_property->set_edm_name( 'AccountIsBlockedForPlanning' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PARTNER_COMPANY' ).
    lo_primitive_property->set_edm_name( 'PartnerCompany' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 6 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'FUNCTIONAL_AREA' ).
    lo_primitive_property->set_edm_name( 'FunctionalArea' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 16 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CREATION_DATE' ).
    lo_primitive_property->set_edm_name( 'CreationDate' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Date' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CREATED_BY_USER' ).
    lo_primitive_property->set_edm_name( 'CreatedByUser' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 12 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'LAST_CHANGE_DATE_TIME' ).
    lo_primitive_property->set_edm_name( 'LastChangeDateTime' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'DateTimeOffset' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'GLACCOUNT_TYPE' ).
    lo_primitive_property->set_edm_name( 'GLAccountType' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'GLACCOUNT_EXTERNAL' ).
    lo_primitive_property->set_edm_name( 'GLAccountExternal' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'IS_PROFIT_LOSS_ACCOUNT' ).
    lo_primitive_property->set_edm_name( 'IsProfitLossAccount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_navigation_property = lo_entity_type->create_navigation_property( 'TO_TEXT' ).
    lo_navigation_property->set_edm_name( 'to_Text' ) ##NO_TEXT.
    lo_navigation_property->set_target_entity_type_name( 'A_GLACCOUNT_TEXT_TYPE' ).
    lo_navigation_property->set_target_multiplicity( /iwbep/if_v4_pm_types=>gcs_nav_multiplicity-to_many_optional ).

  ENDMETHOD.


  METHOD def_a_glaccount_text_type.

    DATA:
      lo_complex_property    TYPE REF TO /iwbep/if_v4_pm_cplx_prop,
      lo_entity_type         TYPE REF TO /iwbep/if_v4_pm_entity_type,
      lo_entity_set          TYPE REF TO /iwbep/if_v4_pm_entity_set,
      lo_navigation_property TYPE REF TO /iwbep/if_v4_pm_nav_prop,
      lo_primitive_property  TYPE REF TO /iwbep/if_v4_pm_prim_prop.


    lo_entity_type = mo_model->create_entity_type_by_struct(
                                    iv_entity_type_name       = 'A_GLACCOUNT_TEXT_TYPE'
                                    is_structure              = VALUE tys_a_glaccount_text_type( )
                                    iv_do_gen_prim_props         = abap_true
                                    iv_do_gen_prim_prop_colls    = abap_true
                                    iv_do_add_conv_to_prim_props = abap_true ).

    lo_entity_type->set_edm_name( 'A_GLAccountTextType' ) ##NO_TEXT.


    lo_entity_set = lo_entity_type->create_entity_set( 'A_GLACCOUNT_TEXT' ).
    lo_entity_set->set_edm_name( 'A_GLAccountText' ) ##NO_TEXT.


    lo_primitive_property = lo_entity_type->get_primitive_property( 'CHART_OF_ACCOUNTS' ).
    lo_primitive_property->set_edm_name( 'ChartOfAccounts' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'GLACCOUNT' ).
    lo_primitive_property->set_edm_name( 'GLAccount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'LANGUAGE' ).
    lo_primitive_property->set_edm_name( 'Language' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'GLACCOUNT_NAME' ).
    lo_primitive_property->set_edm_name( 'GLAccountName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 20 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'GLACCOUNT_LONG_NAME' ).
    lo_primitive_property->set_edm_name( 'GLAccountLongName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 50 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'LAST_CHANGE_DATE_TIME' ).
    lo_primitive_property->set_edm_name( 'LastChangeDateTime' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'DateTimeOffset' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_navigation_property = lo_entity_type->create_navigation_property( 'TO_GLACCOUNT_IN_CHART_OF_A' ).
    lo_navigation_property->set_edm_name( 'to_GLAccountInChartOfAccounts' ) ##NO_TEXT.
    lo_navigation_property->set_target_entity_type_name( 'A_GLACCOUNT_IN_CHART_OF__2' ).
    lo_navigation_property->set_target_multiplicity( /iwbep/if_v4_pm_types=>gcs_nav_multiplicity-to_one ).

  ENDMETHOD.
ENDCLASS.
