@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Limit Bilgileri'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZARETE_DBS_DD_T013
  as select from zarete_dbs_t013
{
  key identifier             as Identifier,
  key limitid                as Limitid,
      partycode              as Partycode,
      partytaxnumber         as Partytaxnumber,
      partytitle             as Partytitle,
      limit                  as Limit,
      activelimit            as Activelimit,
      usedlimit              as UsedLimit,
      pendinginvoicecount    as Pendinginvoicecount,
      pendinginvoiceamount   as Pendinginvoiceamount,
      bankcode               as Bankcode,
      bankname               as Bankname,
      currencycode           as Currencycode,
      isactive               as IsActive,
      guarantedinvoiceamount as GuarantedInvoiceAmount,
      fundedexposure         as FundedExposure,
      linkediban             as LinkedIban,
      bank_priority          as BankPriority,
      created_by             as CreatedBy,
      created_at             as CreatedAt,
      last_changed_at        as LastChangedAt,
      local_last_changed_by  as LocalLastChangedBy,
      local_last_changed_at  as LocalLastChangedAt
}
