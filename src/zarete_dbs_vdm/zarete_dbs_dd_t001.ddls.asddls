@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Log Bilgileri'

define root view entity ZARETE_DBS_DD_T001
  as select from zarete_dbs_t001
{
  key log_id                as LogId,
      sapinvoiceno          as SapInvoiceNo,
      bankcode              as BankCode,
      id                    as Id,
      msgid                 as Msgid,
      msgno                 as Msgno,
      msgty                 as Msgty,
      msgv1                 as Msgv1,
      msgv2                 as Msgv2,
      msgv3                 as Msgv3,
      msgv4                 as Msgv4,
      message               as Message,
      @Semantics.user.createdBy: true
      created_by            as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at            as CreatedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      local_last_changed_by as LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt
}
