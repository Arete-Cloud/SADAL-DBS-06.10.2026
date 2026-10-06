@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DBS Limit Ekranı Custom View'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZARETE_DBS_DD_CV001
  as select from ZARETE_DBS_DD_T012 as Customer
    inner join   zarete_dbs_t013    as Limit on  Limit.identifier     = Customer.Identifier
                                             and Limit.partytaxnumber = Customer.PartyTaxNumber
{
  key     Customer.PartyTaxNumber         as PartyTaxNumber,
  key     Limit.bankname                  as Bankname,
          Limit.partytitle                as PartyTitle,
          Limit.limit                     as Limit,
          Limit.activelimit               as Activelimit,
          Limit.limit - Limit.activelimit as Kullanilanlimit,
          Limit.pendinginvoiceamount      as Pendinginvoiceamount
}
