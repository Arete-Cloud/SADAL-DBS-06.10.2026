@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DBS Fatura Ekranı Custom View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZARETE_DBS_DD_INVOICE_001
  as select from    zarete_dbs_t015           as Invoices
    left outer join zarete_dbs_t017           as SAP              on  SAP.document_reference_id      = Invoices.invoice_number
                                                                  and (
                                                                     SAP.accounting_document_type    = 'DR'
                                                                     or SAP.accounting_document_type = 'RV'
                                                                     or SAP.accounting_document_type = 'KT'
                                                                   )
                                                                  and SAP.accounting_document        = Invoices.invoice_acc_doc
                                                                  and SAP.accounting_document_item   = Invoices.invoice_acc_doc_item

    left outer join zarete_dbs_t016           as Finteo           on Finteo.invoice_number = Invoices.invoice_number
  //                                                           and Finteo.amount         > 0
    left outer join ZARETE_DBS_DD_T030        as FinteoAgg        on FinteoAgg.invoice_number = Invoices.invoice_number
    left outer join zarete_dbs_t002           as Status           on  Status.finteo_status_code        = Finteo.status_code
                                                                  and Status.finteo_status_description = Finteo.status_description
    left outer join zarete_dbs_t003           as Action           on Action.sap_status_code = Status.sap_status_code
    left outer join zarete_dbs_t012           as Bank             on  Bank.bp_no             = SAP.customer
                                                                  and Bank.company_bank_code = Finteo.bank_code
    left outer join zarete_dbs_t013           as Limit            on  Limit.identifier = Bank.company_identifier
                                                                  and Limit.limitid    = Bank.limit_id
                                                                  and Limit.isactive   = 'X'
    left outer join ZARETE_DBS_DD_T040        as ClearingMessage  on  ClearingMessage.invoice_number       = Invoices.invoice_number
                                                                  and ClearingMessage.id                   = Invoices.id
                                                                  and ClearingMessage.invoice_acc_doc      = Invoices.invoice_acc_doc
                                                                  and ClearingMessage.invoice_acc_doc_item = Invoices.invoice_acc_doc_item
    left outer join ZARETE_DBS_DD_T048        as ClearingDistinct on  ClearingDistinct.AccountingDocument     = Invoices.invoice_acc_doc
                                                                  and ClearingDistinct.AccountingDocumentItem = Invoices.invoice_acc_doc_item
                                                                  and ClearingDistinct.InvoiceNumber          = Invoices.invoice_number
    left outer join ZARETE_DBS_DD_T053        as AccDoc           on  AccDoc.id                     = Invoices.id
                                                                  and AccDoc.invoice_number         = Invoices.invoice_number
                                                                  and AccDoc.partial_invoice_number = Finteo.partial_invoice_number
    left outer join ZARETE_DBS_DD_T051        as Payment          on  Payment.Customer   = lpad(
      SAP.customer, 10, '0'
    )
                                                                  and Payment.Currency   = SAP.transaction_currency
                                                                  and Payment.FiscalYear = SAP.fiscal_year
    left outer join I_JournalEntry            as JE               on JE.AccountingDocument = lpad(
      Invoices.invoice_acc_doc, 10, '0'
    )
    left outer join I_OperationalAcctgDocItem as OpAcc            on  OpAcc.AccountingDocument = lpad(
      Invoices.invoice_acc_doc, 10, '0'
    )
                                                                  and OpAcc.Customer           is not initial
{
  key    Invoices.id                                                                                   as Id,
  key    Invoices.invoice_number                                                                       as InvoiceNumber,
  key    Finteo.dbs_invoice_id                                                                         as DbsInvoiceId,
  key    Finteo.partial_invoice_number                                                                 as PartialInvoiceNumber,

         AccDoc.AccountingDocument                                                                     as AccountingDocument,
         //         AccountingDistinct.AccountingDocument                                                         as AccountingDocument,
         ClearingDistinct.ClearingDocument                                                             as ClearingDocument,

         case
         when SAP.customer is not initial then SAP.customer
         else Finteo.party_code
         end                                                                                           as Customer,

         case
         when SAP.customer_name is not initial then SAP.customer_name
         else Finteo.party_title
         end                                                                                           as CustomerName,
         
         SAP.fiscal_year                                                                               as FiscalYear,
         SAP.document_date                                                                             as DocumentDate,
         SAP.posting_date                                                                              as PostingDate,
         
         case
         when OpAcc.NetDueDate is not initial then OpAcc.NetDueDate
         when Invoices.due_date is not initial then Invoices.due_date
         when SAP.net_due_date is not initial then SAP.net_due_date
         else Finteo.due_date
         end                                                                                           as DueDate,

         case
         when Finteo.send_date is not initial then Finteo.send_date
         else cast( substring( cast( Finteo.created_at as abap.char(30) ), 1, 8 ) as abap.dats )
         end                                                                                           as SendDate,

         cast( concat( substring( cast( Finteo.last_payment_date as abap.char(30) ), 1, 4 ),
               concat( substring( cast( Finteo.last_payment_date as abap.char(30) ), 6, 2 ),
               substring( cast( Finteo.last_payment_date as abap.char(30) ), 9, 2 ) ) ) as abap.dats ) as LastPaymentDate,

         SAP.accounting_document_type                                                                  as DocType,
         SAP.accounting_document                                                                       as InvoiceAccountingDocument,
         SAP.accounting_document_item                                                                  as InvoiceAccountingDocumentItem,

         //         @Semantics.amount.currencyCode: 'Currency'
         case
         when SAP.amount_in_transaction_curr > 0 then SAP.amount_in_transaction_curr
         else Finteo.amount end                                                                        as Amount,

         cast( SAP.transaction_currency as abap.cuky( 5 ) )                                            as Currency,

         //         @Semantics.amount.currencyCode: 'Currency'
         FinteoAgg.total_amount                                                                        as AggAmount, //VL10C İçin
         case
         when Finteo.amount > 0 then Finteo.amount
         else Finteo.deleted_amount
         end                                                                                           as TotalAmount,

         //         @Semantics.amount.currencyCode: 'Currency'
         Finteo.amount                                                                                 as SendAmount,

         //         @Semantics.amount.currencyCode: 'Currency'
         cast( ClearingDistinct.UsedAmountForClearing as abap.dec( 15, 2 ) )                           as UsedAmountForClearing,

         //         @Semantics.amount.currencyCode: 'Currency'
         case
           when $projection.Amount - coalesce( $projection.AggAmount, 0 ) - coalesce( $projection.UsedAmountForClearing, 0 ) > 0
             then $projection.Amount - coalesce( $projection.AggAmount, 0 ) - coalesce( $projection.UsedAmountForClearing, 0 )
           else 0
         end                                                                                           as RemainingAmount,

         case
         when Payment.Odeme > 0 then 'X'
         else ''
         end                                                                                           as Odeme,

         SAP.document_item_text                                                                        as DocumentText,
         case
         when Finteo.bank_code is not initial then Finteo.bank_code
         else Bank.company_bank_code
         end                                                                                           as HouseBank,

         Finteo.status_code                                                                            as FinteoStatusCode,
         Finteo.status_description                                                                     as FinteoStatusDescription,
         Status.finteo_status_code_text                                                                as FinteoStatusCodeText,

         case
         when Status.finteo_status_desc_text  is not initial then Status.finteo_status_desc_text
         else Finteo.status_description
         end                                                                                           as FinteoStatusDescText,

         Limit.fundedexposure                                                                          as FundedExposure,

         case
         //Başarıyla Muhasebeleştirildi ve Denkleştirildi
           when $projection.AccountingDocument is not initial and $projection.ClearingDocument is not initial then cast( '7' as abap.sstring(4) )
         //Başarıyla Muhasebeleştirildi Ancak Denkleştirilemedi
           when $projection.AccountingDocument is not initial and $projection.ClearingDocument is initial then cast( '7' as abap.sstring(4) )
         //Kısmi Denkleştirme Yapıldıysa
           when $projection.ClearingDocument is not initial and $projection.RemainingAmount != 0 then cast( '13' as abap.sstring(4) )
         //Tam Denkleştirme
           when $projection.ClearingDocument is not initial and $projection.RemainingAmount = 0 and Finteo.status_code  = '9' then cast( '10' as abap.sstring(4) )
           when $projection.ClearingDocument is not initial and $projection.RemainingAmount = 0 and Finteo.status_code != '6' then cast( '11' as abap.sstring(4) )
           when $projection.ClearingDocument is not initial and $projection.RemainingAmount = 0 and Finteo.status_code  = '6' then cast( '4' as abap.sstring(4) )
           when $projection.ClearingDocument is not initial and $projection.RemainingAmount = 0 and ( Finteo.status_code is null or Finteo.status_code = '' ) then cast( '11' as abap.sstring(4) )
         //Belge Gönderilmeyecek
           when Invoices.is_cancelled is initial and ( Status.sap_status_code = 'D' ) then cast( 'D' as abap.sstring(4) )
         //İlk Kez Gönderilecek Belge
           when Invoices.is_cancelled is initial and ( Finteo.status_code is null or Finteo.status_code = '' ) then cast( '1' as abap.sstring(4) )
         //Muhasebeleştirmede Hata Alındı
           when ( Invoices.accounting_document is null or Invoices.accounting_document = '' )
           and    Invoices.acc_error = 'X' then cast( '8' as abap.sstring(4) )
         //Başarıyla Muhasebeleştirildi
           when $projection.AccountingDocument is not initial then cast( '7' as abap.sstring(4) )
         //Belge Geri Çekildi ya da İptal Döndü
           when Finteo.status_code = '9' then cast( '10' as abap.sstring(4) )
           when Status.sap_status_code is not initial then cast( Status.sap_status_code as abap.sstring(4) )
           else cast( Finteo.status_code as abap.sstring(4) )
         end                                                                                           as SapStatusCode,

         case
         //Başarıyla Muhasebeleştirildi ve Denkleştirildi
           when $projection.AccountingDocument is not initial and $projection.ClearingDocument is not initial then cast( 'SAP Belgesi Oluşturuldu ve Denkleştirildi' as abap.char(100) )
         //Başarıyla Muhasebeleştirildi Ancak Denkleştirilemedi
           when $projection.AccountingDocument is not initial and $projection.ClearingDocument is initial then cast( 'SAP Belgesi Oluşturuldu, Denkleştirmede Hata' as abap.char(100) )
           when $projection.AccountingDocument is not initial or $projection.AccountingDocument is not null
           or $projection.AccountingDocument != '' then cast( 'SAP Belgesi Oluşturuldu' as abap.char(100) )
         //Kısmi Denkleştirme Yapıldıysa
           when $projection.ClearingDocument is not initial and $projection.RemainingAmount != 0 and Finteo.status_code is not initial then cast( Finteo.status_description as abap.char(100) )
           when $projection.ClearingDocument is not initial and $projection.RemainingAmount != 0  and ( Finteo.status_code is null or Finteo.status_code = '' ) then cast( 'Kalan Denkleştirme Bekleniyor' as abap.char(100) )
         //Tam Denkleştirme Yapıldıysa
           when $projection.RemainingAmount = 0 and $projection.ClearingDocument is not initial and Finteo.status_code is not initial then cast( Finteo.status_description as abap.char(100) )
           when $projection.RemainingAmount = 0 and $projection.ClearingDocument is not initial and ( Finteo.status_code is null or Finteo.status_code = '' ) then cast( 'Denkleştirildi' as abap.char(100) )
         //Denkleştirme Bekleniyor
           when ClearingMessage.status = 'B' then cast( ClearingMessage.message as abap.char(100) )
         //Denkleştirmede hata Alındı
           when ClearingMessage.status = 'E' then cast( ClearingMessage.message as abap.char(100) )
         //Belge Gönderilmeyecek
           when Invoices.is_cancelled is initial and ( Status.sap_status_code = 'D' ) then cast( 'Belge Gönderilmeyecek' as abap.char(100) )
         //İlk Kez Gönderilecek Belge
           when Invoices.is_cancelled is initial and ( Finteo.status_code is null or Finteo.status_code = '' ) then cast( 'Belge Gönderime Hazır' as abap.char(100) )
         //Muhasebeleştirmede Hata Alındı
           when ( Invoices.accounting_document is null or Invoices.accounting_document = '' )
           and    Invoices.acc_error = 'X' then cast( 'SAP Belgesi Oluşturulamadı' as abap.char(100) )
         //Belge Geri Çekildi ya da İptal Döndü
           when  Finteo.status_code = '9' then cast( 'Fatura Geri Çekildi' as abap.char(100) )
           when Status.sap_status_code_text is not initial then cast( Status.sap_status_code_text as abap.char(100) )
         else cast( Finteo.status_description as abap.char(100) )
         end                                                                                           as SapStatusCodeText,

         case
           when $projection.SapStatusCode = cast( '1' as abap.sstring(4) )  then 'sap-icon://accounting-document-verification'
           when $projection.SapStatusCode = cast( '7' as abap.sstring(4) )  then 'sap-icon://accounting-document-verification'
           when $projection.SapStatusCode = cast( '8' as abap.sstring(4) )  then 'sap-icon://decline'
           when $projection.SapStatusCode = cast( '10' as abap.sstring(4) ) then 'sap-icon://fallback'
           when $projection.SapStatusCode = cast( '11' as abap.sstring(4) ) then 'sap-icon://accounting-document-verification'
           when $projection.SapStatusCode = cast( '13' as abap.sstring(4) ) then 'sap-icon://accounting-document-verification'
           when $projection.SapStatusCode = cast( 'E'  as abap.sstring(4) ) then 'sap-icon://decline'
           when $projection.SapStatusCode = cast( 'B'  as abap.sstring(4) ) then 'sap-icon://accounting-document-verification'
           when $projection.SapStatusCode = cast( 'S'  as abap.sstring(4) ) then 'sap-icon://accounting-document-verification'
           when $projection.SapStatusCode = cast( 'D'  as abap.sstring(4) ) then 'sap-icon://accounting-document-verification'
           else Status.status_icon
         end                                                                                           as StatusIcon,

         case
           when $projection.InvoiceAccountingDocument is null and Finteo.status_code = '6' and $projection.AccountingDocument is not null then 'C'
           when $projection.SapStatusCode = cast( '1' as abap.sstring(4) )  then 'S'
           when ( $projection.SapStatusCode = cast( '7' as abap.sstring(4) ) and $projection.RemainingAmount = 0 )  then 'W'
           when ( $projection.SapStatusCode = cast( '7' as abap.sstring(4) ) and $projection.RemainingAmount > 0 )  then 'S'
           when ( $projection.SapStatusCode = cast( '4' as abap.sstring(4) ) and $projection.RemainingAmount > 0 )  then 'A'
           when $projection.SapStatusCode = cast( '8' as abap.sstring(4) )  then 'A'
           when $projection.SapStatusCode = cast( '10' as abap.sstring(4) ) then 'S'
           when $projection.SapStatusCode = cast( '11' as abap.sstring(4) ) then 'C'
           when $projection.SapStatusCode = cast( '13' as abap.sstring(4) ) then 'S'
           when $projection.SapStatusCode = cast( 'E'  as abap.sstring(4) ) then 'S'
           when $projection.SapStatusCode = cast( 'B'  as abap.sstring(4) ) then 'S'
           when ( $projection.SapStatusCode = cast( 'S'  as abap.sstring(4) ) and $projection.RemainingAmount > 0 ) then 'S'
           when $projection.SapStatusCode = cast( 'D' as abap.sstring(4) )  then 'W'
           else Action.action_code
         end                                                                                           as ActionCode,

         case
           when $projection.InvoiceAccountingDocument is null and Finteo.status_code = '6' and $projection.AccountingDocument is not null then 'Geri Al'
           when $projection.SapStatusCode = cast( '1' as abap.sstring(4) )  then 'Gönder'
           when ( $projection.SapStatusCode = cast( '7' as abap.sstring(4) ) and $projection.RemainingAmount = 0 )  then 'Aksiyon Yok'
           when ( $projection.SapStatusCode = cast( '7' as abap.sstring(4) ) and $projection.RemainingAmount > 0 )  then 'Gönder'
           when $projection.SapStatusCode = cast( '8' as abap.sstring(4) )  then 'Muhasebeleştir'
           when $projection.SapStatusCode = cast( '10' as abap.sstring(4) ) then 'Gönder'
           when $projection.SapStatusCode = cast( '11' as abap.sstring(4) ) then 'Geri Al'
           when $projection.SapStatusCode = cast( '13' as abap.sstring(4) ) then 'Gönder'
           when $projection.SapStatusCode = cast( 'E'  as abap.sstring(4) ) then 'Gönder'
           when $projection.SapStatusCode = cast( 'B'  as abap.sstring(4) ) then 'Gönder'
           when $projection.SapStatusCode = cast( 'D' as abap.sstring(4) )  then 'Aksiyon Yok'
           else Action.action_definition
         end                                                                                           as ActionDefinition,

         //         case
         //         when $projection.InvoiceNumber is not initial then 'sap-icon://history'
         //         else 'sap-icon://history'
         //         end

         cast( 'sap-icon://history' as abap.char( 40 ) )                                               as ShowLog,
         cast( 'sap-icon://accounting-document-verification' as abap.char( 80 ) )                      as Clearing

         //         case
         //         when $projection.InvoiceNumber is not initial then 'sap-icon://accounting-document-verification'
         //         else 'sap-icon://accounting-document-verification'
         //         end                                                                                           as Clearing
}
where
       Invoices.due_date        >= '20260701'
  and  Invoices.amount          >  0
  and(
       Invoices.invoice_acc_doc is initial
    or JE.ReverseDocument       is initial
  )
