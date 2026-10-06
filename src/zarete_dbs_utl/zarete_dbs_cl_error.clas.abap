CLASS zarete_dbs_cl_error DEFINITION

  PUBLIC
  INHERITING FROM cx_rap_query_provider
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_t100_message.

    METHODS constructor
      IMPORTING
        !msgid    TYPE symsgid
        !msgno    TYPE symsgno
        !previous TYPE REF TO cx_root OPTIONAL
        !iv_msg   TYPE string OPTIONAL.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS ZARETE_DBS_CL_ERROR IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor(
      textid = VALUE scx_t100key( msgid = msgid msgno = msgno attr1 = iv_msg )
      previous = previous
    ).

  ENDMETHOD.
ENDCLASS.
