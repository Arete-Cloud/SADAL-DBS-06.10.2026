@EndUserText.label: 'DBS Fatura Gönderimi Custom CDS'
@ObjectModel.query.implementedBy: 'ABAP:ZARETE_DBS_CL_CUST_EN_API_CALL'
define custom entity ZARETE_DBS_DD_T024
{

  key request_time           : timestamp;
  key dbs_invoice_id         : zarete_dbs_de_dbsinvid;
  key invoice_number         : abap.char(20);
  key id                     : abap.numc(7);
  key action_code            : abap.char(1);
      bank_code              : abap.char(4);
      partial_invoice_number : abap.char(24);
      amount                 : abap.dec(9,2);
      currency_code          : abap.char(4);
      customer               : abap.char(10);
      message                : abap.char(100);
      @ObjectModel.sort.enabled: false
      @ObjectModel.filter.enabled: false
      _header                : association to parent ZARETE_DBS_DD_T027 on  $projection.request_time = _header.request_time
                                                                        and $projection.action_code  = _header.action_code;


}

