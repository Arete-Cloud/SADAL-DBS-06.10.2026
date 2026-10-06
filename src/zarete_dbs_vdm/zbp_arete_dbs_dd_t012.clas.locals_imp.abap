CLASS lhc_t012 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR t012 RESULT result.

    METHODS precheck_update FOR PRECHECK
      IMPORTING entities FOR UPDATE t012 .

ENDCLASS.

CLASS lhc_t012 IMPLEMENTATION.

  METHOD get_global_authorizations.

    result-%delete = if_abap_behv=>auth-allowed.
    result-%update = if_abap_behv=>auth-allowed.

  ENDMETHOD.

  METHOD precheck_update.

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<fs_entities>).

      IF <fs_entities>-BpTaxNumber NE <fs_entities>-PartyTaxNumber.
        APPEND VALUE #(  %tky = <fs_entities>-%tky ) TO failed-t012.
        APPEND VALUE #(  %tky =  <fs_entities>-%tky
                         %msg = new_message_with_text(
                            severity = if_abap_behv_message=>severity-error
                            text = 'VKN eşleşmiyor. Kontrol ediniz.'
                          )  ) TO reported-t012.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
