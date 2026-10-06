@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Log Bilgileri PV'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZARETE_DBS_PV_T001
  provider contract transactional_query
  as projection on ZARETE_DBS_DD_T001
{
  key LogId,
      SapInvoiceNo,
      BankCode,
      Id,
      Msgid,
      Msgno,
      Msgty,
      Msgv1,
      Msgv2,
      Msgv3,
      Msgv4,
      Message,
      CreatedBy,
      CreatedAt,
      LastChangedAt,
      LocalLastChangedBy,
      LocalLastChangedAt
}
