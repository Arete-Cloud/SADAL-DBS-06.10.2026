CLASS zarete_dbs_sc_finteo_api DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES:
      BEGIN OF ty_limit_data,
        limitId                TYPE int4,
        identifier             TYPE string,
        partyCode              TYPE string,
        partyTaxNumber         TYPE string,
        partyTitle             TYPE string,
        limit                  TYPE p LENGTH 15 DECIMALS 2,
        activeLimit            TYPE p LENGTH 15 DECIMALS 2,
        usedLimit              TYPE p LENGTH 15 DECIMALS 2,
        pendingInvoiceCount    TYPE int4,
        pendingInvoiceAmount   TYPE p LENGTH 15 DECIMALS 2,
        bankCode               TYPE string,
        bankName               TYPE string,
        currencyCode           TYPE string,
        isActive               TYPE abap_bool,
        guarantedinvoiceamount TYPE p LENGTH 15 DECIMALS 2,
        linkedIban             TYPE iban,
        fundedExposure         TYPE p LENGTH 15 DECIMALS 2,
      END OF ty_limit_data,

      BEGIN OF ty_limit,
        status        TYPE string,
        statusMessage TYPE string,
        data          TYPE STANDARD TABLE OF ty_limit_data WITH DEFAULT KEY,
      END OF ty_limit,

      BEGIN OF ty_invoice_data,
        identifier                   TYPE string,
        dbsInvoiceId                 TYPE string,
        amount                       TYPE p LENGTH 9 DECIMALS 2,
        currencyCode                 TYPE string,
        dueDate                      TYPE string,
        invoiceNumber                TYPE string,
        invoiceAmountDue             TYPE p LENGTH 9 DECIMALS 2,
        lastPaymentDate              TYPE string,
        partialGuaranteedAmount      TYPE p LENGTH 9 DECIMALS 2,
        amountRemainingBeforePayment TYPE p LENGTH 9 DECIMALS 2,
        paymentDescription           TYPE string,
        statusCode                   TYPE int4,
        statusDescription            TYPE string,
        transactionDate              TYPE string,
        dbsAccountId                 TYPE int4,
        partyCode                    TYPE string,
        partyTitle                   TYPE string,
        partyTaxNumber               TYPE string,
        bankCode                     TYPE string,
        bankName                     TYPE string,
      END OF ty_invoice_data,

      BEGIN OF ty_invoice,
        status        TYPE string,
        statusMessage TYPE string,
        data          TYPE STANDARD TABLE OF ty_invoice_data WITH DEFAULT KEY,
      END OF ty_invoice,

      BEGIN OF ty_upload_invoice_data,
        dbsInvoiceId TYPE string,
      END OF ty_upload_invoice_data,

      BEGIN OF ty_upload_invoice,
        status        TYPE string,
        statusMessage TYPE string,
        data          TYPE ty_upload_invoice_data,
      END OF ty_upload_invoice,

      BEGIN OF ty_delete_invoice,
        status        TYPE string,
        statusMessage TYPE string,
      END OF ty_delete_invoice.

    METHODS:
      constructor RAISING cx_web_message_error,

      is_connection RETURNING VALUE(ev_ok) TYPE abap_boolean,

      get_limit  IMPORTING
                           VALUE(iv_bankid)     TYPE string OPTIONAL
                           VALUE(iv_partycode)  TYPE string OPTIONAL
                           VALUE(iv_identifier) TYPE string OPTIONAL
                 RETURNING VALUE(rv_limit)      TYPE ty_limit,


      get_invoice
        IMPORTING VALUE(iv_startdate)         TYPE string
                  VALUE(iv_finishdate)        TYPE string
                  VALUE(iv_bankid)            TYPE string OPTIONAL
                  VALUE(iv_partycode)         TYPE string OPTIONAL
                  VALUE(iv_identifier)        TYPE string OPTIONAL
                  VALUE(iv_dbsinvoiceid)      TYPE string OPTIONAL
                  VALUE(iv_statuscode)        TYPE int4 OPTIONAL
                  VALUE(iv_statusdescription) TYPE string OPTIONAL
        RETURNING VALUE(rv_invoice)           TYPE ty_invoice,

      upload_invoice
        IMPORTING VALUE(iv_bankeftcode)    TYPE string
                  VALUE(iv_partycode)      TYPE string
                  VALUE(iv_identifier)     TYPE string
                  VALUE(iv_amount)         TYPE zarete_dbs_de_finteo_amount
                  VALUE(iv_invoicenumber)  TYPE string
                  VALUE(iv_invoiceduedate) TYPE string
                  VALUE(iv_currencycode)   TYPE string
        RETURNING VALUE(rv_upload_invoice) TYPE ty_upload_invoice,

      update_invoice
        IMPORTING VALUE(iv_bankeftcode)    TYPE string
                  VALUE(iv_partycode)      TYPE string
                  VALUE(iv_identifier)     TYPE string
                  VALUE(iv_amount)         TYPE zarete_dbs_de_finteo_amount
                  VALUE(iv_invoicenumber)  TYPE string
                  VALUE(iv_invoiceduedate) TYPE string
                  VALUE(iv_currencycode)   TYPE string
        RETURNING VALUE(rv_update_invoice) TYPE ty_upload_invoice,

      delete_invoice
        IMPORTING VALUE(iv_invoiceno)      TYPE string
        RETURNING VALUE(rv_delete_invoice) TYPE ty_delete_invoice.

    DATA:
      mo_http_destination TYPE REF TO if_http_destination,
      mv_client           TYPE REF TO if_web_http_client,
      gv_limiturl         TYPE string,
      gv_invoiceurl       TYPE string,
      gv_sendinvoiceurl   TYPE string,
      gv_token            TYPE string.

    METHODS:
      __get_request
        IMPORTING iv_url            TYPE string
        RETURNING VALUE(ro_request) TYPE REF TO if_web_http_request,
      __json2abap
        IMPORTING
          ir_input_data TYPE data
        CHANGING
          cr_abap_data  TYPE data,
      __execute
        IMPORTING
                  i_method           TYPE if_web_http_client=>method
        RETURNING VALUE(ro_response) TYPE REF TO if_web_http_response.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZARETE_DBS_SC_FINTEO_API IMPLEMENTATION.


  METHOD constructor.

    TYPES:
      BEGIN OF ty_token_json,
        access_token  TYPE string,
        token_type    TYPE string,
        id_token      TYPE string,
        refresh_token TYPE string,
        expires_in    TYPE i,
        scope         TYPE string,
        jti           TYPE string,
      END OF ty_token_json.

    TRY.
        DATA(lo_log) = zarete_dbs_cl_log=>get_factory( ).
        DATA lr_cscn TYPE if_com_scenario_factory=>ty_query-cscn_id_range. " communication scenario objects
        DATA(lo_factory) = cl_com_arrangement_factory=>create_instance( ).

        lr_cscn = VALUE #( ( sign = 'I' option = 'EQ' low = 'ZARETE_DBS_CS_FINTEO' ) ). "#EC *

        lo_factory->query_ca( EXPORTING is_query           = VALUE #( cscn_id_range = lr_cscn )
                              IMPORTING et_com_arrangement = DATA(lt_ca) ).

        READ TABLE lt_ca INTO DATA(lo_ca) INDEX 1.

        DATA(lt_properties) = lo_ca->get_properties( ).

        LOOP AT lt_properties INTO DATA(ls_property).
          CASE ls_property-name.
            WHEN 'INVOICE URL'.
              gv_invoiceurl = ls_property-values[ 1 ].
            WHEN 'SEND INVOICE URL'.
              gv_sendinvoiceurl = ls_property-values[ 1 ].
            WHEN 'LIMIT URL'.
              gv_limiturl = ls_property-values[ 1 ].
            WHEN 'USERNAME'.
              DATA(lv_username) = ls_property-values[ 1 ].
            WHEN 'PASSWORD'.
              DATA(lv_password) = ls_property-values[ 1 ].
          ENDCASE.
        ENDLOOP.

        mo_http_destination = cl_http_destination_provider=>create_by_comm_arrangement(
          comm_scenario  = 'ZARETE_DBS_CS_FINTEO'
          service_id     = 'ZARETE_DBS_FINTEO_API_REST'
          comm_system_id = lo_ca->get_comm_system_id( ) ).

        mv_client = cl_web_http_client_manager=>create_by_http_destination( mo_http_destination ).

        DATA(request) = mv_client->get_http_request( ).
        DATA(body) = |grant_type=password&username={ lv_username }&password={ lv_password }|. "#EC *

        request->set_header_fields( VALUE #( ( name  = 'Content-Type'
                                               value = 'application/x-www-form-urlencoded; charset=UTF-8' ) "#EC *
                                             ( name  = 'Accept' "#EC *
                                               value = 'application/json' ) "#EC *
                                             ( name  = 'Content-Length' "#EC *
                                               value = strlen( body ) ) ) ).

        request->append_text( body ).
        DATA(token_response) = mv_client->execute( if_web_http_client=>post ).
        DATA(token) = VALUE ty_token_json( ).
        " TODO: variable is assigned but never used (ABAP cleaner)
        DATA(response) = token_response->get_text( ).
        /ui2/cl_json=>deserialize( EXPORTING json = token_response->get_text( )
                                   CHANGING  data = token ).

        IF token-access_token IS INITIAL.
          RAISE EXCEPTION TYPE cx_web_message_error
                MESSAGE ID 'ZARETE_DBS_MC_001'
                TYPE 'E'
                NUMBER '001'.
        ENDIF.

        gv_token = |Bearer { token-access_token }|.         "#EC *

      CATCH cx_web_message_error INTO DATA(lt_webmessage_error).
        DATA(lv_error_msj) = lt_webmessage_error->get_longtext( ).

        lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                         msgno = lt_webmessage_error->if_t100_message~t100key-msgno
                         msgid = lt_webmessage_error->if_t100_message~t100key-msgid
                         msgv1 = lt_webmessage_error->if_t100_dyn_msg~msgv1
                         msgv2 = lt_webmessage_error->if_t100_dyn_msg~msgv2
                         msgv3 = lt_webmessage_error->if_t100_dyn_msg~msgv3
                         msgv4 = lt_webmessage_error->if_t100_dyn_msg~msgv4
                         msgtx = lv_error_msj ).

        RETURN.

      CATCH cx_web_http_client_error INTO DATA(lt_client_error).

        lv_error_msj = lt_client_error->get_longtext( ).
        lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                         msgno = lt_client_error->if_t100_message~t100key-msgno
                         msgid = lt_client_error->if_t100_message~t100key-msgid
                         msgv1 = lt_client_error->if_t100_dyn_msg~msgv1
                         msgv2 = lt_client_error->if_t100_dyn_msg~msgv2
                         msgv3 = lt_client_error->if_t100_dyn_msg~msgv3
                         msgv4 = lt_client_error->if_t100_dyn_msg~msgv4
                         msgtx = lv_error_msj ).

        RETURN.

      CATCH cx_http_dest_provider_error INTO DATA(lt_provider_error).

        lv_error_msj = lt_provider_error->get_longtext( ).
        lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                         msgno = lt_provider_error->if_t100_message~t100key-msgno
                         msgid = lt_provider_error->if_t100_message~t100key-msgid
                         msgv1 = lt_provider_error->if_t100_dyn_msg~msgv1
                         msgv2 = lt_provider_error->if_t100_dyn_msg~msgv2
                         msgv3 = lt_provider_error->if_t100_dyn_msg~msgv3
                         msgv4 = lt_provider_error->if_t100_dyn_msg~msgv4
                         msgtx = lv_error_msj ).

        RETURN.

    ENDTRY.

  ENDMETHOD.


  METHOD delete_invoice.

    DATA(lo_log) = zarete_dbs_cl_log=>get_factory( ).

    DATA(lv_sendinvoiceurl) = CONV string( gv_sendinvoiceurl && iv_invoiceno ).
    DATA(lo_request) = __get_request( lv_sendinvoiceurl ).

    TRY.
        DATA(lo_invoice) = __execute(
          i_method = if_web_http_client=>delete
        ).

        DATA(lv_json_response) = lo_invoice->get_text( ).

        /ui2/cl_json=>deserialize(
          EXPORTING
            json        = lv_json_response
            pretty_name = /ui2/cl_json=>pretty_mode-none
          CHANGING
            data        = rv_delete_invoice ).

    ENDTRY.

*    IF rv_delete_invoice IS INITIAL.
*      lo_log->add_log(
*                   msgno = '002'
*                   msgty = if_abap_behv_message=>severity-information
*                 ).
*    ELSE.
*      lo_log->add_log(
*              msgno = '004'
*              msgty = if_abap_behv_message=>severity-success
*            ).
*    ENDIF.

  ENDMETHOD.                                             "#EC CI_VALPAR


  METHOD get_invoice.

    DATA(lo_log) = zarete_dbs_cl_log=>get_factory( ).

    TYPES :
      BEGIN OF struct,
        startdate         TYPE    string,
        finishdate        TYPE    string,
        bankid            TYPE    string,
        partycode         TYPE    string,
        identifier        TYPE    string,
        dbsinvoiceid      TYPE    string,
        statuscode        TYPE    int4,
        statusdescription TYPE    string,
      END OF struct.

    DATA(lo_request) = __get_request( gv_invoiceurl ).

    DATA(ls_body) = VALUE struct( startdate = iv_startdate
                                  finishdate = iv_finishdate
                                  bankid = iv_bankid
                                  partycode = iv_partycode
                                  identifier = iv_identifier
                                  dbsinvoiceid = iv_dbsinvoiceid
                                  statuscode = iv_statuscode
                                  statusdescription = iv_statusdescription
                                       ).

    DATA(lv_json) = /ui2/cl_json=>serialize( data        = ls_body
                                             compress    = abap_true
                                             pretty_name = /ui2/cl_json=>pretty_mode-camel_case ).

    lo_request->append_text(
      EXPORTING
        data = lv_json
    ).

    TRY.
        DATA(lo_invoice) = __execute(
          i_method = if_web_http_client=>post
        ).

        DATA(lv_json_response) = lo_invoice->get_text( ).

        /ui2/cl_json=>deserialize(
          EXPORTING
            json        = lv_json_response
            pretty_name = /ui2/cl_json=>pretty_mode-none
          CHANGING
            data        = rv_invoice ).


    ENDTRY.

*    IF rv_invoice IS INITIAL.
*      lo_log->add_log(
*                   msgno = '002'
*                   msgty = if_abap_behv_message=>severity-information
*                 ).
*    ELSE.
*      lo_log->add_log(
*              msgno = '004'
*              msgty = if_abap_behv_message=>severity-success
*            ).
*    ENDIF.

  ENDMETHOD.                                             "#EC CI_VALPAR


  METHOD get_limit.

    DATA(lo_log) = zarete_dbs_cl_log=>get_factory( ).

    TYPES :
      BEGIN OF struct,
        partycode  TYPE    string,
        bankcode   TYPE    string,
        identifier TYPE    string,
      END OF struct.

    DATA(lo_request) = __get_request( gv_limiturl ).

    DATA(ls_body) = VALUE struct( bankcode   = iv_bankid
                                  identifier = iv_identifier
                                  partycode  = iv_partycode ).

    DATA(lv_json) = /ui2/cl_json=>serialize( data        = ls_body
                                             compress    = abap_true
                                             pretty_name = /ui2/cl_json=>pretty_mode-camel_case ).

    lo_request->append_text(
      EXPORTING
        data = lv_json
    ).

    TRY.
        DATA(lo_limit) = __execute(
          i_method = if_web_http_client=>post
        ).

        DATA(lv_json_response) = lo_limit->get_text( ).

        /ui2/cl_json=>deserialize(
          EXPORTING
            json        = lv_json_response
            pretty_name = /ui2/cl_json=>pretty_mode-none
          CHANGING
            data        = rv_limit ).


    ENDTRY.

*    IF rv_limit IS INITIAL.
*      lo_log->add_log(
*                   msgno = '002'
*                   msgty = if_abap_behv_message=>severity-information
*                 ).
*    ELSE.
*      lo_log->add_log(
*              msgno = '004'
*              msgty = if_abap_behv_message=>severity-success
*            ).
*    ENDIF.

  ENDMETHOD.                                             "#EC CI_VALPAR


  METHOD is_connection.

    IF gv_token IS NOT INITIAL.
      ev_ok = abap_true.
    ENDIF.

  ENDMETHOD.


  METHOD update_invoice.

    DATA(lo_log) = zarete_dbs_cl_log=>get_factory( ).

    TYPES :
      BEGIN OF struct,
        bankeftcode    TYPE    string,
        partycode      TYPE    string,
        identifier     TYPE    string,
        amount         TYPE    zarete_dbs_de_finteo_amount,
        invoicenumber  TYPE    string,
        invoiceduedate TYPE    string,
        currencycode   TYPE    string,
      END OF struct.

    DATA(lo_request) = __get_request( gv_sendinvoiceurl ).

    DATA(ls_body) = VALUE struct( bankeftcode = iv_bankeftcode
                                  partycode = iv_partycode
                                  identifier = iv_identifier
                                  amount = iv_amount
                                  invoicenumber = iv_invoicenumber
                                  invoiceduedate = iv_invoiceduedate
                                  currencycode = iv_currencycode
                                       ).

    DATA(lv_json) = /ui2/cl_json=>serialize( data        = ls_body
                                             compress    = abap_true
                                             pretty_name = /ui2/cl_json=>pretty_mode-camel_case ).

    lo_request->append_text(
      EXPORTING
        data = lv_json
    ).

    TRY.
        DATA(lo_invoice) = __execute(
          i_method = if_web_http_client=>patch
        ).

        DATA(lv_json_response) = lo_invoice->get_text( ).

        /ui2/cl_json=>deserialize(
          EXPORTING
            json        = lv_json_response
            pretty_name = /ui2/cl_json=>pretty_mode-none
          CHANGING
            data        = rv_update_invoice ).


    ENDTRY.

*    IF rv_update_invoice IS INITIAL.
*      lo_log->add_log(
*                   msgno = '002'
*                   msgty = if_abap_behv_message=>severity-information
*                 ).
*    ELSE.
*      lo_log->add_log(
*              msgno = '004'
*              msgty = if_abap_behv_message=>severity-success
*            ).
*    ENDIF.

  ENDMETHOD.                                             "#EC CI_VALPAR


  METHOD upload_invoice.

    DATA(lo_log) = zarete_dbs_cl_log=>get_factory( ).

    TYPES :
      BEGIN OF struct,
        bankeftcode    TYPE    string,
        partycode      TYPE    string,
        identifier     TYPE    string,
        amount         TYPE    zarete_dbs_de_finteo_amount,
        invoicenumber  TYPE    string,
        invoiceduedate TYPE    string,
        currencycode   TYPE    string,
      END OF struct.

    DATA(lo_request) = __get_request( gv_sendinvoiceurl ).

    DATA(lv_invoicenumber) = iv_invoicenumber.

    DATA(ls_body) = VALUE struct( bankeftcode = iv_bankeftcode
                                     partycode = iv_partycode
                                     identifier = iv_identifier
                                     amount = iv_amount
                                     invoicenumber = lv_invoicenumber
                                     invoiceduedate = iv_invoiceduedate
                                     currencycode = iv_currencycode
                                          ).

    DATA(lv_json) = /ui2/cl_json=>serialize( data        = ls_body
                                             compress    = abap_true
                                             pretty_name = /ui2/cl_json=>pretty_mode-camel_case ).

    lo_request->append_text(
      EXPORTING
        data = lv_json
    ).

    TRY.
        DATA(lo_invoice) = __execute(
          i_method = if_web_http_client=>put
        ).

        DATA(lv_json_response) = lo_invoice->get_text( ).

        /ui2/cl_json=>deserialize(
          EXPORTING
            json        = lv_json_response
            pretty_name = /ui2/cl_json=>pretty_mode-none
          CHANGING
            data        = rv_upload_invoice ).


    ENDTRY.

*    IF rv_upload_invoice IS INITIAL.
*      lo_log->add_log(
*                   msgno = '002'
*                   msgty = if_abap_behv_message=>severity-information
*                 ).
*    ELSE.
*      lo_log->add_log(
*              msgno = '004'
*              msgty = if_abap_behv_message=>severity-success
*            ).
*    ENDIF.

  ENDMETHOD.                                             "#EC CI_VALPAR


  METHOD __execute.

    DATA(lo_log) = zarete_dbs_cl_log=>get_factory( ).
    TRY.
        ro_response = mv_client->execute( i_method = i_method ).
        DATA(response_body) = ro_response->get_text( ).
        DATA(response_headers) = ro_response->get_header_fields( ).
      CATCH cx_web_message_error INTO DATA(lo_message_error).

        DATA(lv_error_msj) = lo_message_error->get_longtext( ).

        lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                         msgno = lo_message_error->if_t100_message~t100key-msgno
                         msgid = lo_message_error->if_t100_message~t100key-msgid
                         msgv1 = lo_message_error->if_t100_dyn_msg~msgv1
                         msgv2 = lo_message_error->if_t100_dyn_msg~msgv2
                         msgv3 = lo_message_error->if_t100_dyn_msg~msgv3
                         msgv4 = lo_message_error->if_t100_dyn_msg~msgv4
                         msgtx = lv_error_msj ).

        RETURN.

      CATCH cx_web_http_client_error INTO DATA(lo_http_error).

        lv_error_msj = lo_http_error->get_longtext( ).
        lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                         msgno = lo_http_error->if_t100_message~t100key-msgno
                         msgid = lo_http_error->if_t100_message~t100key-msgid
                         msgv1 = lo_http_error->if_t100_dyn_msg~msgv1
                         msgv2 = lo_http_error->if_t100_dyn_msg~msgv2
                         msgv3 = lo_http_error->if_t100_dyn_msg~msgv3
                         msgv4 = lo_http_error->if_t100_dyn_msg~msgv4
                         msgtx = lv_error_msj ).

        RETURN.

    ENDTRY.

  ENDMETHOD.


  METHOD __get_request.

    CLEAR: mv_client, mo_http_destination.
    DATA(lo_log) = zarete_dbs_cl_log=>get_factory( ).

    TRY.
        mo_http_destination = cl_http_destination_provider=>create_by_url( i_url = iv_url ).

        mv_client = cl_web_http_client_manager=>create_by_http_destination( mo_http_destination ).

        ro_request = mv_client->get_http_request( ).

        ro_request->set_header_field(
          i_name  = 'Authorization'                         "#EC *
          i_value = gv_token ).


        ro_request->set_header_fields( VALUE #(
          ( name = 'Accept' value = 'application/json, text/plain, */*'  )      ##NO_TEXT
          ( name = 'Content-Type' value = 'application/json;charset=utf-8'  )   ##NO_TEXT
        ) ).

      CATCH cx_http_dest_provider_error INTO DATA(lt_provider_error).

        DATA(lv_error_msj)  = lt_provider_error->get_longtext( ).
        lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                         msgno = lt_provider_error->if_t100_message~t100key-msgno
                         msgid = lt_provider_error->if_t100_message~t100key-msgid
                         msgv1 = lt_provider_error->if_t100_dyn_msg~msgv1
                         msgv2 = lt_provider_error->if_t100_dyn_msg~msgv2
                         msgv3 = lt_provider_error->if_t100_dyn_msg~msgv3
                         msgv4 = lt_provider_error->if_t100_dyn_msg~msgv4
                         msgtx = lv_error_msj ).

        RETURN.

      CATCH cx_web_http_client_error INTO DATA(lt_client_error).
        lv_error_msj = lt_client_error->get_longtext( ).
        lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                         msgno = lt_client_error->if_t100_message~t100key-msgno
                         msgid = lt_client_error->if_t100_message~t100key-msgid
                         msgv1 = lt_client_error->if_t100_dyn_msg~msgv1
                         msgv2 = lt_client_error->if_t100_dyn_msg~msgv2
                         msgv3 = lt_client_error->if_t100_dyn_msg~msgv3
                         msgv4 = lt_client_error->if_t100_dyn_msg~msgv4
                         msgtx = lv_error_msj ).

        RETURN.

    ENDTRY.

  ENDMETHOD.


  METHOD __json2abap.

    DATA(lo_input_struct)   = CAST cl_abap_structdescr( cl_abap_structdescr=>describe_by_data( p_data = ir_input_data ) ).
    DATA(lo_target_struct)  = CAST cl_abap_structdescr( cl_abap_structdescr=>describe_by_data( p_data = cr_abap_data ) ).

    LOOP AT lo_input_struct->components ASSIGNING FIELD-SYMBOL(<ls_component>).
      IF line_exists( lo_target_struct->components[ name = <ls_component>-name ] ).
        ASSIGN COMPONENT <ls_component>-name OF STRUCTURE ir_input_data TO FIELD-SYMBOL(<field_in_data>).
        ASSIGN COMPONENT <ls_component>-name OF STRUCTURE cr_abap_data TO FIELD-SYMBOL(<field_out_data>).

        IF lo_target_struct->components[ name = <ls_component>-name ]-type_kind = cl_abap_typedescr=>typekind_xstring.
          <field_out_data> = cl_web_http_utility=>decode_x_base64( <field_in_data>->* ).
        ELSE.
          <field_out_data> = <field_in_data>->*.
        ENDIF.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
