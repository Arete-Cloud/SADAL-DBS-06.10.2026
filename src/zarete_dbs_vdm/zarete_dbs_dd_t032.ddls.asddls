@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Limit Geçmişi Log Bilgileri'
//@Metadata.ignorePropagatedAnnotations: true
define root view entity ZARETE_DBS_DD_T032
  as select from    zarete_dbs_t021 as _Main
    left outer join I_Customer      as _Customer on _Customer.Customer = lpad(
      _Main.partycode, 10, '0'
    )
{

  key _Main.log_id                                 as LogId,
      _Main.identifier                             as Identifier,
      _Main.limitid                                as LimitId,
      _Main.partycode                              as PartyCode,
      _Main.partytaxnumber                         as PartyTaxNumber,

      case
        when _Main.partytitle is not initial then _Main.partytitle
        else _Customer.CustomerName
      end                                          as PartyTitle,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      _Main.limit                                  as Limit,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      _Main.activelimit                            as ActiveLimit,
      _Main.pendinginvoicecount                    as PendingInvoiceCount,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      _Main.pendinginvoiceamount                   as PendingInvoiceAmount,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      _Main.guarantedinvoiceamount                 as GuarantedInvoiceAmount,
      _Main.fundedexposure                         as FundedExposure,
      _Main.bankcode                               as BankCode,
      _Main.bankname                               as BankName,
      cast( _Main.currencycode as abap.cuky( 5 ) ) as CurrencyCode,
      @Semantics.user.createdBy: true
      _Main.created_by                             as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      _Main.created_at                             as CreatedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      _Main.last_changed_at                        as LastChangedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      _Main.local_last_changed_by                  as LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      _Main.local_last_changed_at                  as LocalLastChangedAt

}
