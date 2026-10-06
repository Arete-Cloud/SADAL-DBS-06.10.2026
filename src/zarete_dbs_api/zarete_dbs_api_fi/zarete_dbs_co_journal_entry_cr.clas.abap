class ZARETE_DBS_CO_JOURNAL_ENTRY_CR definition
  public
  inheriting from CL_PROXY_CLIENT
  create public .

public section.

  methods CONSTRUCTOR
    importing
      !DESTINATION type ref to IF_PROXY_DESTINATION optional
      !LOGICAL_PORT_NAME type PRX_LOGICAL_PORT_NAME optional
    preferred parameter LOGICAL_PORT_NAME
    raising
      CX_AI_SYSTEM_FAULT .
  methods JOURNAL_ENTRY_CREATE_REQUEST_C
    importing
      !INPUT type ZARETE_DBS_JOURNAL_ENTRY_BULK
    exporting
      !OUTPUT type ZARETE_DBS_JOURNAL_ENTRY_BULK1
    raising
      CX_AI_SYSTEM_FAULT .
protected section.
private section.
ENDCLASS.



CLASS ZARETE_DBS_CO_JOURNAL_ENTRY_CR IMPLEMENTATION.


  method CONSTRUCTOR.

  super->constructor(
    class_name          = 'ZARETE_DBS_CO_JOURNAL_ENTRY_CR'
    logical_port_name   = logical_port_name
    destination         = destination
  ).

  endmethod.


  method JOURNAL_ENTRY_CREATE_REQUEST_C.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'JOURNAL_ENTRY_CREATE_REQUEST_C'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.
ENDCLASS.
