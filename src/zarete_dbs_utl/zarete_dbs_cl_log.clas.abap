CLASS zarete_dbs_cl_log DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zarete_dbs_if_log .

    ALIASES: sapinvoiceno FOR zarete_dbs_if_log~sapinvoiceno,
             id           FOR zarete_dbs_if_log~id,
             bankcode    FOR zarete_dbs_if_log~bankcode.

    CLASS-DATA mo_factory TYPE REF TO zarete_dbs_if_log.

    CLASS-METHODS : get_factory RETURNING VALUE(ro_log) TYPE REF TO zarete_dbs_if_log.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZARETE_DBS_CL_LOG IMPLEMENTATION.


  METHOD get_factory.
    IF mo_factory IS INITIAL.
      mo_factory = NEW zarete_dbs_cl_log(  ).
    ENDIF.
    ro_log = mo_factory.
  ENDMETHOD.


  METHOD zarete_dbs_if_log~add_log.

    DATA ls_t001 TYPE TABLE FOR CREATE zarete_dbs_dd_t001.

    DATA(lv_msgtx) = msgtx.

    IF lv_msgtx IS INITIAL.
      MESSAGE ID msgid TYPE msgty NUMBER msgno WITH msgv1 msgv2 msgv3 msgv4
              INTO lv_msgtx.
    ENDIF.

    ls_t001 = VALUE #( ( SapInvoiceNo          = me->sapinvoiceno
                         Id                    = me->id
                         BankCode              = me->bankcode
                         msgid                 = msgid
                         msgno                 = msgno
                         msgty                 = msgty
                         msgv1                 = msgv1
                         msgv2                 = msgv2
                         msgv3                 = msgv3
                         msgv4                 = msgv4
                         message               = lv_msgtx
                         %control-SapInvoiceNo = if_abap_behv=>mk-on
                         %control-Id           = if_abap_behv=>mk-on
                         %control-BankCode     = if_abap_behv=>mk-on
                         %control-msgid        = if_abap_behv=>mk-on
                         %control-msgno        = if_abap_behv=>mk-on
                         %control-msgty        = if_abap_behv=>mk-on
                         %control-msgv1        = if_abap_behv=>mk-on
                         %control-msgv2        = if_abap_behv=>mk-on
                         %control-msgv3        = if_abap_behv=>mk-on
                         %control-msgv4        = if_abap_behv=>mk-on
                         %control-message      = if_abap_behv=>mk-on ) ).

    MODIFY ENTITIES OF zarete_dbs_dd_t001
    ENTITY zarete_dbs_dd_t001
    CREATE AUTO FILL CID WITH ls_t001
    MAPPED DATA(lt_mapped)
    FAILED DATA(lt_failed)
    REPORTED DATA(lt_reported).

*    COMMIT ENTITIES RESPONSE OF zarete_dbs_dd_t001
*    FAILED DATA(lt_failed_t001_co)
*    REPORTED DATA(lt_reported_t001_co).

    IF  cl_abap_behv_aux=>get_current_handler_kind( ) IS INITIAL.
      COMMIT ENTITIES.
    ENDIF.

  ENDMETHOD.


  METHOD zarete_dbs_if_log~refresh.
    CLEAR: me->sapinvoiceno, me->id, me->bankcode.
  ENDMETHOD.


  METHOD zarete_dbs_if_log~set_sapinvoiceno.
    me->sapinvoiceno = iv_sapinvoiceno.
    me->id = iv_id.
    me->bankcode = iv_bankcode.
  ENDMETHOD.
ENDCLASS.
