CLASS zarete_dbs_cl_fatura_job DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA : g_log   TYPE REF TO if_bali_log.
    INTERFACES if_apj_dt_exec_object .
    INTERFACES if_apj_rt_exec_object .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zarete_dbs_cl_fatura_job IMPLEMENTATION.


  METHOD if_apj_dt_exec_object~get_parameters.

    et_parameter_def = VALUE
    #( ( selname = 'P_ESKI'
         kind = if_apj_dt_exec_object=>parameter
         datatype = 'C'
         length = 1
         param_text = 'Eski Kayıtları Sorgula'
         checkbox_ind = abap_true
         changeable_ind = abap_true )
     ).

    et_parameter_val = VALUE
    #(
       ( selname = 'P_ESKI'
         kind = if_apj_dt_exec_object=>parameter
         sign = 'I' option = 'EQ'
         low = abap_false )
     ).

  ENDMETHOD.

  METHOD if_apj_rt_exec_object~execute.

    DATA: p_eski TYPE abap_bool.

    LOOP AT it_parameters INTO DATA(ls_param).
      CASE ls_param-selname.
        WHEN 'P_ESKI'.
          p_eski = ls_param-low.
      ENDCASE.
    ENDLOOP.

    DATA(lo_util) = NEW zarete_dbs_cl_utility( ).

    TRY.
        g_log = cl_bali_log=>create_with_header(
                  cl_bali_header_setter=>create( object    = 'ZARETE_DBS_BELGE_OBJ'
                                                 subobject = 'DBSBLGSUBOBJ' ) ).
      CATCH cx_bali_runtime INTO DATA(lc_cx_bali) ##NO_HANDLER.
        "handle exception
    ENDTRY.

    lo_util->set_log( g_log ).

    DATA(lv_system_date) = CONV datum( cl_abap_context_info=>get_system_date( ) ).

    DATA(lv_next_week) = CONV datum( lv_system_date + 90 ).
    DATA(lv_last_week) = CONV datum( lv_system_date - 14 ).

    IF p_eski IS INITIAL.
      DATA(lv_start) =  lv_last_week+0(4) && '-' &&
                        lv_last_week+4(2) && '-' &&
                        lv_last_week+6(2).

      DATA(lv_finish) = lv_next_week+0(4) && '-' &&
                        lv_next_week+4(2) && '-' &&
                        lv_next_week+6(2).
    ELSE.
      lv_start  = '2026-07-01'.
      lv_finish = lv_next_week+0(4) && '-' &&
                  lv_next_week+4(2) && '-' &&
                  lv_next_week+6(2).
    ENDIF.

    lo_util->get_invoices(
      iv_startdate  = lv_start
      iv_finishdate = lv_finish
    ).

*    lo_util->get_documents_for_clearing( ).

    TRY.
        cl_bali_log_db=>get_instance( )->save_log( log = g_log assign_to_current_appl_job = abap_true ).
      CATCH cx_bali_runtime ##NO_HANDLER .
        "handle exception
    ENDTRY.



  ENDMETHOD.
ENDCLASS.
