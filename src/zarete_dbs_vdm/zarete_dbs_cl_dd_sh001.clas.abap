CLASS zarete_dbs_cl_dd_sh001 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

      INTERFACES if_rap_query_provider .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZARETE_DBS_CL_DD_SH001 IMPLEMENTATION.


  METHOD if_rap_query_provider~select.


    DATA: r_descr TYPE REF TO cl_abap_structdescr,
          gt_comp TYPE abap_component_tab.

    DATA lt_data TYPE TABLE OF zarete_dbs_dd_sh001.
    DATA(mc_request_aggregation) = io_request->get_aggregation(  ).
    DATA(mc_request_filter)      = io_request->get_filter( ).
    try.
        data(filter_range)           =  mc_request_filter->get_as_ranges(  ).

      catch cx_rap_query_filter_no_range ##NO_HANDLER.
        "handle exception

    endtry.
    DATA(mc_request_sort)        = io_request->get_sort_elements(  ).
    DATA(mc_request_paging)      = io_request->get_paging( ).
    DATA(mv_request_page_size)   = mc_request_paging->get_page_size( ).
    DATA(mv_request_offset)      = mc_request_paging->get_offset( ).
    DATA: ls_journal_entry TYPE zarete_dbs_journal_entry_cre18.

    r_descr ?= cl_abap_typedescr=>describe_by_data( ls_journal_entry ).
    gt_comp = r_descr->get_components( ).

    MOVE-CORRESPONDING gt_comp TO lt_data.

    io_response->set_data( it_data = lt_data ).
    io_response->set_total_number_of_records( iv_total_number_of_records = lines( lt_data ) ).


  ENDMETHOD.
ENDCLASS.
