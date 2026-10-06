"! <p class="shorttext synchronized">Consumption model for client proxy - generated</p>
"! This class has been generated based on the metadata with namespace
"! <em>API_COMPANYCODE_SRV</em>
CLASS zarete_dbs_sc_company_api DEFINITION
  PUBLIC
  INHERITING FROM /iwbep/cl_v4_abs_pm_model_prov
  CREATE PUBLIC.

  PUBLIC SECTION.

    TYPES:
      "! <p class="shorttext synchronized">A_CompanyCodeType</p>
      BEGIN OF tys_a_company_code_type,
        "! <em>Key property</em> CompanyCode
        company_code               TYPE c LENGTH 4,
        "! CompanyCodeName
        company_code_name          TYPE c LENGTH 25,
        "! CityName
        city_name                  TYPE c LENGTH 25,
        "! Country
        country                    TYPE c LENGTH 3,
        "! Currency
        currency                   TYPE c LENGTH 5,
        "! Language
        language                   TYPE c LENGTH 2,
        "! ChartOfAccounts
        chart_of_accounts          TYPE c LENGTH 4,
        "! FiscalYearVariant
        fiscal_year_variant        TYPE c LENGTH 2,
        "! Company
        company                    TYPE c LENGTH 6,
        "! CreditControlArea
        credit_control_area        TYPE c LENGTH 4,
        "! CountryChartOfAccounts
        country_chart_of_accounts  TYPE c LENGTH 4,
        "! FinancialManagementArea
        financial_management_area  TYPE c LENGTH 4,
        "! AddressID
        address_id                 TYPE c LENGTH 10,
        "! TaxableEntity
        taxable_entity             TYPE c LENGTH 4,
        "! VATRegistration
        vatregistration            TYPE c LENGTH 20,
        "! ExtendedWhldgTaxIsActive
        extended_whldg_tax_is_acti TYPE abap_bool,
        "! ControllingArea
        controlling_area           TYPE c LENGTH 4,
        "! FieldStatusVariant
        field_status_variant       TYPE c LENGTH 4,
        "! NonTaxableTransactionTaxCode
        non_taxable_transaction_ta TYPE c LENGTH 2,
        "! DocDateIsUsedForTaxDetn
        doc_date_is_used_for_tax_d TYPE abap_bool,
        "! TaxRptgDateIsActive
        tax_rptg_date_is_active    TYPE abap_bool,
      END OF tys_a_company_code_type,
      "! <p class="shorttext synchronized">List of A_CompanyCodeType</p>
      tyt_a_company_code_type TYPE STANDARD TABLE OF tys_a_company_code_type WITH DEFAULT KEY.


    CONSTANTS:
      "! <p class="shorttext synchronized">Internal Names of the entity sets</p>
      BEGIN OF gcs_entity_set,
        "! A_CompanyCode
        "! <br/> Collection of type 'A_CompanyCodeType'
        a_company_code TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'A_COMPANY_CODE',
      END OF gcs_entity_set .

    CONSTANTS:
      "! <p class="shorttext synchronized">Internal names for entity types</p>
      BEGIN OF gcs_entity_type,
        "! <p class="shorttext synchronized">Internal names for A_CompanyCodeType</p>
        "! See also structure type {@link ..tys_a_company_code_type}
        BEGIN OF a_company_code_type,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! Dummy field - Structure must not be empty
            dummy TYPE int1 VALUE 0,
          END OF navigation,
        END OF a_company_code_type,
      END OF gcs_entity_type.


    METHODS /iwbep/if_v4_mp_basic_pm~define REDEFINITION.


  PRIVATE SECTION.

    "! <p class="shorttext synchronized">Model</p>
    DATA mo_model TYPE REF TO /iwbep/if_v4_pm_model.


    "! <p class="shorttext synchronized">Define A_CompanyCodeType</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_a_company_code_type RAISING /iwbep/cx_gateway.

ENDCLASS.



CLASS ZARETE_DBS_SC_COMPANY_API IMPLEMENTATION.


  METHOD /iwbep/if_v4_mp_basic_pm~define.

    mo_model = io_model.
    mo_model->set_schema_namespace( 'API_COMPANYCODE_SRV' ) ##NO_TEXT.

    def_a_company_code_type( ).

  ENDMETHOD.


  METHOD def_a_company_code_type.

    DATA:
      lo_complex_property    TYPE REF TO /iwbep/if_v4_pm_cplx_prop,
      lo_entity_type         TYPE REF TO /iwbep/if_v4_pm_entity_type,
      lo_entity_set          TYPE REF TO /iwbep/if_v4_pm_entity_set,
      lo_navigation_property TYPE REF TO /iwbep/if_v4_pm_nav_prop,
      lo_primitive_property  TYPE REF TO /iwbep/if_v4_pm_prim_prop.


    lo_entity_type = mo_model->create_entity_type_by_struct(
                                    iv_entity_type_name       = 'A_COMPANY_CODE_TYPE'
                                    is_structure              = VALUE tys_a_company_code_type( )
                                    iv_do_gen_prim_props         = abap_true
                                    iv_do_gen_prim_prop_colls    = abap_true
                                    iv_do_add_conv_to_prim_props = abap_true ).

    lo_entity_type->set_edm_name( 'A_CompanyCodeType' ) ##NO_TEXT.


    lo_entity_set = lo_entity_type->create_entity_set( 'A_COMPANY_CODE' ).
    lo_entity_set->set_edm_name( 'A_CompanyCode' ) ##NO_TEXT.


    lo_primitive_property = lo_entity_type->get_primitive_property( 'COMPANY_CODE' ).
    lo_primitive_property->set_edm_name( 'CompanyCode' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'COMPANY_CODE_NAME' ).
    lo_primitive_property->set_edm_name( 'CompanyCodeName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 25 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CITY_NAME' ).
    lo_primitive_property->set_edm_name( 'CityName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 25 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'COUNTRY' ).
    lo_primitive_property->set_edm_name( 'Country' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CURRENCY' ).
    lo_primitive_property->set_edm_name( 'Currency' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 5 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'LANGUAGE' ).
    lo_primitive_property->set_edm_name( 'Language' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CHART_OF_ACCOUNTS' ).
    lo_primitive_property->set_edm_name( 'ChartOfAccounts' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'FISCAL_YEAR_VARIANT' ).
    lo_primitive_property->set_edm_name( 'FiscalYearVariant' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'COMPANY' ).
    lo_primitive_property->set_edm_name( 'Company' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 6 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CREDIT_CONTROL_AREA' ).
    lo_primitive_property->set_edm_name( 'CreditControlArea' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'COUNTRY_CHART_OF_ACCOUNTS' ).
    lo_primitive_property->set_edm_name( 'CountryChartOfAccounts' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'FINANCIAL_MANAGEMENT_AREA' ).
    lo_primitive_property->set_edm_name( 'FinancialManagementArea' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ADDRESS_ID' ).
    lo_primitive_property->set_edm_name( 'AddressID' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'TAXABLE_ENTITY' ).
    lo_primitive_property->set_edm_name( 'TaxableEntity' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'VATREGISTRATION' ).
    lo_primitive_property->set_edm_name( 'VATRegistration' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 20 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'EXTENDED_WHLDG_TAX_IS_ACTI' ).
    lo_primitive_property->set_edm_name( 'ExtendedWhldgTaxIsActive' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CONTROLLING_AREA' ).
    lo_primitive_property->set_edm_name( 'ControllingArea' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'FIELD_STATUS_VARIANT' ).
    lo_primitive_property->set_edm_name( 'FieldStatusVariant' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'NON_TAXABLE_TRANSACTION_TA' ).
    lo_primitive_property->set_edm_name( 'NonTaxableTransactionTaxCode' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'DOC_DATE_IS_USED_FOR_TAX_D' ).
    lo_primitive_property->set_edm_name( 'DocDateIsUsedForTaxDetn' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'TAX_RPTG_DATE_IS_ACTIVE' ).
    lo_primitive_property->set_edm_name( 'TaxRptgDateIsActive' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

  ENDMETHOD.
ENDCLASS.
