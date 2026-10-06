"! <p class="shorttext synchronized">Consumption model for client proxy - generated</p>
"! This class has been generated based on the metadata with namespace
"! <em>YY1_HOUSEBANKACCOUNTLINK_CDS</em>
CLASS zarete_dbs_sc_house_bank_api DEFINITION
  PUBLIC
  INHERITING FROM /iwbep/cl_v4_abs_pm_model_prov
  CREATE PUBLIC.

  PUBLIC SECTION.

    TYPES:
      "! <p class="shorttext synchronized">YY1_HouseBankAccountLinkType</p>
      BEGIN OF tys_yy_1_house_bank_account__2,
        "! <em>Key property</em> CompanyCode
        company_code             TYPE c LENGTH 4,
        "! <em>Key property</em> HouseBank
        house_bank               TYPE c LENGTH 5,
        "! <em>Key property</em> HouseBankAccount
        house_bank_account       TYPE c LENGTH 5,
        "! BankAccountInternalID
        bank_account_internal_id TYPE c LENGTH 10,
        "! BankInternalID
        bank_internal_id         TYPE c LENGTH 15,
        "! BankCountry
        bank_country             TYPE c LENGTH 3,
        "! SWIFTCode
        swiftcode                TYPE c LENGTH 11,
        "! BankName
        bank_name                TYPE c LENGTH 60,
        "! BankNumber
        bank_number              TYPE c LENGTH 15,
        "! BankAccount
        bank_account             TYPE c LENGTH 18,
        "! BankAccountAlternative
        bank_account_alternative TYPE c LENGTH 24,
        "! ReferenceInfo
        reference_info           TYPE c LENGTH 27,
        "! BankControlKey
        bank_control_key         TYPE c LENGTH 2,
        "! BankAccountCurrency
        bank_account_currency    TYPE c LENGTH 5,
        "! IBAN
        iban                     TYPE c LENGTH 34,
        "! BankAccountDescription
        bank_account_description TYPE c LENGTH 60,
        "! GLAccount
        glaccount                TYPE c LENGTH 10,
        "! BankAccountHolderName
        bank_account_holder_name TYPE c LENGTH 60,
        "! BankAccountNumber
        bank_account_number      TYPE c LENGTH 40,
      END OF tys_yy_1_house_bank_account__2,
      "! <p class="shorttext synchronized">List of YY1_HouseBankAccountLinkType</p>
      tyt_yy_1_house_bank_account__2 TYPE STANDARD TABLE OF tys_yy_1_house_bank_account__2 WITH DEFAULT KEY.


    CONSTANTS:
      "! <p class="shorttext synchronized">Internal Names of the entity sets</p>
      BEGIN OF gcs_entity_set,
        "! YY1_HouseBankAccountLink
        "! <br/> Collection of type 'YY1_HouseBankAccountLinkType'
        yy_1_house_bank_account_li TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'YY_1_HOUSE_BANK_ACCOUNT_LI',
      END OF gcs_entity_set .

    CONSTANTS:
      "! <p class="shorttext synchronized">Internal names for entity types</p>
      BEGIN OF gcs_entity_type,
        "! <p class="shorttext synchronized">Internal names for YY1_HouseBankAccountLinkType</p>
        "! See also structure type {@link ..tys_yy_1_house_bank_account__2}
        BEGIN OF yy_1_house_bank_account__2,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! Dummy field - Structure must not be empty
            dummy TYPE int1 VALUE 0,
          END OF navigation,
        END OF yy_1_house_bank_account__2,
      END OF gcs_entity_type.


    METHODS /iwbep/if_v4_mp_basic_pm~define REDEFINITION.


  PRIVATE SECTION.

    "! <p class="shorttext synchronized">Model</p>
    DATA mo_model TYPE REF TO /iwbep/if_v4_pm_model.


    "! <p class="shorttext synchronized">Define YY1_HouseBankAccountLinkType</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_yy_1_house_bank_account__2 RAISING /iwbep/cx_gateway.

ENDCLASS.



CLASS ZARETE_DBS_SC_HOUSE_BANK_API IMPLEMENTATION.


  METHOD /iwbep/if_v4_mp_basic_pm~define.

    mo_model = io_model.
    mo_model->set_schema_namespace( 'YY1_HOUSEBANKACCOUNTLINK_CDS' ) ##NO_TEXT.

    def_yy_1_house_bank_account__2( ).

  ENDMETHOD.


  METHOD def_yy_1_house_bank_account__2.

    DATA:
      lo_complex_property    TYPE REF TO /iwbep/if_v4_pm_cplx_prop,
      lo_entity_type         TYPE REF TO /iwbep/if_v4_pm_entity_type,
      lo_entity_set          TYPE REF TO /iwbep/if_v4_pm_entity_set,
      lo_navigation_property TYPE REF TO /iwbep/if_v4_pm_nav_prop,
      lo_primitive_property  TYPE REF TO /iwbep/if_v4_pm_prim_prop.


    lo_entity_type = mo_model->create_entity_type_by_struct(
                                    iv_entity_type_name       = 'YY_1_HOUSE_BANK_ACCOUNT__2'
                                    is_structure              = VALUE tys_yy_1_house_bank_account__2( )
                                    iv_do_gen_prim_props         = abap_true
                                    iv_do_gen_prim_prop_colls    = abap_true
                                    iv_do_add_conv_to_prim_props = abap_true ).

    lo_entity_type->set_edm_name( 'YY1_HouseBankAccountLinkType' ) ##NO_TEXT.


    lo_entity_set = lo_entity_type->create_entity_set( 'YY_1_HOUSE_BANK_ACCOUNT_LI' ).
    lo_entity_set->set_edm_name( 'YY1_HouseBankAccountLink' ) ##NO_TEXT.


    lo_primitive_property = lo_entity_type->get_primitive_property( 'COMPANY_CODE' ).
    lo_primitive_property->set_edm_name( 'CompanyCode' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'HOUSE_BANK' ).
    lo_primitive_property->set_edm_name( 'HouseBank' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 5 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'HOUSE_BANK_ACCOUNT' ).
    lo_primitive_property->set_edm_name( 'HouseBankAccount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 5 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'BANK_ACCOUNT_INTERNAL_ID' ).
    lo_primitive_property->set_edm_name( 'BankAccountInternalID' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'BANK_INTERNAL_ID' ).
    lo_primitive_property->set_edm_name( 'BankInternalID' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 15 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'BANK_COUNTRY' ).
    lo_primitive_property->set_edm_name( 'BankCountry' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'SWIFTCODE' ).
    lo_primitive_property->set_edm_name( 'SWIFTCode' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 11 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'BANK_NAME' ).
    lo_primitive_property->set_edm_name( 'BankName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 60 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'BANK_NUMBER' ).
    lo_primitive_property->set_edm_name( 'BankNumber' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 15 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'BANK_ACCOUNT' ).
    lo_primitive_property->set_edm_name( 'BankAccount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 18 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'BANK_ACCOUNT_ALTERNATIVE' ).
    lo_primitive_property->set_edm_name( 'BankAccountAlternative' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 24 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'REFERENCE_INFO' ).
    lo_primitive_property->set_edm_name( 'ReferenceInfo' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 27 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'BANK_CONTROL_KEY' ).
    lo_primitive_property->set_edm_name( 'BankControlKey' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'BANK_ACCOUNT_CURRENCY' ).
    lo_primitive_property->set_edm_name( 'BankAccountCurrency' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 5 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'IBAN' ).
    lo_primitive_property->set_edm_name( 'IBAN' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 34 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'BANK_ACCOUNT_DESCRIPTION' ).
    lo_primitive_property->set_edm_name( 'BankAccountDescription' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 60 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'GLACCOUNT' ).
    lo_primitive_property->set_edm_name( 'GLAccount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'BANK_ACCOUNT_HOLDER_NAME' ).
    lo_primitive_property->set_edm_name( 'BankAccountHolderName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 60 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'BANK_ACCOUNT_NUMBER' ).
    lo_primitive_property->set_edm_name( 'BankAccountNumber' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 40 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

  ENDMETHOD.
ENDCLASS.
