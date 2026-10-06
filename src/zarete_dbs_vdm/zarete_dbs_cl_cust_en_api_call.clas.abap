CLASS zarete_dbs_cl_cust_en_api_call DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_rap_query_provider .
  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA mc_request_aggregation TYPE REF TO if_rap_query_aggregation.
    DATA mc_request_filter      TYPE REF TO if_rap_query_filter.
    DATA mc_request_paging      TYPE REF TO if_rap_query_paging.
    DATA mv_request_page_size   TYPE i VALUE 100.
    DATA mv_request_offset      TYPE i.
    DATA mv_entity_cds          TYPE string.
    DATA mv_entity_ext_url_path TYPE string.
    DATA mt_request_range       TYPE if_rap_query_filter=>tt_name_range_pairs.

    METHODS initialization
      IMPORTING io_request  TYPE REF TO if_rap_query_request
                io_response TYPE REF TO if_rap_query_response.

    METHODS get_dd_t027
      RETURNING VALUE(et_response) TYPE REF TO data.

    METHODS get_dd_t024
      RETURNING VALUE(et_response) TYPE REF TO data.

ENDCLASS.



CLASS ZARETE_DBS_CL_CUST_EN_API_CALL IMPLEMENTATION.


  METHOD if_rap_query_provider~select.

    initialization( io_request  = io_request
                    io_response = io_response ).

    CASE mv_entity_cds.
      WHEN 'ZARETE_DBS_DD_T027'.
        DATA(lt_response) = get_dd_t027( ).
      WHEN 'ZARETE_DBS_DD_T024'.
        lt_response = get_dd_t024( ).
    ENDCASE.

    IF lines( lt_response->* ) > 0.
      io_response->set_data( it_data = lt_response->* ).
      io_response->set_total_number_of_records( iv_total_number_of_records = lines( lt_response->* ) ).
    ELSE.
      io_response->set_total_number_of_records( 0 ).
      io_response->set_data( it_data = lt_response->* ).
    ENDIF.
  ENDMETHOD.


  METHOD get_dd_t027.
    DATA: ls_business_data TYPE REF TO data,
          lt_business_data TYPE REF TO data.

    FIELD-SYMBOLS : <fs_business_data> TYPE any .
    FIELD-SYMBOLS : <ft_business_data> TYPE STANDARD TABLE.

    CREATE  DATA ls_business_data TYPE (mv_entity_cds).
    ASSIGN ls_business_data->* TO <fs_business_data>.

    CREATE DATA et_response TYPE TABLE OF (mv_entity_cds).
    ASSIGN et_response->* TO <ft_business_data>.

    APPEND INITIAL LINE TO <ft_business_data> ASSIGNING FIELD-SYMBOL(<fs_data>).

    LOOP AT mt_request_range INTO DATA(ls_range) .

      ASSIGN COMPONENT ls_range-name OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_field>).

      <fs_field> = ls_range-range[ 1 ]-low.

    ENDLOOP.




  ENDMETHOD.


  METHOD get_dd_t024.

    TYPES: BEGIN OF ty_selected_invoices,
             dbs_invoice_id         TYPE zarete_dbs_dd_t016-DbsInvoiceId,
             invoice_number         TYPE zarete_dbs_dd_t015-InvoiceNumber,
             partial_invoice_number TYPE zarete_dbs_dd_t016-PartialInvoiceNumber,
             id                     TYPE zarete_dbs_dd_t015-Id,
             bank_code              TYPE zarete_dbs_dd_t012-CompanyBankCode,
             amount                 TYPE zarete_dbs_dd_t016-Amount,
             currency               TYPE zarete_dbs_dd_t016-CurrencyCode,
             customer               TYPE zarete_dbs_dd_t017-Customer,
             message                TYPE char72,
           END OF ty_selected_invoices.

    DATA: lt_invoices TYPE TABLE OF ty_selected_invoices.

    DATA: ls_business_data TYPE REF TO data,
          lt_business_data TYPE REF TO data.

    FIELD-SYMBOLS : <fs_business_data> TYPE any .
    FIELD-SYMBOLS : <ft_business_data> TYPE STANDARD TABLE.

    CREATE DATA ls_business_data TYPE (mv_entity_cds).
    ASSIGN ls_business_data->* TO <fs_business_data>.

    CREATE DATA et_response TYPE TABLE OF (mv_entity_cds).
    ASSIGN et_response->* TO <ft_business_data>.

    DATA(lo_buffer) = zarete_dbs_cl_tab_memory_ins=>get_instance( ).

    lo_buffer->get_table(
    IMPORTING
    ev_table = lt_invoices
    ev_table_name = DATA(lv_table_name) ) .

    IF lv_table_name EQ 'ZARETE_DBS_DD_T024'.

      LOOP AT lt_invoices INTO DATA(ls_invoice).

        <fs_business_data> = CORRESPONDING #( ls_invoice  ).

        LOOP AT mt_request_range INTO DATA(ls_range) .

          ASSIGN COMPONENT ls_range-name OF STRUCTURE <fs_business_data> TO FIELD-SYMBOL(<fs_field>).
          <fs_field> = ls_range-range[ 1 ]-low.

        ENDLOOP.


        APPEND <fs_business_data> TO <ft_business_data>.

      ENDLOOP.

    ENDIF.

  ENDMETHOD.


  METHOD initialization.

    IF mv_entity_cds IS INITIAL.
      mv_entity_cds = io_request->get_entity_id( ).
    ENDIF.


    TRY.
        IF io_request IS NOT INITIAL.

          mc_request_aggregation = io_request->get_aggregation(  ).
          mc_request_filter = io_request->get_filter( ).


          mt_request_range = mc_request_filter->get_as_ranges(  ).
          mc_request_paging = io_request->get_paging( ).
          mv_request_page_size = mc_request_paging->get_page_size( ).
          mv_request_offset = mc_request_paging->get_offset( ).

          DATA(lv_search) = io_request->get_search_expression(  ).

          DATA(lt_parameters) = io_request->get_parameters( ).
          DATA(lt_elements) = io_request->get_requested_elements( ).
          DATA(lv_search_expression) = io_request->get_search_expression( ).
          DATA(lt_sort) = io_request->get_sort_elements( ).

        ENDIF. ##NO_HANDLER

      CATCH cx_rap_query_filter_no_range INTO DATA(lx_query_filter).

        DATA(lv_error_message) = lx_query_filter->get_longtext(  ).

    ENDTRY.

*    IF  mv_request_page_size EQ '1-'. mv_request_page_size = 100. ENDIF.
*

  ENDMETHOD.
ENDCLASS.
