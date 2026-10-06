CLASS zarete_dbs_cl_finteo_lmt DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_rap_query_provider .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZARETE_DBS_CL_FINTEO_LMT IMPLEMENTATION.


  METHOD if_rap_query_provider~select.

    DATA(lo_util) = NEW zarete_dbs_cl_utility( ).
    DATA(lo_log) = zarete_dbs_cl_log=>get_factory( ).

    DATA: lt_limit               TYPE zarete_dbs_sc_finteo_api=>ty_limit,
          mc_request_aggregation TYPE REF TO if_rap_query_aggregation,
          mc_request_filter      TYPE REF TO if_rap_query_filter,
          mc_request_paging      TYPE REF TO if_rap_query_paging,
          mv_request_page_size   TYPE i VALUE 100,
          mv_request_offset      TYPE i,
          mv_entity_cds          TYPE string,
          mv_entity_name         TYPE string,
          lo_filter_factory      TYPE REF TO /iwbep/if_cp_filter_factory,
          lo_filter_node         TYPE REF TO /iwbep/if_cp_filter_node,
          lo_filter_node_root    TYPE REF TO /iwbep/if_cp_filter_node,
          lt_range               TYPE RANGE OF string,
          ls_business_data       TYPE REF TO data,
          lt_business_data       TYPE REF TO data.

    FIELD-SYMBOLS : <fs_business_data> TYPE any .
    FIELD-SYMBOLS : <ft_business_data> TYPE STANDARD TABLE.

    mv_entity_cds          = io_request->get_entity_id( ).
    mc_request_aggregation = io_request->get_aggregation(  ).
    mc_request_filter      = io_request->get_filter( ).
    mc_request_paging      = io_request->get_paging( ).
    mv_request_page_size   = mc_request_paging->get_page_size( ).
    mv_request_offset      = mc_request_paging->get_offset( ).
    DATA(mc_request_sort)  = io_request->get_sort_elements(  ).

    CREATE DATA ls_business_data TYPE (mv_entity_cds).
    ASSIGN ls_business_data->* TO <fs_business_data>.

    CREATE DATA lt_business_data TYPE TABLE OF (mv_entity_cds).
    ASSIGN lt_business_data->* TO <ft_business_data>.


    CASE mv_entity_cds.
      WHEN 'ZARETE_DBS_DD_FINTEO_LMT_001'.
        io_request->is_total_numb_of_rec_requested(
          RECEIVING
            rv_is_requested = DATA(lv_numb) ).

        IF lv_numb = abap_true.

          lo_util->get_limit_data( IMPORTING et_limit = lt_limit ).

        ENDIF.

    ENDCASE.

    IF lt_limit-data IS NOT INITIAL.

      LOOP AT lt_limit-data INTO DATA(ls_data) WHERE isactive EQ abap_true.

        MOVE-CORRESPONDING ls_data TO <fs_business_data>.

        ASSIGN COMPONENT 'partyCode' OF STRUCTURE <fs_business_data> TO FIELD-SYMBOL(<fs_partycode>).
        IF sy-subrc EQ 0.

          ASSIGN COMPONENT 'BPNO' OF STRUCTURE <fs_business_data> TO FIELD-SYMBOL(<fs_pb>).

          " Gelmemesi gereken şubeler!
          <fs_pb> = <fs_partycode>.

          DATA(lv_bpno) = CONV kunnr( COND #( WHEN <fs_pb> IS ASSIGNED AND strlen( <fs_pb> ) < 10
                                               THEN |{ <fs_partycode> ALPHA = IN }| ) ).

          IF strlen( lv_bpno ) GE 4 AND ( lv_bpno+0(4) = '3000' OR lv_bpno+0(4) = '3999' ).
            CONTINUE.
          ENDIF.

          IF strlen( lv_bpno ) GE 6 AND ( lv_bpno+0(6) = '450009' OR lv_bpno+0(6) = '450396' ).
            CONTINUE.
          ENDIF.

          SELECT SINGLE BusinessPartner , BusinessPartnerFullName
            FROM I_BusinessPartner
             WITH PRIVILEGED ACCESS
           WHERE BusinessPartner = @lv_bpno
            INTO @DATA(ls_bp).
          IF sy-subrc EQ 0.
            ASSIGN COMPONENT 'partyTitle' OF STRUCTURE <fs_business_data> TO FIELD-SYMBOL(<fs_partytitle>).
            IF sy-subrc EQ 0.
              <fs_partytitle> = ls_bp-BusinessPartnerFullName.
            ENDIF.
          ELSE.
            CONTINUE.
          ENDIF.
        ENDIF.

        ASSIGN COMPONENT 'SHOWLOG' OF STRUCTURE <fs_business_data> TO FIELD-SYMBOL(<fs_showlog>).
        IF sy-subrc EQ 0.
          <fs_showlog> = 'sap-icon://history'.
        ENDIF.

        APPEND <fs_business_data> TO <ft_business_data>.

        CLEAR <fs_business_data>.

      ENDLOOP.

      TRY.

          DATA(filter_range) =  mc_request_filter->get_as_ranges(  ).

          LOOP AT filter_range ASSIGNING FIELD-SYMBOL(<fs_filter>).
            LOOP AT <ft_business_data> ASSIGNING FIELD-SYMBOL(<fs_limit>).
              ASSIGN COMPONENT <fs_filter>-name OF STRUCTURE <fs_limit> TO FIELD-SYMBOL(<fs_value>).
              IF sy-subrc EQ 0.
                IF <fs_value> NOT IN <fs_filter>-range.
                  DELETE <ft_business_data>.
                ENDIF.
              ENDIF.
            ENDLOOP.
          ENDLOOP.

        CATCH cx_rap_query_filter_no_range INTO DATA(lx_filter).
          DATA(lv_error_msj) = lx_filter->get_longtext(  ).
      ENDTRY.

*      DATA(lt_sort_elements) = mc_request_sort->get_sort_elements( ).

      IF mc_request_sort IS NOT INITIAL.

        DATA(lt_sort_criteria) = VALUE abap_sortorder_tab( ).

        LOOP AT mc_request_sort INTO DATA(ls_sort_element).
          lt_sort_criteria = VALUE #( BASE lt_sort_criteria
            ( name       = ls_sort_element-element_name
              descending = ls_sort_element-descending ) ).
        ENDLOOP.

        SORT <ft_business_data> BY (lt_sort_criteria).

      ENDIF.

    ENDIF.

    DATA: lt_paged_data TYPE TABLE OF zarete_dbs_dd_finteo_lmt_001.
    IF io_request->is_total_numb_of_rec_requested( ).
      io_response->set_total_number_of_records( lines( <ft_business_data> ) ).
    ENDIF.

    IF io_request->is_data_requested( ).
      DATA(lv_start) = mv_request_offset + 1.
      DATA(lv_end)   = mv_request_offset + mv_request_page_size.

      IF mv_request_page_size = if_rap_query_paging=>page_size_unlimited OR mv_request_page_size = 0.
        lt_paged_data = <ft_business_data>.
      ELSE.

        TRY.
            APPEND LINES OF <ft_business_data> FROM lv_start TO lv_end TO lt_paged_data.
          CATCH cx_sy_itab_line_not_found.
            DATA(lv_max) = lines( <ft_business_data> ).
            IF lv_start <= lv_max.
              APPEND LINES OF <ft_business_data> FROM lv_start TO lv_max TO lt_paged_data.
            ENDIF.
        ENDTRY.
      ENDIF.

      io_response->set_data( lt_paged_data ).

    ENDIF.

  ENDMETHOD.
ENDCLASS.
