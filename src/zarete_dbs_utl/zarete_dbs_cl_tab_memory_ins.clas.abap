CLASS zarete_dbs_cl_tab_memory_ins DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.


    CLASS-METHODS get_instance
      RETURNING VALUE(ro_instance) TYPE REF TO zarete_dbs_cl_tab_memory_ins.

    METHODS set_table
      IMPORTING
        iv_table_name TYPE string
        iv_table      TYPE any.

    METHODS get_table

      EXPORTING ev_table      TYPE any
                ev_table_name TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-DATA: go_instance TYPE REF TO zarete_dbs_cl_tab_memory_ins.
    DATA:
      gs_table      TYPE REF TO data,
      gs_table_name TYPE string.
ENDCLASS.



CLASS ZARETE_DBS_CL_TAB_MEMORY_INS IMPLEMENTATION.


  METHOD get_instance.
    IF go_instance IS NOT BOUND.
      go_instance = NEW #( ).
    ENDIF.
    ro_instance = go_instance.
  ENDMETHOD.


  METHOD get_table.
    IF gs_table IS BOUND.
      ev_table = gs_table->*.
      ev_table_name = gs_table_name.
    ENDIF.

  ENDMETHOD.


  METHOD set_table.
    CREATE DATA gs_table LIKE iv_table.
    gs_table->* = iv_table.

    gs_table_name = iv_table_name.

  ENDMETHOD.
ENDCLASS.
