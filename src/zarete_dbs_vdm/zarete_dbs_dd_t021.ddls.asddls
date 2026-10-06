@EndUserText.label: 'DBS''den Alınacak Veriler Item'
define abstract entity ZARETE_DBS_DD_T021

{
  key invoice_number         : abap.char(16);
  key id                     : abap.numc(7);
      bank_code              : abap.char(4);
      partial_invoice_number : abap.char(16);
      amount                 : abap.dec(9,2);
      currency_code          : abap.char(4);
      customer               : abap.char(10);
      _t020                  : association to parent ZARETE_DBS_DD_T020;
}
