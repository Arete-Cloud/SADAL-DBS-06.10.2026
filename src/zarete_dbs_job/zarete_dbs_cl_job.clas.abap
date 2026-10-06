CLASS zarete_dbs_cl_job DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_apj_rt_exec_object.
    INTERFACES if_apj_dt_exec_object.

    INTERFACES if_oo_adt_classrun .

    DATA : g_log   TYPE REF TO if_bali_log.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zarete_dbs_cl_job IMPLEMENTATION.


  METHOD if_apj_rt_exec_object~execute.

    DATA: lt_limit TYPE zarete_dbs_sc_finteo_api=>ty_limit.
    DATA(lo_util) = NEW zarete_dbs_cl_utility( ).

    TRY.
        g_log = cl_bali_log=>create_with_header( cl_bali_header_setter=>create( object = 'ZARETE_DBS_OBJ' subobject = 'DBSSUBOBJ' ) ).
      CATCH cx_bali_runtime INTO DATA(lc_cx_bali) ##NO_HANDLER .

        "handle exception
    ENDTRY.

    lo_util->set_log( g_log ).

    lo_util->get_limit_data( IMPORTING et_limit = lt_limit ).

    TRY.
        cl_bali_log_db=>get_instance( )->save_log( log = g_log assign_to_current_appl_job = abap_true ).
      CATCH cx_bali_runtime ##NO_HANDLER .
        "handle exception
    ENDTRY.

*Fatura ID

    SELECT *
    FROM zarete_dbs_t015
    WHERE invoice_acc_doc IS NOT INITIAL
    INTO TABLE @DATA(lt_t015).
    IF sy-subrc EQ 0.

      SELECT *                                     "#EC CI_NO_TRANSFORM
      FROM zarete_dbs_t016
      FOR ALL ENTRIES IN @lt_t015
      WHERE dbs_invoice_id EQ @lt_t015-dbs_invoice_id
      AND id IS INITIAL
      INTO TABLE @DATA(lt_t016).              "#EC CI_ALL_FIELDS_NEEDED

    ENDIF.

    LOOP AT lt_t016 ASSIGNING FIELD-SYMBOL(<fs_t016>).

      READ TABLE lt_t015 ASSIGNING FIELD-SYMBOL(<fs_t015>) WITH KEY dbs_invoice_id = <fs_t016>-dbs_invoice_id.
      IF sy-subrc EQ 0.

        <fs_t016>-id = <fs_t015>-id.
        MODIFY zarete_dbs_t016 FROM @<fs_t016>.
        COMMIT WORK AND WAIT.

      ENDIF.

    ENDLOOP.

*

  ENDMETHOD.


  METHOD if_apj_dt_exec_object~get_parameters.

  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.


  ENDMETHOD.

ENDCLASS.
