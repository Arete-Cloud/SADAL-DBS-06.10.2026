@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DBS Fatura Ekranı Custom View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZARETE_DBS_DD_INVOICE_002
  as select distinct from    zarete_dbs_t015    as Invoices
    left outer join zarete_dbs_t017    as SAP         on SAP.document_reference_id = Invoices.invoice_number
    left outer join zarete_dbs_t016    as Finteo      on  Finteo.invoice_number = Invoices.invoice_number
                                                      and Finteo.amount         is not initial
  //                                                    and Finteo.id             = Invoices.id
    left outer join ZARETE_DBS_DD_T030 as FinteoAgg   on FinteoAgg.invoice_number = Invoices.invoice_number
    left outer join zarete_dbs_t002    as Status      on  Status.finteo_status_code        = Finteo.status_code
                                                      and Status.finteo_status_description = Finteo.status_description
    left outer join zarete_dbs_t003    as Action      on Action.sap_status_code = Status.sap_status_code
    left outer join zarete_dbs_t012    as Bank        on Bank.bp_no = SAP.customer
    left outer join zarete_dbs_t013    as Limit       on  Limit.identifier = Bank.company_identifier
                                                      and Limit.limitid    = Bank.limit_id
                                                      and Limit.isactive   = 'X'
    left outer join ZARETE_DBS_DD_T036 as ClearingAgg on ClearingAgg.invoice_number = Invoices.invoice_number
{
  key    Invoices.id                                        as Id,
  key    Invoices.invoice_number                            as InvoiceNumber,
  key    Finteo.dbs_invoice_id                              as DbsInvoiceId,
  key    Finteo.partial_invoice_number                      as PartialInvoiceNumber,
         Invoices.accounting_document                       as AccountingDocument,
         Invoices.clearing_document                         as ClearingDocument,
         SAP.customer                                       as Customer,
         SAP.customer_name                                  as CustomerName,
         SAP.document_date                                  as DocumentDate,
         SAP.posting_date                                   as PostingDate,
         SAP.net_due_date                                   as DueDate,

         @Semantics.amount.currencyCode: 'Currency'
         SAP.amount_in_transaction_curr                     as Amount,

         @UI.hidden: true
         cast( SAP.transaction_currency as abap.cuky( 5 ) ) as Currency,

         @Semantics.amount.currencyCode: 'Currency'
         FinteoAgg.total_amount                             as TotalAmount,

         @Semantics.amount.currencyCode: 'Currency'
         Finteo.amount                                      as SendAmount,

         ClearingAgg.used_amount                            as UsedAmountForClearing,

         @Semantics.amount.currencyCode: 'Currency'
         case
           when $projection.Amount - coalesce( $projection.TotalAmount, 0 ) - coalesce( $projection.UsedAmountForClearing, 0 ) > 0
             then $projection.Amount - coalesce( $projection.TotalAmount, 0 ) - coalesce( $projection.UsedAmountForClearing, 0 )
           else 0
         end                                                as RemainingAmount,

         SAP.document_item_text                             as DocumentText,
         case
         when Finteo.bank_code is not initial then Finteo.bank_code
         else Bank.company_bank_code
         end                                                as HouseBank,
         Finteo.status_code                                 as FinteoStatusCode,
         Finteo.status_description                          as FinteoStatusDescription,
         Status.finteo_status_code_text                     as FinteoStatusCodeText,
         Status.finteo_status_desc_text                     as FinteoStatusDescText,
         Limit.guarantedinvoiceamount                       as GuarantedInvoiceAmount,

         case
           when Invoices.is_cancelled is initial and ( Finteo.status_code is null or Finteo.status_code = '' ) then cast( '1' as abap.sstring(4) )
           when ( Invoices.accounting_document is null or Invoices.accounting_document = '' )  and    Invoices.acc_error = 'X' then cast( '8' as abap.sstring(4) )
           when Invoices.accounting_document is not initial then cast( '7' as abap.sstring(4) )
           when ( Invoices.is_cancelled = 'X'  or Finteo.status_code = '9' ) then cast( '10' as abap.sstring(4) )
           else Status.sap_status_code
         end                                                as SapStatusCode,

         case
           when Invoices.is_cancelled is initial and ( Finteo.status_code is null or Finteo.status_code = '' ) then 'Belge Gönderime Hazır'
           when ( Invoices.accounting_document is null or Invoices.accounting_document = '' )
           and    Invoices.acc_error = 'X' then 'SAP Belgesi Oluşturulamadı'
           when Invoices.accounting_document is not initial then 'SAP Belgesi Oluşturuldu'
           when ( Invoices.is_cancelled = 'X' or Finteo.status_code = '9' ) then 'Fatura Geri Çekildi'
           else Status.sap_status_code_text
         end                                                as SapStatusCodeText,

         case
           when $projection.SapStatusCode = cast( '1' as abap.sstring(4) )  then 'sap-icon://accounting-document-verification'
           when $projection.SapStatusCode = cast( '7' as abap.sstring(4) )  then 'sap-icon://accounting-document-verification'
           when $projection.SapStatusCode = cast( '8' as abap.sstring(4) )  then 'sap-icon://decline'
           when $projection.SapStatusCode = cast( '10' as abap.sstring(4) ) then 'sap-icon://fallback'
           else Status.status_icon
         end                                                as StatusIcon,
         case
         when $projection.SapStatusCode = cast( '1' as abap.sstring(4) )  then 'S'
         when $projection.SapStatusCode = cast( '7' as abap.sstring(4) )  then 'W'
         when $projection.SapStatusCode = cast( '8' as abap.sstring(4) )  then 'A'
         when $projection.SapStatusCode = cast( '10' as abap.sstring(4) ) then 'S'
         else Action.action_code
         end                                                as ActionCode,


         case
           when $projection.SapStatusCode = cast( '1' as abap.sstring(4) )  then 'Gönder'
           when $projection.SapStatusCode = cast( '7' as abap.sstring(4) )  then 'Aksiyon Yok'
           when $projection.SapStatusCode = cast( '8' as abap.sstring(4) )  then 'Muhasebeleştir'
           when $projection.SapStatusCode = cast( '10' as abap.sstring(4) ) then 'Gönder'
           else Action.action_definition
         end                                                as ActionDefinition,

         case
         when $projection.InvoiceNumber is not initial then 'sap-icon://history'
         else 'sap-icon://history'
         end                                                as ShowLog,

         case
         when $projection.InvoiceNumber is not initial then 'sap-icon://accounting-document-verification'
         else 'sap-icon://accounting-document-verification'
         end                                                as Clearing
}
