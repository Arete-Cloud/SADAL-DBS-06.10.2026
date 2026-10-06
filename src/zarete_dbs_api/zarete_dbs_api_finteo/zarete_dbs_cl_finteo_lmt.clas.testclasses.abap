CLASS ltcl_ DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      first_test FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_ IMPLEMENTATION.

  METHOD first_test.

    READ ENTITIES OF zarete_dbs_dd_finteo_lmt_001
     ENTITY zarete_dbs_dd_finteo_lmt_001
     ALL FIELDS WITH VALUE #( (  ) )
     RESULT DATA(lt_limits)
     FAILED DATA(ls_failed)
     REPORTED DATA(ls_reported).


  ENDMETHOD.

ENDCLASS.
