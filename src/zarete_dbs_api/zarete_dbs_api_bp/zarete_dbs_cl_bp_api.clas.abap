CLASS zarete_dbs_cl_bp_api DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
   INTERFACES if_rap_query_provider .


    TYPES: BEGIN OF ty_data .
             INCLUDE TYPE zarete_dbs_sc_bp_api=>tys_a_business_partner_type .
    TYPES:   to_business_partner_tax TYPE STANDARD TABLE OF zarete_dbs_sc_bp_api=>tys_a_business_partner_tax_n_2 WITH EMPTY KEY.

    TYPES END OF ty_data.


    DATA:
      gt_business_data TYPE TABLE OF ty_data,
      go_http_client   TYPE REF TO if_web_http_client,
      go_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
      go_request       TYPE REF TO /iwbep/if_cp_request_read_list,
      go_response      TYPE REF TO /iwbep/if_cp_response_read_lst,
      go_destination   TYPE REF TO if_http_destination.

    METHODS: constructor,

      get_taxnumber  IMPORTING
                    it_filter        TYPE if_rap_query_filter=>tt_name_range_pairs OPTIONAL
                  EXPORTING
                    et_business_data LIKE gt_business_data .

  PROTECTED SECTION.
  PRIVATE SECTION.



ENDCLASS.



CLASS ZARETE_DBS_CL_BP_API IMPLEMENTATION.


  METHOD constructor.
   DATA(lo_log) = zarete_dbs_cl_log=>get_factory( ).

    TRY.
        " Create http client
        DATA(go_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                                     comm_scenario  = 'ZARETE_DBS_CS_S4HANA'
                                                     service_id     = 'ZARETE_DBS_BP_REST' ).

        go_http_client = cl_web_http_client_manager=>create_by_http_destination( go_destination ).

        go_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
          EXPORTING
             is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                 proxy_model_id      = 'ZARETE_DBS_SC_BP_API'
                                                 proxy_model_version = '0001' )
            io_http_client             = go_http_client
            iv_relative_service_root   = '' ).

        ASSERT go_http_client IS BOUND.

*
        " Navigate to the resource and create a request for the read operation
        go_request = go_client_proxy->create_resource_for_entity_set( 'A_BUSINESS_PARTNER' )->create_request_for_read( ).
*

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


  METHOD get_taxnumber.
 DATA(lo_log) = zarete_dbs_cl_log=>get_factory( ).

    DATA lo_filter_factory      TYPE REF TO /iwbep/if_cp_filter_factory.
    DATA lo_filter_node         TYPE REF TO /iwbep/if_cp_filter_node.
    DATA lo_filter_node_root    TYPE REF TO /iwbep/if_cp_filter_node.
    DATA lo_expand_root         TYPE REF TO /iwbep/if_cp_expand_node.
    DATA lo_expand              TYPE REF TO /iwbep/if_cp_expand_node.

    DATA:lt_business_data TYPE TABLE OF ty_data.

    TRY.
        lo_expand_root = go_request->create_expand_node( ).
        lo_expand = lo_expand_root->add_expand( 'TO_BUSINESS_PARTNER_TAX' ).
      CATCH /iwbep/cx_gateway.
        CLEAR lo_expand_root.
    ENDTRY.
    " Execute the request and retrieve the business data
    TRY.

        IF it_filter IS NOT INITIAL.
          lo_filter_factory = go_request->create_filter_factory( ).
          LOOP AT it_filter INTO DATA(ls_range).
            lo_filter_node  = lo_filter_factory->create_by_range( iv_property_path     = ls_range-name
                                                                  it_range             = ls_range-range ).
            IF lo_filter_node_root IS INITIAL.
              lo_filter_node_root = lo_filter_node.
            ELSE.
              lo_filter_node_root = lo_filter_node_root->and( lo_filter_node ).
            ENDIF.
          ENDLOOP.
          go_request->set_filter( lo_filter_node_root ).
          " Create the filter tree

        ENDIF.

        go_response = go_request->execute( ).
        go_response->get_business_data( IMPORTING et_business_data = lt_business_data ).
        MOVE-CORRESPONDING lt_business_data TO et_business_data.
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


    ENDTRY.


  ENDMETHOD.


  METHOD if_rap_query_provider~select.

    DATA mc_request_aggregation TYPE REF TO if_rap_query_aggregation.
    DATA mc_request_filter      TYPE REF TO if_rap_query_filter.
    DATA mc_request_paging      TYPE REF TO if_rap_query_paging.
    DATA mv_request_page_size   TYPE i VALUE 100.
    DATA mv_request_offset      TYPE i.
    DATA mv_entity_cds          TYPE string.
    DATA mv_entity_name         TYPE string.
    DATA lo_filter_factory      TYPE REF TO /iwbep/if_cp_filter_factory.
    DATA lo_filter_node         TYPE REF TO /iwbep/if_cp_filter_node.
    DATA lo_filter_node_root    TYPE REF TO /iwbep/if_cp_filter_node.
    DATA lt_range               TYPE RANGE OF string.
    DATA ls_business_data       TYPE REF TO data.
    DATA lt_business_data       TYPE REF TO data.


    FIELD-SYMBOLS : <fs_business_data> TYPE any .
    FIELD-SYMBOLS : <ft_business_data> TYPE STANDARD TABLE.

    mv_entity_cds          = io_request->get_entity_id( ).
    mc_request_aggregation = io_request->get_aggregation(  ).
    mc_request_filter      = io_request->get_filter( ).
    mc_request_paging      = io_request->get_paging( ).
    mv_request_page_size   = mc_request_paging->get_page_size( ).
    mv_request_offset      = mc_request_paging->get_offset( ).
    DATA(mc_request_sort)  = io_request->get_sort_elements(  ).

    DATA(lo_log) = zarete_dbs_cl_log=>get_factory( ).

    CREATE DATA ls_business_data TYPE (mv_entity_cds).
    ASSIGN ls_business_data->* TO <fs_business_data>.

    CREATE DATA lt_business_data TYPE TABLE OF (mv_entity_cds).
    ASSIGN lt_business_data->* TO <ft_business_data>.

    TRY.
        DATA(filter_range) =  mc_request_filter->get_as_ranges(  ).

*        filter_range = VALUE #(
*    ( name = 'BUSINESS_PARTNER'
*      range = VALUE #(
*        ( sign = 'I' option = 'EQ' low = '10030' )
*      )
*    )
*    ( name = 'BPTAX_TYPE'
*      range = VALUE #(
*        ( sign = 'I' option = 'EQ' low = 'TR2' )
*      )
*    ) ) .

        go_request->set_top( mv_request_page_size )->set_skip( mv_request_offset ).
        get_taxnumber( EXPORTING
                      it_filter        = filter_range
                    IMPORTING
                      et_business_data = gt_business_data ).

        IF gt_business_data IS NOT INITIAL.

          LOOP AT gt_business_data INTO DATA(ls_data).

            LOOP AT ls_data-to_business_partner_tax INTO DATA(ls_tax) WHERE bptax_type = 'TR2' .
              MOVE-CORRESPONDING ls_tax TO <fs_business_data>.
            ENDLOOP.

            " bu müşteriler görünmesin !
            if ls_data-business_partner = '9000' or ls_data-business_partner = '9001' .
               CONTINUE.
            endif.


            MOVE-CORRESPONDING ls_data TO <fs_business_data>.
            APPEND <fs_business_data> TO <ft_business_data>.
            CLEAR: <fs_business_data>, ls_tax.
          ENDLOOP.

          io_response->set_data( it_data = <ft_business_data> ).
          io_response->set_total_number_of_records( iv_total_number_of_records = lines( <ft_business_data> ) ).

        ENDIF.

*
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
