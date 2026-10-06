@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Finteodan Gelen Faturalar'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZARETE_DBS_DD_T016
  as select from zarete_dbs_t016
{
  key identifier                     as Identifier,
  key dbs_invoice_id                 as DbsInvoiceId,
      id                             as Id,
      amount                         as Amount,
      deleted_amount                 as DeletedAmount,
      currency_code                  as CurrencyCode,
      due_date                       as DueDate,
      send_date                      as SendDate,
      invoice_number                 as InvoiceNumber,
      partial_invoice_number         as PartialInvoiceNumber,
      invoice_amount_due             as InvoiceAmountDue,
      last_payment_date              as LastPaymentDate,
      partial_guaranteed_amount      as PartialGuaranteedAmount,
      amount_remaining_before_paymen as AmountRemainingBeforePaymen,
      payment_description            as PaymentDescription,
      status_code                    as StatusCode,
      status_description             as StatusDescription,
      transaction_date               as TransactionDate,
      dbs_account_id                 as DbsAccountId,
      party_code                     as PartyCode,
      party_title                    as PartyTitle,
      party_tax_number               as PartyTaxNumber,
      bank_code                      as BankCode,
      bank_name                      as BankName,
      @Semantics.user.createdBy: true
      created_by                     as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at                     as CreatedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at                as LastChangedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      local_last_changed_by          as LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at          as LocalLastChangedAt
}
