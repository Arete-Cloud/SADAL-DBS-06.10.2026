CLASS zarete_dbs_cl_doc_read_api DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.


    INTERFACES if_rap_query_provider .


    DATA:
      gt_business_data TYPE TABLE OF zarete_dbs_sc_doc_read_api=>tys_a_operational_acctg_doc__2,
      go_http_client   TYPE REF TO if_web_http_client,
      go_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
      go_request       TYPE REF TO /iwbep/if_cp_request_read_list,
      go_response      TYPE REF TO /iwbep/if_cp_response_read_lst,
      go_destination   TYPE REF TO if_http_destination.

    METHODS: constructor,
      get_accounting_document
        IMPORTING it_filter        TYPE if_rap_query_filter=>tt_name_range_pairs OPTIONAL
        EXPORTING et_business_data TYPE ANY TABLE.

  PROTECTED SECTION.
  PRIVATE SECTION.


ENDCLASS.



CLASS ZARETE_DBS_CL_DOC_READ_API IMPLEMENTATION.


  METHOD constructor.
    DATA(lo_log) = zarete_dbs_cl_log=>get_factory( ).
    TRY.
        " Create http client
        DATA(go_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                                     comm_scenario  = 'ZARETE_DBS_CS_S4HANA'
                                                     service_id     = 'ZARETE_DBS_DOC_READ_REST' ).

        go_http_client = cl_web_http_client_manager=>create_by_http_destination( go_destination ).

        go_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
          EXPORTING
             is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                 proxy_model_id      = 'ZARETE_DBS_SC_DOC_READ_API'
                                                 proxy_model_version = '0001' )
            io_http_client             = go_http_client
            iv_relative_service_root   = '' ).

        ASSERT go_http_client IS BOUND.


        " Navigate to the resource and create a request for the read operation
        go_request = go_client_proxy->create_resource_for_entity_set( 'A_OPERATIONAL_ACCTG_DOC_IT' )->create_request_for_read( ).

      CATCH cx_http_dest_provider_error INTO DATA(lx_dest_provider_error).
        DATA(lv_error_msj) = lx_dest_provider_error->get_longtext(  ).
        lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                         msgno = lx_dest_provider_error->if_t100_message~t100key-msgno
                         msgid = lx_dest_provider_error->if_t100_message~t100key-msgid
                         msgv1 = lx_dest_provider_error->if_t100_dyn_msg~msgv1
                         msgv2 = lx_dest_provider_error->if_t100_dyn_msg~msgv2
                         msgv3 = lx_dest_provider_error->if_t100_dyn_msg~msgv3
                         msgv4 = lx_dest_provider_error->if_t100_dyn_msg~msgv4
                         msgtx = lv_error_msj ).

      CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).

        lv_error_msj = lx_web_http_client_error->get_longtext(  ).
        lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                         msgno = lx_web_http_client_error->if_t100_message~t100key-msgno
                         msgid = lx_web_http_client_error->if_t100_message~t100key-msgid
                         msgv1 = lx_web_http_client_error->if_t100_dyn_msg~msgv1
                         msgv2 = lx_web_http_client_error->if_t100_dyn_msg~msgv2
                         msgv3 = lx_web_http_client_error->if_t100_dyn_msg~msgv3
                         msgv4 = lx_web_http_client_error->if_t100_dyn_msg~msgv4
                         msgtx = lv_error_msj ).

      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway) .

        lv_error_msj = lx_gateway->get_longtext( ).
        lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                         msgno = lx_gateway->if_t100_message~t100key-msgno
                         msgid = lx_gateway->if_t100_message~t100key-msgid
                         msgv1 = CONV #( lx_gateway->if_t100_message~t100key-attr1 )
                         msgv2 = CONV #( lx_gateway->if_t100_message~t100key-attr2 )
                         msgv3 = CONV #( lx_gateway->if_t100_message~t100key-attr3 )
                         msgv4 = CONV #( lx_gateway->if_t100_message~t100key-attr4 )
                         msgtx = lv_error_msj ).
    ENDTRY.

  ENDMETHOD.


  METHOD get_accounting_document.

    DATA(lo_log) = zarete_dbs_cl_log=>get_factory( ).
    DATA: lt_data          TYPE TABLE OF zarete_dbs_dd_doc_read_001,
          ls_data          TYPE zarete_dbs_dd_doc_read_001,
          lt_business_data TYPE zarete_dbs_sc_doc_read_api=>tyt_a_operational_acctg_doc__2.


    DATA lo_filter_factory      TYPE REF TO /iwbep/if_cp_filter_factory.
    DATA lo_filter_node         TYPE REF TO /iwbep/if_cp_filter_node.
    DATA lo_filter_node_root    TYPE REF TO /iwbep/if_cp_filter_node.
    DATA lo_expand_root         TYPE REF TO /iwbep/if_cp_expand_node.
    DATA lo_expand              TYPE REF TO /iwbep/if_cp_expand_node.
    DATA lo_filter_node_1      TYPE REF TO /iwbep/if_cp_filter_node.
    DATA lt_range TYPE RANGE OF string.


    DATA:  filter_range TYPE if_rap_query_filter=>tt_name_range_pairs.

    TRY.

        filter_range = VALUE #( ( name = 'DEBIT_CREDIT_CODE'  range = VALUE #( ( sign = 'I' option = 'EQ' low = 'S'  ) ) )
                                ( name = 'CUSTOMER'           range = VALUE #( ( sign = 'E' option = 'EQ' low = ''  ) ) )
*                                ( name = 'IS_CLEARED'               range = VALUE #( ( sign = 'I' option = 'EQ' low = ' '  ) ) )
*                                ( name = 'IS_REVERSED'              range = VALUE #( ( sign = 'I' option = 'EQ' low = ' '  ) ) )
*                                ( name = 'ACCOUNTING_DOCUMENT_TYPE' range = VALUE #( ( sign = 'I' option = 'EQ' low = 'DZ' ) ) )
*                                ( name = 'LEDGER'                   range = VALUE #( ( sign = 'I' option = 'EQ' low = '0L' ) ) )
                               ).

        IF it_filter IS NOT INITIAL.
          APPEND LINES OF it_filter TO filter_range.
        ENDIF.

        IF filter_range IS NOT INITIAL.

          lo_filter_factory = go_request->create_filter_factory( ).
          LOOP AT filter_range INTO DATA(ls_range).
            lo_filter_node  = lo_filter_factory->create_by_range( iv_property_path     = ls_range-name
                                                                  it_range             = ls_range-range ).
            IF lo_filter_node_root IS INITIAL.
              lo_filter_node_root = lo_filter_node.
            ELSE.
              lo_filter_node_root = lo_filter_node_root->and( lo_filter_node ).
            ENDIF.
          ENDLOOP.

          " Create the filter tree
          go_request->set_filter( lo_filter_node_root ).

        ENDIF.


        go_response = go_request->execute( ).
        go_response->get_business_data( IMPORTING et_business_data = lt_business_data ).


        IF lt_business_data IS NOT INITIAL.

          LOOP AT lt_business_data INTO DATA(ls_business_data).

            MOVE-CORRESPONDING ls_business_data TO ls_data.
            APPEND ls_data TO lt_data.
          ENDLOOP.

        ENDIF.

        et_business_data = lt_data.

      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
        DATA(lv_error_msj) = lx_remote->get_longtext(  ).

        lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                         msgno = lx_remote->if_t100_message~t100key-msgno
                         msgid = lx_remote->if_t100_message~t100key-msgid
                         msgv1 = CONV #( lx_remote->if_t100_message~t100key-attr1 )
                         msgv2 = CONV #( lx_remote->if_t100_message~t100key-attr2 )
                         msgv3 = CONV #( lx_remote->if_t100_message~t100key-attr3 )
                         msgv4 = CONV #( lx_remote->if_t100_message~t100key-attr4 )
                         msgtx = lv_error_msj ).


      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway) .

        lv_error_msj = lx_gateway->get_longtext( ).
        lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                         msgno = lx_gateway->if_t100_message~t100key-msgno
                         msgid = lx_gateway->if_t100_message~t100key-msgid
                         msgv1 = CONV #( lx_gateway->if_t100_message~t100key-attr1 )
                         msgv2 = CONV #( lx_gateway->if_t100_message~t100key-attr2 )
                         msgv3 = CONV #( lx_gateway->if_t100_message~t100key-attr3 )
                         msgv4 = CONV #( lx_gateway->if_t100_message~t100key-attr4 )
                         msgtx = lv_error_msj ).
    ENDTRY.
  ENDMETHOD.


  METHOD if_rap_query_provider~select.

    DATA mc_request_aggregation TYPE REF TO if_rap_query_aggregation.
    DATA mc_request_filter      TYPE REF TO if_rap_query_filter.
    DATA mc_request_paging      TYPE REF TO if_rap_query_paging.
    DATA mv_request_page_size   TYPE i VALUE 100.
    DATA mv_request_offset      TYPE i.
    DATA mv_entity_cds          TYPE string.
    DATA mv_entity_name         TYPE c LENGTH 40.

    DATA: lcl_table TYPE REF TO cl_abap_tabledescr,
          lcl_struc TYPE REF TO cl_abap_structdescr,
          it_fields TYPE abap_compdescr_tab,
          ls_fields TYPE abap_compdescr.


    IF mv_entity_cds IS INITIAL.
      mv_entity_cds = io_request->get_entity_id( ).
    ENDIF.

    DATA: lt_data TYPE REF TO data.

    FIELD-SYMBOLS : <fs_data> TYPE STANDARD TABLE .

    DATA: lt_accounting TYPE TABLE OF zarete_dbs_dd_doc_read_001.

    CREATE DATA lt_data TYPE TABLE OF (mv_entity_cds).
    ASSIGN lt_data->* TO <fs_data>.

    mc_request_aggregation = io_request->get_aggregation(  ).
    mc_request_filter      = io_request->get_filter( ).
    DATA(mc_request_sort) = io_request->get_sort_elements(  ).
    mc_request_paging      = io_request->get_paging( ).
    mv_request_page_size   = mc_request_paging->get_page_size( ).
    mv_request_offset      = mc_request_paging->get_offset( ).
    DATA(mc_request_searching) = io_request->get_search_expression(  ).

    DATA:
      lo_filter_factory   TYPE REF TO /iwbep/if_cp_filter_factory,
      lo_filter_node      TYPE REF TO /iwbep/if_cp_filter_node,
      lo_filter_node_root TYPE REF TO /iwbep/if_cp_filter_node,
      lt_range            TYPE RANGE OF string.

    DATA(lo_log) = zarete_dbs_cl_log=>get_factory( ).


    TRY.
        DATA(filter_range) =  mc_request_filter->get_as_ranges(  ).
        " Create http client

        IF filter_range IS NOT INITIAL.
          lo_filter_factory = go_request->create_filter_factory( ).
          LOOP AT filter_range INTO DATA(ls_range).
            lo_filter_node  = lo_filter_factory->create_by_range( iv_property_path     = ls_range-name
                                                                  it_range             = ls_range-range ).
            IF lo_filter_node_root IS INITIAL.
              lo_filter_node_root = lo_filter_node.
            ELSE.
              lo_filter_node_root = lo_filter_node_root->and( lo_filter_node ).
            ENDIF.
          ENDLOOP.
          " Create the filter tree

          go_request->set_filter( lo_filter_node_root ).

        ENDIF.

        go_request->set_top( mv_request_page_size )->set_skip( mv_request_offset ).
        get_accounting_document( EXPORTING it_filter = filter_range
                                 IMPORTING et_business_data = lt_accounting ).

        MOVE-CORRESPONDING lt_accounting TO <fs_data>.

        lcl_table ?= cl_abap_typedescr=>describe_by_data( <fs_data> ).
        lcl_struc ?= lcl_table->get_table_line_type( ).
        it_fields = lcl_struc->components.

        READ TABLE it_fields INTO ls_fields INDEX 1.
        SORT <fs_data> ASCENDING BY (ls_fields-name).
        DELETE ADJACENT DUPLICATES FROM <fs_data>.

        IF <fs_data> IS ASSIGNED AND <fs_data> IS NOT INITIAL.
          io_response->set_data( it_data = <fs_data> ).
          io_response->set_total_number_of_records( iv_total_number_of_records = lines( <fs_data> ) ).

        ENDIF.
        IF lt_data IS INITIAL.
*              RAISE EXCEPTION TYPE cx_web_message_error
*                    MESSAGE ID 'ZARETE_EHO_MC_001'
*                    TYPE 'E'
*                    NUMBER '007'.
        ENDIF.

      CATCH cx_rap_query_filter_no_range INTO DATA(lx_filter).
        DATA(lv_error_msj) = lx_filter->get_longtext(  ).
        lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                         msgno = lx_filter->if_t100_message~t100key-msgno
                         msgid = lx_filter->if_t100_message~t100key-msgid
                         msgv1 = lx_filter->if_t100_dyn_msg~msgv1
                         msgv2 = lx_filter->if_t100_dyn_msg~msgv2
                         msgv3 = lx_filter->if_t100_dyn_msg~msgv3
                         msgv4 = lx_filter->if_t100_dyn_msg~msgv4
                         msgtx = lv_error_msj ).

        "handle exception
      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
        lv_error_msj = lx_remote->get_longtext(  ).

        lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                         msgno = lx_remote->if_t100_message~t100key-msgno
                         msgid = lx_remote->if_t100_message~t100key-msgid
                         msgv1 = CONV #( lx_remote->if_t100_message~t100key-attr1 )
                         msgv2 = CONV #( lx_remote->if_t100_message~t100key-attr2 )
                         msgv3 = CONV #( lx_remote->if_t100_message~t100key-attr3 )
                         msgv4 = CONV #( lx_remote->if_t100_message~t100key-attr4 )
                         msgtx = lv_error_msj ).

      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).

        lv_error_msj = lx_gateway->get_longtext( ).
        lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                         msgno = lx_gateway->if_t100_message~t100key-msgno
                         msgid = lx_gateway->if_t100_message~t100key-msgid
                         msgv1 = CONV #( lx_gateway->if_t100_message~t100key-attr1 )
                         msgv2 = CONV #( lx_gateway->if_t100_message~t100key-attr2 )
                         msgv3 = CONV #( lx_gateway->if_t100_message~t100key-attr3 )
                         msgv4 = CONV #( lx_gateway->if_t100_message~t100key-attr4 )
                         msgtx = lv_error_msj ).

      CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).

        lv_error_msj = lx_web_http_client_error->get_longtext( ).
        lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                         msgno = lx_web_http_client_error->if_t100_message~t100key-msgno
                         msgid = lx_web_http_client_error->if_t100_message~t100key-msgid
                         msgv1 = lx_web_http_client_error->if_t100_dyn_msg~msgv1
                         msgv2 = lx_web_http_client_error->if_t100_dyn_msg~msgv2
                         msgv3 = lx_web_http_client_error->if_t100_dyn_msg~msgv3
                         msgv4 = lx_web_http_client_error->if_t100_dyn_msg~msgv4
                         msgtx = lv_error_msj ).

        RAISE SHORTDUMP lx_web_http_client_error.

    ENDTRY.

  ENDMETHOD.
ENDCLASS.
