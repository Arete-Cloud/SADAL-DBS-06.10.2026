@EndUserText.label: 'DBS Results'
define abstract entity ZARETE_DBS_DD_T023
{
  key invoice_number : abap.char(16);
      dbs_invoice_id : abap.char(50);
      status         : abap.char(10);
      status_message : abap.char(16);
      _t022          : association to parent zarete_dbs_dd_t022;
}
