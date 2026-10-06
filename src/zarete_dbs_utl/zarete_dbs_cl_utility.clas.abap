CLASS zarete_dbs_cl_utility DEFINITION
  PUBLIC
  INHERITING FROM cl_abap_behv
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES: BEGIN OF ty_fi_docu,
             reference_id        TYPE string,
             accounting_document TYPE zarete_dbs_accounting_document,
             company_code        TYPE zarete_dbs_company_code_id,
             fiscal_year         TYPE zarete_dbs_fiscal_year_id,
           END OF ty_fi_docu,

           BEGIN OF ty_inv_details,
             invoice_number         TYPE zarete_dbs_t015-invoice_number,
             id                     TYPE zarete_dbs_t015-id,
             bp_no                  TYPE zarete_dbs_t012-bp_no,
             posting_date           TYPE string,
             document_date          TYPE string,
             assignment_reference   TYPE zarete_dbs_t017-assignment_reference,
             value_date             TYPE zarete_dbs_t017-value_date,
             document_text          TYPE string,
             amount                 TYPE p LENGTH 9 DECIMALS 2,
             currency_code          TYPE string,
             accounting_document    TYPE zarete_dbs_t015-invoice_acc_doc,
             partial_invoice_number TYPE zarete_dbs_t016-partial_invoice_number,
           END OF ty_inv_details,

           BEGIN OF ty_selected_invoices,
             dbs_invoice_id         TYPE zarete_dbs_dd_t016-DbsInvoiceId,
             invoice_number         TYPE zarete_dbs_dd_t015-InvoiceNumber,
             partial_invoice_number TYPE zarete_dbs_dd_t016-PartialInvoiceNumber,
             id                     TYPE zarete_dbs_dd_t015-Id,
             bank_code              TYPE zarete_dbs_dd_t012-CompanyBankCode,
             amount                 TYPE zarete_dbs_dd_t016-Amount,
             currency               TYPE zarete_dbs_dd_t016-CurrencyCode,
             customer               TYPE zarete_dbs_dd_t017-Customer,
             message                TYPE char72,
           END OF ty_selected_invoices,

           BEGIN OF ty_businesspartner,
             companycode     TYPE bukrs,
             businesspartner TYPE kunnr,
           END OF ty_businesspartner,

           BEGIN OF ty_finallimit,
             CompanyCode                 TYPE I_OperationalAcctgDocItem-CompanyCode,
             Customer                    TYPE I_OperationalAcctgDocItem-customer,
             AmountInCompanyCodeCurrency TYPE I_OperationalAcctgDocItem-AmountInCompanyCodeCurrency,
             CompanyCodeCurrency         TYPE I_OperationalAcctgDocItem-CompanyCodeCurrency,
           END OF ty_finallimit,

           BEGIN OF ty_clearing_documents,
             company_code               TYPE zarete_dbs_t022-company_code,
             fiscal_year                TYPE zarete_dbs_t022-fiscal_year,
             accounting_document        TYPE zarete_dbs_t022-accounting_document,
             accounting_document_item   TYPE zarete_dbs_t022-accounting_document_item,
             customer                   TYPE zarete_dbs_t022-customer,
             customer_name              TYPE zarete_dbs_t022-customer_name,
             posting_date               TYPE zarete_dbs_t022-posting_date,
             document_date              TYPE zarete_dbs_t022-document_date,
             net_due_date               TYPE zarete_dbs_t022-net_due_date,
             accounting_document_type   TYPE zarete_dbs_t022-accounting_document_type,
             amount_in_transaction_curr TYPE zarete_dbs_t022-amount_in_transaction_curr,
             transaction_currency       TYPE zarete_dbs_t022-transaction_currency,
             used_amount                TYPE zarete_dbs_t022-used_amount,
             available_amount           TYPE zarete_dbs_t022-available_amount,
           END OF ty_clearing_documents,

           BEGIN OF ty_clearing_data,
             company_code              TYPE zarete_dbs_t022-company_code,
             fiscal_year               TYPE zarete_dbs_t022-fiscal_year,
             accounting_document1      TYPE zarete_dbs_t022-accounting_document,
             accounting_document_item1 TYPE zarete_dbs_t022-accounting_document_item,
             accounting_document2      TYPE zarete_dbs_t022-accounting_document,
             accounting_document_item2 TYPE zarete_dbs_t022-accounting_document_item,
             customer                  TYPE zarete_dbs_t022-customer,
             invoice_number            TYPE zarete_dbs_t015-invoice_number,
             id                        TYPE zarete_dbs_t015-id,
             currency                  TYPE zarete_dbs_t022-transaction_currency,
             amount                    TYPE zarete_dbs_t022-amount_in_transaction_curr,
             due_date                  TYPE zarete_dbs_t022-net_due_date,
           END OF ty_clearing_data,

           BEGIN OF ty_item,
             inv_type                 TYPE c LENGTH 1,
             accounting_document      TYPE zarete_dbs_dd_t043-AccountingDocument,
             accounting_document_item TYPE zarete_dbs_dd_t043-AccountingDocumentItem,
             fiscal_year              TYPE zarete_dbs_dd_t043-FiscalYear,
             amount                   TYPE zarete_dbs_dd_t043-DocumentAmount,
             used_amount              TYPE zarete_dbs_dd_t043-DocumentAmount,
             currency                 TYPE zarete_dbs_dd_t043-Currency,
             inv_number               TYPE zarete_dbs_t024-invoice_number,
             partial_invoice_number   TYPE zarete_dbs_t016-partial_invoice_number,
             id                       TYPE zarete_dbs_t024-id,
           END OF ty_item,

           tt_item TYPE STANDARD TABLE OF ty_item WITH EMPTY KEY,

           BEGIN OF ty_header,
             customer TYPE zarete_dbs_dd_t043-Customer,
             currency TYPE zarete_dbs_dd_t043-Currency,
             item     TYPE tt_item,
             t024     TYPE tt_item,
           END OF ty_header,

           tt_header TYPE STANDARD TABLE OF ty_header.

    TYPES: tt_fi_documents      TYPE STANDARD TABLE OF ty_fi_docu WITH DEFAULT KEY,
           tt_selected_invoices TYPE STANDARD TABLE OF ty_selected_invoices WITH DEFAULT KEY,
           tt_filtered_invoices TYPE STANDARD TABLE OF zarete_dbs_dd_doc_read_001 WITH DEFAULT KEY,
           tt_businesspartner   TYPE STANDARD TABLE OF ty_businesspartner WITH DEFAULT KEY,
           tt_finallimit        TYPE STANDARD TABLE OF ty_finallimit WITH DEFAULT KEY,
           tt_clearing_data     TYPE STANDARD TABLE OF ty_clearing_data WITH DEFAULT KEY.

    METHODS:
      constructor, "fi belgesinin oluşması için constructor
      run, "job kurulacak ana method
      journal_entry_create IMPORTING is_request         TYPE zarete_dbs_journal_entry_bulk OPTIONAL
                           EXPORTING ev_document_number TYPE string
                                     ev_company_code    TYPE string
                                     ev_fiscal_year     TYPE string
                                     et_fi_documents    TYPE tt_fi_documents
                                     et_message         TYPE zarete_dbs_tt_message,
      journal_entry_test_mode IMPORTING is_request TYPE zarete_dbs_journal_entry_bulk OPTIONAL
                              EXPORTING et_message TYPE zarete_dbs_tt_message,
      get_invoices IMPORTING VALUE(iv_startdate)         TYPE string
                             VALUE(iv_finishdate)        TYPE string
                             VALUE(iv_bankid)            TYPE string OPTIONAL
                             VALUE(iv_partycode)         TYPE string OPTIONAL
                             VALUE(iv_identifier)        TYPE string OPTIONAL
                             VALUE(iv_dbsinvoiceid)      TYPE string OPTIONAL
                             VALUE(iv_statuscode)        TYPE int4   OPTIONAL
                             VALUE(iv_statusdescription) TYPE string OPTIONAL,
      customer_bank IMPORTING is_business_partner TYPE zarete_dbs_t012 OPTIONAL
                              is_invoice_details  TYPE ty_inv_details OPTIONAL
                    EXPORTING ev_document_number  TYPE string
                              ev_company_code     TYPE string
                              ev_fiscal_year      TYPE string
                              et_message          TYPE zarete_dbs_tt_message,
      customer_bank_mapping IMPORTING is_business_partner TYPE zarete_dbs_t012 OPTIONAL
                                      is_invoice_details  TYPE ty_inv_details OPTIONAL
                            EXPORTING es_map              TYPE zarete_dbs_journal_entry_cre18,
      create_number_range_interval EXPORTING ev_error TYPE c,
      get_number_next EXPORTING ev_number TYPE char7,
      bp_list,
      bank_list,
      update_due_date IMPORTING iv_invoice_number TYPE zarete_dbs_t015-invoice_number
                                iv_due_date       TYPE string,
      send_invoice IMPORTING iv_clr_amount TYPE wrbtr OPTIONAL
                   CHANGING  ct_invoices   TYPE  tt_selected_invoices,
      delete_invoice CHANGING ct_invoices TYPE tt_selected_invoices,
      create_acc_doc CHANGING ct_invoices TYPE tt_selected_invoices,
      fill_limit_tables IMPORTING iv_company_code TYPE zarete_dbs_t014-company_code
                                  iv_behavior     TYPE c OPTIONAL
                        CHANGING  ct_limit        TYPE zarete_dbs_sc_finteo_api=>ty_limit,
      get_limit_data IMPORTING iv_behavior  TYPE c OPTIONAL
                               iv_partycode TYPE zarete_dbs_t012-bp_no OPTIONAL
                               iv_bankcode  TYPE zarete_dbs_t012-company_bank_code OPTIONAL
                     EXPORTING et_limit     TYPE zarete_dbs_sc_finteo_api=>ty_limit,
      filter_invoices CHANGING ct_invoices TYPE tt_filtered_invoices,
      limits_and_invoices IMPORTING it_businesspartner TYPE tt_businesspartner
                          EXPORTING et_finallimit      TYPE tt_finallimit,
      delivery_limit_control IMPORTING iv_delivery TYPE zwm_de_char10
                             EXPORTING ev_message  TYPE bapiret2-message
                                       ev_msgtype  TYPE bapiret2-type,
      get_documents_for_clearing,
      clearing_mapping IMPORTING it_clearing_documents TYPE tt_clearing_data
                       EXPORTING es_request            TYPE zfi_denk_journal_entry_bulk_cl,
      clearing_mapping_v2 IMPORTING it_header  TYPE tt_header
                          EXPORTING es_request TYPE zfi_denk_journal_entry_bulk_cl,
      clearing CHANGING  ct_invoices   TYPE  tt_selected_invoices,
      clearing_new  CHANGING  ct_invoices   TYPE  tt_selected_invoices,
      set_log
        IMPORTING io_log TYPE REF TO if_bali_log.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA go_log TYPE REF TO if_bali_log.

    METHODS add_log_text
      IMPORTING iv_text     TYPE string
                iv_severity TYPE if_bali_constants=>ty_severity
                  DEFAULT if_bali_constants=>c_severity_status.
ENDCLASS.



CLASS ZARETE_DBS_CL_UTILITY IMPLEMENTATION.


  METHOD bank_list.

    DATA: lt_t019_create TYPE TABLE FOR CREATE zarete_dbs_dd_t019,
          lt_t019_update TYPE TABLE FOR UPDATE zarete_dbs_dd_t019,
          lt_bank_list   TYPE TABLE OF zarete_dbs_t019.

    SELECT DISTINCT bankcode,                           "#EC CI_NOWHERE
                    bankname
    FROM zarete_dbs_t013
    INTO TABLE @DATA(lt_t013).

    LOOP AT lt_t013 ASSIGNING FIELD-SYMBOL(<fs_bank_list>).

      SELECT SINGLE * FROM zarete_dbs_t019 WHERE bank_code EQ @<fs_bank_list>-bankcode INTO @DATA(ls_t019). "#EC CI_ALL_FIELDS_NEEDED
      IF sy-subrc NE 0.
        APPEND INITIAL LINE TO lt_t019_create ASSIGNING FIELD-SYMBOL(<fs_create>).
        <fs_create>-BankCode          = <fs_bank_list>-bankcode.
        <fs_create>-BankName          = <fs_bank_list>-bankname.
        <fs_create>-%control-BankCode = if_abap_behv=>mk-on.
        <fs_create>-%control-BankName = if_abap_behv=>mk-on.

      ENDIF.

    ENDLOOP.

    MODIFY ENTITIES OF zarete_dbs_dd_t019 ENTITY zarete_dbs_dd_t019
    CREATE AUTO FILL CID WITH lt_t019_create
    MAPPED DATA(lt_mapped_t019_cr)
    FAILED DATA(lt_failed_t019_cr)
    REPORTED DATA(lt_reported_t019_cr).

    IF cl_abap_behv_aux=>get_current_handler_kind( ) IS INITIAL.
      COMMIT ENTITIES RESPONSE OF zarete_dbs_dd_t019
      FAILED DATA(lt_failed_t019_co)
      REPORTED DATA(lt_reported_t019_co).
    ENDIF.

  ENDMETHOD.


  METHOD bp_list.

    DATA: lt_t018_create TYPE TABLE FOR CREATE zarete_dbs_dd_t018,
          lt_t018_update TYPE TABLE FOR UPDATE zarete_dbs_dd_t018.

    READ ENTITIES OF zarete_dbs_dd_bp_001
    ENTITY zarete_dbs_dd_bp_001
    ALL FIELDS WITH VALUE #( (  ) )
    RESULT DATA(lt_bp_list).

    LOOP AT lt_bp_list ASSIGNING FIELD-SYMBOL(<fs_bp_list>).

      SELECT SINGLE * FROM zarete_dbs_t018 WHERE business_partner EQ @<fs_bp_list>-bptax_number INTO @DATA(ls_t018). "#EC CI_ALL_FIELDS_NEEDED
      IF sy-subrc EQ 0.
        APPEND INITIAL LINE TO lt_t018_update ASSIGNING FIELD-SYMBOL(<fs_update>).
        <fs_update>-BusinessPartner                  = |{ ls_t018-business_partner ALPHA = OUT }|.
        <fs_update>-BusinessPartnerFullName          = <fs_bp_list>-business_partner_full_name.
        <fs_update>-BptaxNumber                      = <fs_bp_list>-bptax_number.
        <fs_update>-%control-BusinessPartnerFullName = if_abap_behv=>mk-on.
        <fs_update>-%control-BptaxNumber             = if_abap_behv=>mk-on.
      ELSE.
        APPEND INITIAL LINE TO lt_t018_create ASSIGNING FIELD-SYMBOL(<fs_create>).
        <fs_create>-BusinessPartner                  = |{ <fs_bp_list>-business_partner ALPHA = OUT }|.
        <fs_create>-BusinessPartnerFullName          = <fs_bp_list>-business_partner_full_name.
        <fs_create>-BptaxNumber                      = <fs_bp_list>-bptax_number.
        <fs_create>-%control-BusinessPartner         = if_abap_behv=>mk-on.
        <fs_create>-%control-BusinessPartnerFullName = if_abap_behv=>mk-on.
        <fs_create>-%control-BptaxNumber             = if_abap_behv=>mk-on.
      ENDIF.

    ENDLOOP.

    MODIFY ENTITIES OF zarete_dbs_dd_t018 ENTITY zarete_dbs_dd_t018
    CREATE AUTO FILL CID WITH lt_t018_create
    MAPPED DATA(lt_mapped_t018_cr)
    FAILED DATA(lt_failed_t018_cr)
    REPORTED DATA(lt_reported_t018_cr).

    MODIFY ENTITIES OF zarete_dbs_dd_t018 ENTITY zarete_dbs_dd_t018
    UPDATE FIELDS (  BusinessPartnerFullName BptaxNumber  ) WITH lt_t018_update
    MAPPED DATA(lt_mapped_t018_up)
    FAILED DATA(lt_failed_t018_up)
    REPORTED DATA(lt_reported_t018_up).

    IF cl_abap_behv_aux=>get_current_handler_kind( ) IS INITIAL.
      COMMIT ENTITIES RESPONSE OF zarete_dbs_dd_t018
      FAILED DATA(lt_failed_t018_co)
      REPORTED DATA(lt_reported_t018_co).
    ENDIF.

  ENDMETHOD.


  METHOD constructor.

    super->constructor( ).

  ENDMETHOD.


  METHOD create_acc_doc.

    DATA: ls_business_partner TYPE zarete_dbs_t012,
          ls_invoice_details  TYPE ty_inv_details.

    DATA: lt_t015_update TYPE TABLE FOR UPDATE zarete_dbs_dd_t015,
          lt_t031_create TYPE TABLE FOR CREATE zarete_dbs_dd_t031.

    DATA: lt_header  TYPE tt_header,
          ls_request TYPE  zfi_denk_journal_entry_bulk_cl,
          lt_in_tab  TYPE cl_abap_parallel=>t_in_inst_tab,
          lt_out_tab TYPE cl_abap_parallel=>t_out_inst_tab.

    DATA(lo_parallel) = NEW cl_abap_parallel( ).
    DATA(lo_denk) = NEW zcl_fi_denk_parallel( ).
    DATA(lo_log) = zarete_dbs_cl_log=>get_factory( ).

    IF ct_invoices IS NOT INITIAL.

      SELECT t017~accounting_document,
             t017~accounting_document_item,
             t017~document_reference_id,
             t017~posting_date,
             t017~document_date,
             t017~document_item_text,
             t017~assignment_reference,
             t017~value_date,
             t016~transaction_date,
             t016~last_payment_date ,
             t016~invoice_number,
             t016~due_date
         FROM zarete_dbs_t017 AS t017
         LEFT OUTER JOIN zarete_dbs_t016 AS t016 ON t016~invoice_number EQ t017~document_reference_id AND t016~amount IS NOT INITIAL
         FOR ALL ENTRIES IN @ct_invoices
         WHERE document_reference_id EQ @ct_invoices-invoice_number
         INTO TABLE @DATA(lt_t017).

      SELECT t012~company_bank_code,
             t012~bp_no,
             t012~glaccount,
             t012~house_bank,
             t012~house_bank_account
         FROM zarete_dbs_t012 AS t012
         FOR ALL ENTRIES IN @ct_invoices
         WHERE company_bank_code EQ @ct_invoices-bank_code
         AND   bp_no EQ @ct_invoices-customer
         INTO TABLE @DATA(lt_t012).

      LOOP AT ct_invoices ASSIGNING FIELD-SYMBOL(<fs_invoices>).

        SORT lt_t017 BY invoice_number due_date DESCENDING.
        READ TABLE lt_t017 ASSIGNING FIELD-SYMBOL(<fs_t017>) WITH KEY document_reference_id = <fs_invoices>-invoice_number.
        IF sy-subrc EQ 0.

          READ TABLE lt_t012 ASSIGNING FIELD-SYMBOL(<fs_t012>) WITH KEY company_bank_code = <fs_invoices>-bank_code
                                                                        bp_no = <fs_invoices>-customer.
          IF sy-subrc EQ 0.

            DATA(lv_date) = CONV d( |{ <fs_t017>-last_payment_date(4) }{ <fs_t017>-last_payment_date+5(2) }{ <fs_t017>-last_payment_date+8(2) }| ).
            ls_invoice_details-posting_date            = lv_date.
            ls_invoice_details-document_date           = lv_date.
            ls_invoice_details-assignment_reference    = <fs_t017>-assignment_reference.
            ls_invoice_details-value_date              = lv_date.
            ls_invoice_details-invoice_number          = <fs_invoices>-invoice_number.
            ls_invoice_details-id                      = <fs_invoices>-id.
            ls_invoice_details-currency_code           = <fs_invoices>-currency.
            ls_invoice_details-amount                  = <fs_invoices>-amount.
            ls_invoice_details-document_text           = <fs_t017>-document_item_text.
            ls_invoice_details-accounting_document     = <fs_t017>-accounting_document.
            ls_invoice_details-partial_invoice_number  = <fs_invoices>-partial_invoice_number.

            ls_business_partner-bp_no              = |{ <fs_invoices>-customer ALPHA = OUT }|.
            ls_business_partner-glaccount          = <fs_t012>-glaccount.
            ls_business_partner-house_bank         = <fs_t012>-house_bank.
            ls_business_partner-house_bank_account = <fs_t012>-house_bank_account.

            customer_bank(
              EXPORTING
                is_business_partner = ls_business_partner
                is_invoice_details  = ls_invoice_details
              IMPORTING
                ev_document_number  = DATA(lv_docno)
                ev_company_code     = DATA(lv_company_code)
                ev_fiscal_year      = DATA(lv_fiscal_year)
                et_message          = DATA(lt_message)
            ).

            IF lv_docno IS INITIAL.

              SELECT SINGLE invoice_number,
                            uuid,
                            id
                FROM zarete_dbs_t015
                WHERE invoice_number EQ @<fs_invoices>-invoice_number
                AND   id EQ @<fs_invoices>-id
                INTO @DATA(ls_t015).
              IF sy-subrc EQ 0.

                APPEND INITIAL LINE TO lt_t015_update ASSIGNING FIELD-SYMBOL(<fs_t015_update>).
                <fs_t015_update>-InvoiceNumber               = ls_t015-invoice_number.
                <fs_t015_update>-Uuid                        = ls_t015-uuid.
                <fs_t015_update>-Id                          = ls_t015-id.
                <fs_t015_update>-AccError                    = 'X'.
                <fs_t015_update>-%control-AccError = if_abap_behv=>mk-on.

                MODIFY ENTITIES OF zarete_dbs_dd_t015 ENTITY zarete_dbs_dd_t015
                UPDATE FIELDS ( AccError ) WITH lt_t015_update
                MAPPED DATA(lt_mapped_t015_up)
                FAILED DATA(lt_failed_t015_up)
                REPORTED DATA(lt_reported_t015_up).

                <fs_invoices>-message = 'Muhasebe Belgesi Oluşturulamadı'.
                lo_log->set_sapinvoiceno( iv_sapinvoiceno = <fs_invoices>-invoice_number
                                          iv_id           = <fs_invoices>-id
                                          iv_bankcode     = <fs_invoices>-bank_code ).
                lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                                 msgno = '002'  ).

              ENDIF.

            ELSE.

              <fs_invoices>-message = 'Muhasebe Belgesi Oluşturuldu'.
              lo_log->set_sapinvoiceno( iv_sapinvoiceno = <fs_invoices>-invoice_number
                                        iv_id           = <fs_invoices>-id
                                        iv_bankcode     = <fs_invoices>-bank_code ).
              lo_log->add_log( msgty = if_abap_behv_message=>severity-success
                               msgno = '003'  ).

              SELECT COUNT( * )
                FROM zarete_dbs_t020
                WHERE accounting_document EQ @lv_docno
                AND   fiscal_year EQ @lv_fiscal_year
                AND   company_code EQ @lv_company_code
                INTO @DATA(lv_t020).
              IF sy-subrc NE 0.
                APPEND INITIAL LINE TO lt_t031_create ASSIGNING FIELD-SYMBOL(<fs_t031_create>).
                <fs_t031_create>-AccountingDocument          = lv_docno.
                <fs_t031_create>-FiscalYear                  = lv_fiscal_year.
                <fs_t031_create>-CompanyCode                 = lv_company_code.
                <fs_t031_create>-InvoiceNumber               = <fs_invoices>-invoice_number.
                <fs_t031_create>-Id                          = <fs_invoices>-id.
                <fs_t031_create>-Customer                    = |{ <fs_invoices>-customer ALPHA = OUT }|.
                <fs_t031_create>-%control-AccountingDocument = if_abap_behv=>mk-on.
                <fs_t031_create>-%control-FiscalYear         = if_abap_behv=>mk-on.
                <fs_t031_create>-%control-CompanyCode        = if_abap_behv=>mk-on.
                <fs_t031_create>-%control-InvoiceNumber      = if_abap_behv=>mk-on.
                <fs_t031_create>-%control-Id                 = if_abap_behv=>mk-on.
                <fs_t031_create>-%control-Customer           = if_abap_behv=>mk-on.

              ENDIF.

***
*Oluşan muhasebe belgesi ve orijinal SAP belgesi denkleştirilir

              WAIT UP TO 2 SECONDS.

              SELECT *                        "#EC CI_ALL_FIELDS_NEEDED
               FROM zarete_dbs_dd_invoice_001 WITH PRIVILEGED ACCESS
                FOR ALL ENTRIES IN @ct_invoices
                 WHERE Id EQ @ct_invoices-id
                   AND InvoiceNumber EQ @ct_invoices-invoice_number
                   AND PartialInvoiceNumber EQ @ct_invoices-partial_invoice_number
                   INTO TABLE @DATA(lt_main_inv).

              SELECT SINGLE AccountingDocument,
                            AccountingDocumentItem,
                            TransactionCurrency,
                            FiscalYear
                FROM I_OperationalAcctgDocItem
                WHERE AccountingDocument EQ @lv_docno
                AND   DebitCreditCode EQ 'H'
                INTO @DATA(ls_op).
              IF sy-subrc EQ 0.

                APPEND INITIAL LINE TO lt_header ASSIGNING FIELD-SYMBOL(<fs_header>).
                <fs_header>-customer         = <fs_invoices>-customer.
                <fs_header>-currency         = <fs_invoices>-currency.

                APPEND INITIAL LINE TO <fs_header>-item ASSIGNING FIELD-SYMBOL(<fs_fatura>).
                <fs_fatura>-accounting_document      = <fs_t017>-accounting_document.
                <fs_fatura>-accounting_document_item = <fs_t017>-accounting_document_item.
                <fs_fatura>-currency                 = <fs_invoices>-currency.
                <fs_fatura>-fiscal_year              = <fs_t017>-last_payment_date+0(4).
                <fs_fatura>-inv_type                 = 'F'.

                READ TABLE lt_main_inv INTO DATA(ls_main_inv) WITH KEY Id = <fs_invoices>-Id
                                                                       InvoiceNumber = <fs_invoices>-invoice_number
                                                                       PartialInvoiceNumber = <fs_invoices>-partial_invoice_number.
                IF sy-subrc = 0.
                  IF ls_main_inv-SendAmount LT ls_main_inv-Amount.
                    "<fs_fatura>-amount = ls_main_inv-SendAmount.
                  ENDIF.
                ENDIF.

                APPEND INITIAL LINE TO <fs_header>-t024 ASSIGNING FIELD-SYMBOL(<fs_t024>).
                <fs_t024> = CORRESPONDING #( <fs_fatura> ).

                APPEND INITIAL LINE TO <fs_header>-item ASSIGNING FIELD-SYMBOL(<fs_item>).
                <fs_item>-accounting_document      = ls_op-AccountingDocument.
                <fs_item>-accounting_document_item = ls_op-AccountingDocumentItem.
                <fs_item>-currency                 = ls_op-TransactionCurrency.
                <fs_item>-fiscal_year              = ls_op-FiscalYear.
                <fs_item>-inv_number               = <fs_invoices>-invoice_number.
                <fs_item>-partial_invoice_number   = <fs_invoices>-partial_invoice_number.
                <fs_item>-id                       = <fs_invoices>-id.
                APPEND INITIAL LINE TO <fs_header>-t024 ASSIGNING <fs_t024>.
                <fs_t024> = CORRESPONDING #( <fs_item> ).

                " Gönderilen Tutar  - Fatura tutarından küçükse DZ belgelerini bulup onlarıda ekle !
                IF ls_main_inv-SendAmount LT ls_main_inv-Amount.

                  DATA : lv_customer TYPE kunnr.
                  DATA : lv_amount   TYPE zarete_dbs_dd_t043-DocumentAmountAbs.

                  lv_customer = |{ <fs_invoices>-customer ALPHA = IN }|.

                  SELECT *                    "#EC CI_ALL_FIELDS_NEEDED
                   FROM zarete_dbs_dd_t043
                    WHERE customer = @lv_customer
                      AND AccountingDocumentType = 'DZ'
                      AND DebitCreditCode = 'H'
                      AND InvoiceReference EQ @<fs_t017>-accounting_document
                     INTO TABLE @DATA(lt_t043).

                  lv_amount = REDUCE menge_d( INIT va TYPE menge_d  FOR lt_043 IN lt_t043
                                            NEXT va = va + lt_043-DocumentAmountAbs ).

                  lv_amount +=  ls_main_inv-SendAmount.

                  " Denkleşecek Belge Tutarları Fatura Tutarına Eşitse Gir !
                  IF lv_amount = ls_main_inv-Amount.
                    LOOP AT lt_t043 INTO DATA(ls_t043).

                      APPEND INITIAL LINE TO <fs_header>-item ASSIGNING <fs_item>.
                      <fs_item>-accounting_document      = ls_t043-AccountingDocument.
                      <fs_item>-accounting_document_item = ls_t043-AccountingDocumentItem.
                      <fs_item>-currency                 = ls_t043-Currency.
                      <fs_item>-fiscal_year              = ls_t043-FiscalYear.
                      <fs_item>-inv_number               = <fs_invoices>-invoice_number.
                      <fs_item>-partial_invoice_number   = <fs_invoices>-partial_invoice_number.
                      <fs_item>-id                       = <fs_invoices>-id.

                    ENDLOOP.
                  ENDIF.

                ENDIF.
              ENDIF.
            ENDIF.

          ELSE.

            <fs_invoices>-message = 'Ana Hesap Bilgisi Bulunamadı'.
            lo_log->set_sapinvoiceno( iv_sapinvoiceno = <fs_invoices>-invoice_number
                                      iv_id           = <fs_invoices>-id
                                      iv_bankcode     = <fs_invoices>-bank_code ).
            lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                             msgno = '004'  ).
          ENDIF.

        ELSE.

*SAP Dışı Faturaların Muhasebeleştirilmesi
          READ TABLE lt_t012 ASSIGNING <fs_t012> WITH KEY company_bank_code = <fs_invoices>-bank_code
                                                          bp_no = <fs_invoices>-customer.
          IF sy-subrc EQ 0.

            IF <fs_t012>-glaccount IS INITIAL.
              <fs_invoices>-message = '102* Hesap Bilgisi Bulunamadı'.
              lo_log->set_sapinvoiceno( iv_sapinvoiceno = <fs_invoices>-invoice_number
                                        iv_id           = <fs_invoices>-id
                                        iv_bankcode     = <fs_invoices>-bank_code ).
              lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                               msgno = '002'
                               msgtx = '102* Hesap Bilgisi Bulunamadı' ).

              CONTINUE.
            ENDIF.

            SELECT SINGLE *                   "#EC CI_ALL_FIELDS_NEEDED
              FROM zarete_dbs_t016
              WHERE invoice_number EQ @<fs_invoices>-invoice_number
              INTO @DATA(ls_t016).

            IF ls_t016-due_date GE '20260701'.

              lv_date = CONV d( |{ ls_t016-last_payment_date(4) }{ ls_t016-last_payment_date+5(2) }{ ls_t016-last_payment_date+8(2) }| ).

              ls_invoice_details-posting_date            = lv_date.
              ls_invoice_details-document_date           = lv_date.
              ls_invoice_details-assignment_reference    = <fs_invoices>-invoice_number.
              ls_invoice_details-value_date              = lv_date.
              ls_invoice_details-invoice_number          = <fs_invoices>-invoice_number.
              ls_invoice_details-id                      = <fs_invoices>-id.
              ls_invoice_details-currency_code           = 'TRY'.
              ls_invoice_details-amount                  = <fs_invoices>-amount.
              ls_invoice_details-document_text           = |{ <fs_invoices>-invoice_number } { 'Fatura Ödemesi' }|.
              ls_invoice_details-partial_invoice_number  = <fs_invoices>-partial_invoice_number.

              ls_business_partner-bp_no              = |{ <fs_invoices>-customer ALPHA = OUT }|.
              ls_business_partner-glaccount          = <fs_t012>-glaccount.
              ls_business_partner-house_bank         = <fs_t012>-house_bank.
              ls_business_partner-house_bank_account = <fs_t012>-house_bank_account.

              customer_bank(
                EXPORTING
                  is_business_partner = ls_business_partner
                  is_invoice_details  = ls_invoice_details
                IMPORTING
                  ev_document_number  = lv_docno
                  ev_company_code     = lv_company_code
                  ev_fiscal_year      = lv_fiscal_year
                  et_message          = lt_message
              ).

              IF lv_docno IS INITIAL.

                SELECT SINGLE invoice_number,
                              uuid,
                              id
                  FROM zarete_dbs_t015
                  WHERE invoice_number EQ @<fs_invoices>-invoice_number
                  AND   id EQ @<fs_invoices>-id
                  INTO @ls_t015.
                IF sy-subrc EQ 0.

                  APPEND INITIAL LINE TO lt_t015_update ASSIGNING <fs_t015_update>.
                  <fs_t015_update>-InvoiceNumber               = ls_t015-invoice_number.
                  <fs_t015_update>-Uuid                        = ls_t015-uuid.
                  <fs_t015_update>-Id                          = ls_t015-id.
                  <fs_t015_update>-AccError                    = 'X'.
                  <fs_t015_update>-%control-AccError = if_abap_behv=>mk-on.

                  MODIFY ENTITIES OF zarete_dbs_dd_t015 ENTITY zarete_dbs_dd_t015
                  UPDATE FIELDS ( AccError ) WITH lt_t015_update
                  MAPPED lt_mapped_t015_up
                  FAILED lt_failed_t015_up
                  REPORTED lt_reported_t015_up.

                  <fs_invoices>-message = 'Muhasebe Belgesi Oluşturulamadı'.
                  lo_log->set_sapinvoiceno( iv_sapinvoiceno = <fs_invoices>-invoice_number
                                            iv_id           = <fs_invoices>-id
                                            iv_bankcode     = <fs_invoices>-bank_code ).
                  lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                                   msgno = '002'  ).

                ENDIF.

              ELSE.

                <fs_invoices>-message = 'Muhasebe Belgesi Oluşturuldu'.
                lo_log->set_sapinvoiceno( iv_sapinvoiceno = <fs_invoices>-invoice_number
                                          iv_id           = <fs_invoices>-id
                                          iv_bankcode     = <fs_invoices>-bank_code ).
                lo_log->add_log( msgty = if_abap_behv_message=>severity-success
                                 msgno = '003'  ).

                SELECT COUNT( * )
                  FROM zarete_dbs_t020
                  WHERE accounting_document EQ @lv_docno
                  AND   fiscal_year EQ @lv_fiscal_year
                  AND   company_code EQ @lv_company_code
                  INTO @lv_t020.
                IF sy-subrc NE 0.
                  APPEND INITIAL LINE TO lt_t031_create ASSIGNING <fs_t031_create>.
                  <fs_t031_create>-AccountingDocument          = lv_docno.
                  <fs_t031_create>-FiscalYear                  = lv_fiscal_year.
                  <fs_t031_create>-CompanyCode                 = lv_company_code.
                  <fs_t031_create>-InvoiceNumber               = <fs_invoices>-invoice_number.
                  <fs_t031_create>-Id                          = <fs_invoices>-id.
                  <fs_t031_create>-Customer                    = |{ <fs_invoices>-customer ALPHA = OUT }|.
                  <fs_t031_create>-%control-AccountingDocument = if_abap_behv=>mk-on.
                  <fs_t031_create>-%control-FiscalYear         = if_abap_behv=>mk-on.
                  <fs_t031_create>-%control-CompanyCode        = if_abap_behv=>mk-on.
                  <fs_t031_create>-%control-InvoiceNumber      = if_abap_behv=>mk-on.
                  <fs_t031_create>-%control-Id                 = if_abap_behv=>mk-on.
                  <fs_t031_create>-%control-Customer           = if_abap_behv=>mk-on.

                ENDIF.

              ENDIF.

            ELSE.
              <fs_invoices>-message = '1 Temmuz Öncesi Belgeler Muhaseleştirilemez'.
            ENDIF.

          ELSE.

            <fs_invoices>-message = 'Ana Hesap Bilgisi Bulunamadı'.
            lo_log->set_sapinvoiceno( iv_sapinvoiceno = <fs_invoices>-invoice_number
                                      iv_id           = <fs_invoices>-id
                                      iv_bankcode     = <fs_invoices>-bank_code ).
            lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                             msgno = '004'  ).

          ENDIF.

        ENDIF.

      ENDLOOP.

*Muhasebeleşen belgelerin denkleştirilmesi aşamasında lock sorunu olmaması için
*tabloya toplanıp toplu şekilde apiye gönderilmesi gerekiyor

      clearing_mapping_v2( EXPORTING it_header = lt_header
                           IMPORTING es_request = ls_request ).

      lo_denk->input = ls_request.
      APPEND lo_denk TO lt_in_tab.

      lo_parallel->run_inst( EXPORTING p_in_tab  = lt_in_tab  IMPORTING p_out_tab = lt_out_tab ).

      MODIFY ENTITIES OF zarete_dbs_dd_t031 ENTITY zarete_dbs_dd_t031
      CREATE AUTO FILL CID WITH lt_t031_create
      MAPPED DATA(lt_mapped_t031_cr)
      FAILED DATA(lt_failed_t031_cr)
      REPORTED DATA(lt_reported_t031_cr).

    ENDIF.

  ENDMETHOD.


  METHOD create_number_range_interval.

    DATA: lt_interval TYPE cl_numberrange_intervals=>nr_interval.

    TRY.
        cl_numberrange_runtime=>number_status( EXPORTING nr_range_nr = '01' object = 'ZDBS_ID'
                                               IMPORTING number      = DATA(lv_check) ).
        SHIFT lv_check LEFT DELETING LEADING '0'.
      CATCH cx_nr_object_not_found INTO DATA(lx_no_obj_found).
        DATA(lv_longtext) = lx_no_obj_found->get_longtext(  ).
      CATCH cx_number_ranges INTO DATA(cx_number_ranges).
        DATA(lv_longtext2) = cx_number_ranges->get_longtext(  ) .
    ENDTRY.

    IF lv_check IS INITIAL.

      lt_interval = VALUE #( ( subobject = '' nrrangenr = '01' fromnumber = '1000000' tonumber = '9999999' procind = 'I' ) ).

      TRY.
          cl_numberrange_intervals=>create( EXPORTING interval = lt_interval object = 'ZDBS_ID'
                                            IMPORTING error = ev_error error_inf = DATA(lv_error_inf) error_iv  = DATA(lv_error_iv) ).
        CATCH cx_nr_object_not_found INTO lx_no_obj_found.
          lv_longtext = lx_no_obj_found->get_longtext(  ).
        CATCH cx_number_ranges INTO cx_number_ranges.
          lv_longtext2 = cx_number_ranges->get_longtext(  ).
      ENDTRY.

    ENDIF.

  ENDMETHOD.


  METHOD customer_bank.

    DATA: lt_t015_update TYPE TABLE FOR UPDATE zarete_dbs_dd_t015.

    DATA(ls_request) = VALUE zarete_dbs_journal_entry_bulk( ).

    APPEND INITIAL LINE TO ls_request-journal_entry_bulk_create_requ-journal_entry_create_request ASSIGNING FIELD-SYMBOL(<fs_request>).

    customer_bank_mapping( EXPORTING is_business_partner = is_business_partner
                                     is_invoice_details  = is_invoice_details
                           IMPORTING es_map              = <fs_request>-journal_entry ).

*    journal_entry_test_mode( EXPORTING is_request = ls_request
*                             IMPORTING et_message = et_message ).

    journal_entry_create( EXPORTING is_request         = ls_request
                          IMPORTING ev_document_number = ev_document_number
                                    ev_company_code    = ev_company_code
                                    ev_fiscal_year     = ev_fiscal_year
                                    et_message         = et_message ).

    IF ev_document_number IS NOT INITIAL.

      SELECT SINGLE *                         "#EC CI_ALL_FIELDS_NEEDED
        FROM zarete_dbs_t015
        WHERE invoice_number EQ @is_invoice_details-invoice_number
        AND   id EQ @is_invoice_details-id
        INTO @DATA(ls_t015).
      IF sy-subrc EQ 0.

        APPEND INITIAL LINE TO lt_t015_update ASSIGNING FIELD-SYMBOL(<fs_t015_update>).
        <fs_t015_update>-InvoiceNumber               = ls_t015-invoice_number.
        <fs_t015_update>-Uuid                        = ls_t015-uuid.
        <fs_t015_update>-Id                          = ls_t015-id.
        <fs_t015_update>-AccountingDocument          = ev_document_number.
        <fs_t015_update>-CompanyCode                 = ev_company_code.
        <fs_t015_update>-FiscalYear                  = ev_fiscal_year.
        <fs_t015_update>-AccError                    = ''.
        <fs_t015_update>-%control-AccountingDocument = if_abap_behv=>mk-on.
        <fs_t015_update>-%control-CompanyCode        = if_abap_behv=>mk-on.
        <fs_t015_update>-%control-FiscalYear         = if_abap_behv=>mk-on.
        <fs_t015_update>-%control-AccError           = if_abap_behv=>mk-on.

        MODIFY ENTITIES OF zarete_dbs_dd_t015 ENTITY zarete_dbs_dd_t015
        UPDATE FIELDS ( AccountingDocument CompanyCode FiscalYear AccError ) WITH lt_t015_update
        MAPPED DATA(lt_mapped_t015_up)
        FAILED DATA(lt_failed_t015_up)
        REPORTED DATA(lt_reported_t015_up).

*        COMMIT ENTITIES RESPONSE OF zarete_dbs_dd_t015
*        FAILED DATA(lt_failed_t015_co)
*        REPORTED DATA(lt_reported_t015_co).

      ENDIF.

    ENDIF.

  ENDMETHOD.


  METHOD customer_bank_mapping.

    DATA: r_descr TYPE REF TO cl_abap_structdescr,
          gt_comp TYPE abap_component_tab.

    FIELD-SYMBOLS: <fs_journal_entry> TYPE any.

    SELECT * FROM zarete_dbs_t006 WHERE sap_kayit_ornegi = '*' INTO TABLE @DATA(lt_sabit).
    SORT lt_sabit DESCENDING BY sap_kayit_ornegi .
    SORT lt_sabit DESCENDING BY sap_alan_adi.
    DELETE ADJACENT DUPLICATES FROM lt_sabit COMPARING sap_alan_adi.

    r_descr ?= cl_abap_typedescr=>describe_by_data( es_map ).
    gt_comp = r_descr->get_components( ).
    LOOP AT lt_sabit INTO DATA(ls_sabit).

      TRANSLATE ls_sabit-sap_alan_adi TO UPPER CASE.
      READ TABLE gt_comp WITH KEY name = ls_sabit-sap_alan_adi INTO DATA(ls_comp).

      IF sy-subrc = 0.
        ASSIGN COMPONENT ls_comp-name OF STRUCTURE es_map TO <fs_journal_entry>.
        <fs_journal_entry> = ls_sabit-sap_alan_degeri.
      ENDIF.

    ENDLOOP.

    CLEAR: es_map-document_header_text.
    es_map-posting_date                = is_invoice_details-posting_date.
    es_map-document_date               = is_invoice_details-document_date.
    es_map-tax_determination_date      = is_invoice_details-document_date.
    es_map-original_reference_document = is_invoice_details-invoice_number.
    es_map-document_reference_id       = COND #( WHEN is_invoice_details-partial_invoice_number IS NOT INITIAL
                                                   THEN is_invoice_details-partial_invoice_number
                                                    ELSE is_invoice_details-invoice_number ).
    es_map-created_by_user             = sy-uname.
    es_map-document_header_text        = is_invoice_details-accounting_document.


    APPEND INITIAL LINE TO es_map-debtor_item ASSIGNING FIELD-SYMBOL(<fs_debtor_item>).
    <fs_debtor_item>-reference_document_item                      = '1'.
    <fs_debtor_item>-debtor                                       = |{ is_business_partner-bp_no ALPHA = OUT }|.
    <fs_debtor_item>-amount_in_transaction_currency-currency_code = COND #( WHEN is_invoice_details-currency_code IS NOT INITIAL THEN is_invoice_details-currency_code
                                                                            ELSE 'TRY' ).
    <fs_debtor_item>-amount_in_transaction_currency-content       = is_invoice_details-amount *  -1 .
*    <fs_debtor_item>-amount_in_company_code_currenc-currency_code = is_invoice_details-currency_code.
*    <fs_debtor_item>-amount_in_company_code_currenc-content       = is_invoice_details-amount *  -1 .
    <fs_debtor_item>-document_item_text                           = |{ is_invoice_details-invoice_number } { 'TAHSILATI' }|.

    APPEND INITIAL LINE TO es_map-item  ASSIGNING FIELD-SYMBOL(<fs_item>).
    <fs_item>-reference_document_item                      = '2'.
    <fs_item>-amount_in_transaction_currency-currency_code = COND #( WHEN is_invoice_details-currency_code IS NOT INITIAL THEN is_invoice_details-currency_code
                                                                     ELSE 'TRY' ).
    <fs_item>-amount_in_transaction_currency-content       = is_invoice_details-amount.
*    <fs_item>-amount_in_company_code_currenc-currency_code = is_invoice_details-currency_code.
*    <fs_item>-amount_in_company_code_currenc-content       = is_invoice_details-amount.
    <fs_item>-document_item_text                           = |{ is_invoice_details-invoice_number } { 'TAHSILATI' }|.
    <fs_item>-assignment_reference                         = is_invoice_details-assignment_reference.
    <fs_item>-value_date                                   = is_invoice_details-value_date.
    <fs_item>-glaccount-content                            = is_business_partner-glaccount.
    <fs_item>-house_bank                                   = is_business_partner-house_bank.
    <fs_item>-house_bank_account                           = is_business_partner-house_bank_account.

  ENDMETHOD.


  METHOD delete_invoice.

    DATA: lt_t015_create TYPE TABLE FOR CREATE zarete_dbs_dd_t015,
          lt_t015_update TYPE TABLE FOR UPDATE zarete_dbs_dd_t015,
          lt_t016_create TYPE TABLE FOR CREATE zarete_dbs_dd_t016,
          lt_t016_update TYPE TABLE FOR UPDATE zarete_dbs_dd_t016.

    DATA(lo_send) = NEW zarete_dbs_sc_finteo_api( ).
    DATA(lo_log) = zarete_dbs_cl_log=>get_factory( ).


*Key alanlarla ilgili satırın dbsinvoiceid alanı alınarak fatura silme metoduna gönderilir
    IF ct_invoices IS NOT INITIAL.

      SELECT *                                "#EC CI_ALL_FIELDS_NEEDED
      FROM zarete_dbs_t016
      FOR ALL ENTRIES IN @ct_invoices
      WHERE invoice_number         EQ @ct_invoices-invoice_number
      AND   dbs_invoice_id         EQ @ct_invoices-dbs_invoice_id
      AND   partial_invoice_number EQ @ct_invoices-partial_invoice_number
      AND   amount IS NOT INITIAL
      INTO TABLE @DATA(lt_t016).

    ENDIF.

    LOOP AT ct_invoices ASSIGNING FIELD-SYMBOL(<fs_invoices>).

      READ TABLE lt_t016 ASSIGNING FIELD-SYMBOL(<fs_t016>) WITH KEY invoice_number         = <fs_invoices>-invoice_number
                                                                    dbs_invoice_id         = <fs_invoices>-dbs_invoice_id
                                                                    partial_invoice_number = <fs_invoices>-partial_invoice_number.
      IF sy-subrc EQ 0.

        lo_send->delete_invoice(
          EXPORTING
            iv_invoiceno      = CONV string( <fs_t016>-dbs_invoice_id )
          RECEIVING
            rv_delete_invoice = DATA(ls_result)
        ).

*Eğer fatura başarı ile silindiyse fatura ve finteo faturaları tablosunda silindi olarak işaretlenir
        IF ls_result-status EQ 'OK'.

          IF <fs_invoices>-partial_invoice_number IS INITIAL.

            SELECT SINGLE *                   "#EC CI_ALL_FIELDS_NEEDED
              FROM zarete_dbs_t015
              WHERE invoice_number EQ @<fs_invoices>-invoice_number
              AND   id             EQ @<fs_invoices>-id
              INTO @DATA(ls_t015).

            APPEND INITIAL LINE TO lt_t015_update ASSIGNING FIELD-SYMBOL(<fs_t015_update>).
            <fs_t015_update>-InvoiceNumber          = ls_t015-invoice_number.
            <fs_t015_update>-Uuid                   = ls_t015-uuid.
            <fs_t015_update>-Id                     = ls_t015-id.
            <fs_t015_update>-statu                  = '9'.
            <fs_t015_update>-DbsInvoiceId           = ls_t015-dbs_invoice_id.
            <fs_t015_update>-DbsAccountId           = ls_t015-dbs_account_id.
            <fs_t015_update>-IsCancelled            = abap_true.
            <fs_t015_update>-%control-IsCancelled   = if_abap_behv=>mk-on.
            <fs_t015_update>-%control-statu         = if_abap_behv=>mk-on.

          ENDIF.

          APPEND INITIAL LINE TO lt_t016_update ASSIGNING FIELD-SYMBOL(<fs_t016_update>).
          <fs_t016_update>-Identifier                  = <fs_t016>-identifier.
          <fs_t016_update>-DbsInvoiceId                = <fs_t016>-dbs_invoice_id.
          <fs_t016_update>-Id                          = <fs_t016>-id.
          <fs_t016_update>-StatusCode                  = '9'.
          <fs_t016_update>-StatusDescription           = 'İptal Edildi'.
          <fs_t016_update>-Amount                      = 0.
          <fs_t016_update>-DeletedAmount               = <fs_invoices>-amount.
          <fs_t016_update>-%control-StatusCode         = if_abap_behv=>mk-on.
          <fs_t016_update>-%control-StatusDescription  = if_abap_behv=>mk-on.
          <fs_t016_update>-%control-Amount             = if_abap_behv=>mk-on.
          <fs_t016_update>-%control-DeletedAmount      = if_abap_behv=>mk-on.

          <fs_invoices>-message = 'Fatura Geri Alındı'.
          lo_log->set_sapinvoiceno( iv_sapinvoiceno = <fs_invoices>-invoice_number
                                    iv_id           = <fs_invoices>-id
                                    iv_bankcode     = <fs_invoices>-bank_code ).
          lo_log->add_log( msgty = if_abap_behv_message=>severity-success
                           msgno = '006'  ).

        ELSE.

          IF ls_result-statusmessage IS NOT INITIAL.
            <fs_invoices>-message = ls_result-statusmessage.
            lo_log->set_sapinvoiceno( iv_sapinvoiceno = <fs_invoices>-invoice_number
                                      iv_id           = <fs_invoices>-id
                                      iv_bankcode     = <fs_invoices>-bank_code ).
            lo_log->add_log( msgtx = ls_result-statusmessage
                             msgty = if_abap_behv_message=>severity-error
                             msgno = '007'  ).
          ELSE.
            <fs_invoices>-message = 'Fatura Geri Alınamadı'.
            lo_log->set_sapinvoiceno( iv_sapinvoiceno = <fs_invoices>-invoice_number
                                      iv_id           = <fs_invoices>-id
                                      iv_bankcode     = <fs_invoices>-bank_code ).
            lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                             msgno = '007'  ).
          ENDIF.

        ENDIF.

      ELSE.

        <fs_invoices>-message = 'Fatura Geri Alınamadı'.
        lo_log->set_sapinvoiceno( iv_sapinvoiceno = <fs_invoices>-invoice_number
                                  iv_id           = <fs_invoices>-id
                                  iv_bankcode     = <fs_invoices>-bank_code ).
        lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                         msgno = '007'  ).

      ENDIF.

    ENDLOOP.

    MODIFY ENTITIES OF zarete_dbs_dd_t015 ENTITY zarete_dbs_dd_t015
    UPDATE FIELDS ( Statu IsCancelled ) WITH lt_t015_update
    MAPPED DATA(lt_mapped_t015_up)
    FAILED DATA(lt_failed_t015_up)
    REPORTED DATA(lt_reported_t015_up).

    MODIFY ENTITIES OF zarete_dbs_dd_t016 ENTITY zarete_dbs_dd_t016
    UPDATE FIELDS ( StatusCode StatusDescription Amount DeletedAmount ) WITH lt_t016_update
    MAPPED DATA(lt_mapped_t016_up)
    FAILED DATA(lt_failed_t016_up)
    REPORTED DATA(lt_reported_t016_up).

    IF cl_abap_behv_aux=>get_current_handler_kind( ) IS INITIAL.

      COMMIT ENTITIES RESPONSE OF zarete_dbs_dd_t015
      FAILED DATA(lt_failed_t015_co)
      REPORTED DATA(lt_reported_t015_co).

      COMMIT ENTITIES RESPONSE OF zarete_dbs_dd_t016
      FAILED DATA(lt_failed_t016_co)
      REPORTED DATA(lt_reported_t016_co).

    ENDIF.

  ENDMETHOD.


  METHOD get_invoices.

    DATA: lt_t015_create       TYPE TABLE FOR CREATE zarete_dbs_dd_t015,
          lt_t015_update       TYPE TABLE FOR UPDATE zarete_dbs_dd_t015,
          lt_t016_create       TYPE TABLE FOR CREATE zarete_dbs_dd_t016,
          lt_t016_update       TYPE TABLE FOR UPDATE zarete_dbs_dd_t016,
          lt_t017_create       TYPE TABLE FOR CREATE zarete_dbs_dd_t017,
          lt_t017_update       TYPE TABLE FOR UPDATE zarete_dbs_dd_t017,
          lt_filtered_invoices TYPE tt_filtered_invoices,
          lv_error             TYPE c,
          lv_number            TYPE char7.

    DATA lv_has_error TYPE abap_bool VALUE abap_false.

    DATA: lr_types TYPE RANGE OF zarete_dbs_t005-belge_turu.

    DATA(lo_finteo_invoices) = NEW zarete_dbs_sc_finteo_api( ).

*Finteo'dan gelen faturalar
    DATA(lt_finteo_invoices) = lo_finteo_invoices->get_invoice(
                                                   EXPORTING
                                                   iv_startdate         = iv_startdate
                                                   iv_finishdate        = iv_finishdate
                                                   iv_bankid            = iv_bankid
                                                   iv_partycode         = iv_partycode
                                                   iv_identifier        = iv_identifier
                                                   iv_dbsinvoiceid      = iv_dbsinvoiceid
                                                   iv_statuscode        = iv_statuscode
                                                   iv_statusdescription = iv_statusdescription ).

    LOOP AT lt_finteo_invoices-data ASSIGNING FIELD-SYMBOL(<fs_finteo_invoices>).

      SELECT SINGLE *                         "#EC CI_ALL_FIELDS_NEEDED
        FROM zarete_dbs_t016
        WHERE identifier     EQ @<fs_finteo_invoices>-identifier
        AND   dbs_invoice_id EQ @<fs_finteo_invoices>-dbsinvoiceid
        INTO @DATA(ls_t016).

      IF sy-subrc EQ 0.

        APPEND INITIAL LINE TO lt_t016_update ASSIGNING FIELD-SYMBOL(<fs_t016_update>).
        <fs_t016_update>-Identifier                  = ls_t016-identifier.
        <fs_t016_update>-DbsInvoiceId                = ls_t016-dbs_invoice_id.
        IF <fs_finteo_invoices>-duedate IS NOT INITIAL.
          <fs_t016_update>-DueDate                     = <fs_finteo_invoices>-duedate+6(4) && <fs_finteo_invoices>-duedate+3(2) && <fs_finteo_invoices>-duedate+0(2).
        ENDIF.
        IF <fs_finteo_invoices>-transactiondate IS NOT INITIAL.
          <fs_t016_update>-TransactionDate             = <fs_finteo_invoices>-transactiondate+6(4) && <fs_finteo_invoices>-transactiondate+3(2) && <fs_finteo_invoices>-transactiondate+0(2).
        ENDIF.
        <fs_t016_update>-LastPaymentDate             = <fs_finteo_invoices>-lastpaymentdate.
        <fs_t016_update>-PaymentDescription          = <fs_finteo_invoices>-paymentdescription.
        IF <fs_finteo_invoices>-statuscode NE '0'.
          <fs_t016_update>-StatusCode                  = <fs_finteo_invoices>-statuscode.
          <fs_t016_update>-StatusDescription           = <fs_finteo_invoices>-statusdescription.
        ELSE.
          <fs_t016_update>-StatusCode                  = ls_t016-status_code.
          <fs_t016_update>-StatusDescription           = ls_t016-status_description.
        ENDIF.
        <fs_t016_update>-PartyCode                   = |{ <fs_finteo_invoices>-PartyCode ALPHA = OUT }|.
        <fs_t016_update>-PartyTitle                  = <fs_finteo_invoices>-PartyTitle.
        <fs_t016_update>-PartyTaxNumber              = <fs_finteo_invoices>-PartyTaxNumber.
        <fs_t016_update>-BankCode                    = <fs_finteo_invoices>-BankCode.
        <fs_t016_update>-BankName                    = <fs_finteo_invoices>-BankName.
*        <fs_t016_update>-Amount                      = <fs_finteo_invoices>-amount.
        <fs_t016_update>-%control-DueDate            = if_abap_behv=>mk-on.
        <fs_t016_update>-%control-TransactionDate    = if_abap_behv=>mk-on.
        <fs_t016_update>-%control-LastPaymentDate    = if_abap_behv=>mk-on.
        <fs_t016_update>-%control-PaymentDescription = if_abap_behv=>mk-on.
        <fs_t016_update>-%control-PartyCode          = if_abap_behv=>mk-on.
        <fs_t016_update>-%control-PartyTitle         = if_abap_behv=>mk-on.
        <fs_t016_update>-%control-PartyTaxNumber     = if_abap_behv=>mk-on.
        <fs_t016_update>-%control-BankCode           = if_abap_behv=>mk-on.
        <fs_t016_update>-%control-BankName           = if_abap_behv=>mk-on.
*        <fs_t016_update>-%control-Amount             = if_abap_behv=>mk-on.
        <fs_t016_update>-%control-StatusCode         = if_abap_behv=>mk-on.
        <fs_t016_update>-%control-StatusDescription  = if_abap_behv=>mk-on.

        IF <fs_finteo_invoices>-statuscode EQ '9' OR <fs_finteo_invoices>-statuscode EQ '10'.
          <fs_t016_update>-Amount = 0.
          <fs_t016_update>-%control-Amount  = if_abap_behv=>mk-on.
          <fs_t016_update>-DeletedAmount = <fs_finteo_invoices>-amount.
          <fs_t016_update>-%control-DeletedAmount  = if_abap_behv=>mk-on.
        ELSE.
          <fs_t016_update>-Amount = <fs_finteo_invoices>-amount.
          <fs_t016_update>-%control-Amount  = if_abap_behv=>mk-on.
          <fs_t016_update>-DeletedAmount = 0.
          <fs_t016_update>-%control-DeletedAmount  = if_abap_behv=>mk-on.
        ENDIF.

      ELSE.

        APPEND INITIAL LINE TO lt_t016_create ASSIGNING FIELD-SYMBOL(<fs_t016_create>).
        <fs_t016_create>-Identifier                           = <fs_finteo_invoices>-Identifier.
        <fs_t016_create>-DbsInvoiceId                         = <fs_finteo_invoices>-DbsInvoiceId.
        <fs_t016_create>-Amount                               = <fs_finteo_invoices>-Amount.
        <fs_t016_create>-CurrencyCode                         = <fs_finteo_invoices>-CurrencyCode.
        IF <fs_finteo_invoices>-duedate IS NOT INITIAL.
          <fs_t016_create>-DueDate                            = <fs_finteo_invoices>-duedate+6(4) && <fs_finteo_invoices>-duedate+3(2) && <fs_finteo_invoices>-duedate+0(2).
        ENDIF.
        <fs_t016_create>-SendDate                             = cl_abap_context_info=>get_system_date( ).

        IF <fs_finteo_invoices>-InvoiceNumber CA '-'.
          SPLIT <fs_finteo_invoices>-InvoiceNumber AT '-' INTO DATA(lv_invno) DATA(lv_partialno).
          <fs_t016_create>-InvoiceNumber                        = lv_invno.
          <fs_t016_create>-PartialInvoiceNumber                 = <fs_finteo_invoices>-InvoiceNumber..
        ELSE.
          <fs_t016_create>-InvoiceNumber                        = <fs_finteo_invoices>-InvoiceNumber.
        ENDIF.
        <fs_t016_create>-InvoiceAmountDue                     = <fs_finteo_invoices>-InvoiceAmountDue.
        <fs_t016_create>-LastPaymentDate                      = <fs_finteo_invoices>-LastPaymentDate.
        <fs_t016_create>-PartialGuaranteedAmount              = <fs_finteo_invoices>-PartialGuaranteedAmount.
        <fs_t016_create>-AmountRemainingBeforePaymen          = <fs_finteo_invoices>-AmountRemainingBeforePayment.
        <fs_t016_create>-PaymentDescription                   = <fs_finteo_invoices>-PaymentDescription.
        <fs_t016_create>-StatusCode                           = <fs_finteo_invoices>-StatusCode.
        <fs_t016_create>-StatusDescription                    = <fs_finteo_invoices>-StatusDescription.
        IF <fs_finteo_invoices>-transactiondate IS NOT INITIAL.
          <fs_t016_create>-TransactionDate                    = <fs_finteo_invoices>-transactiondate+6(4) && <fs_finteo_invoices>-transactiondate+3(2) && <fs_finteo_invoices>-transactiondate+0(2).
        ENDIF.
        <fs_t016_create>-DbsAccountId                         = <fs_finteo_invoices>-DbsAccountId.
        <fs_t016_create>-PartyCode                            = |{ <fs_finteo_invoices>-PartyCode ALPHA = OUT }|.
        <fs_t016_create>-PartyTitle                           = <fs_finteo_invoices>-PartyTitle.
        <fs_t016_create>-PartyTaxNumber                       = <fs_finteo_invoices>-PartyTaxNumber.
        <fs_t016_create>-BankCode                             = <fs_finteo_invoices>-BankCode.
        <fs_t016_create>-BankName                             = <fs_finteo_invoices>-BankName.
        <fs_t016_create>-%control-Identifier                  = if_abap_behv=>mk-on.
        <fs_t016_create>-%control-DbsInvoiceId                = if_abap_behv=>mk-on.
        <fs_t016_create>-%control-Amount                      = if_abap_behv=>mk-on.
        <fs_t016_create>-%control-CurrencyCode                = if_abap_behv=>mk-on.
        <fs_t016_create>-%control-DueDate                     = if_abap_behv=>mk-on.
        <fs_t016_create>-%control-SendDate                    = if_abap_behv=>mk-on.
        <fs_t016_create>-%control-InvoiceNumber               = if_abap_behv=>mk-on.
        <fs_t016_create>-%control-InvoiceAmountDue            = if_abap_behv=>mk-on.
        <fs_t016_create>-%control-LastPaymentDate             = if_abap_behv=>mk-on.
        <fs_t016_create>-%control-PartialGuaranteedAmount     = if_abap_behv=>mk-on.
        <fs_t016_create>-%control-AmountRemainingBeforePaymen = if_abap_behv=>mk-on.
        <fs_t016_create>-%control-PaymentDescription          = if_abap_behv=>mk-on.
        <fs_t016_create>-%control-StatusCode                  = if_abap_behv=>mk-on.
        <fs_t016_create>-%control-StatusDescription           = if_abap_behv=>mk-on.
        <fs_t016_create>-%control-TransactionDate             = if_abap_behv=>mk-on.
        <fs_t016_create>-%control-DbsAccountId                = if_abap_behv=>mk-on.
        <fs_t016_create>-%control-PartyCode                   = if_abap_behv=>mk-on.
        <fs_t016_create>-%control-PartyTitle                  = if_abap_behv=>mk-on.
        <fs_t016_create>-%control-PartyTaxNumber              = if_abap_behv=>mk-on.
        <fs_t016_create>-%control-BankCode                    = if_abap_behv=>mk-on.
        <fs_t016_create>-%control-BankName                    = if_abap_behv=>mk-on.

*        IF <fs_finteo_invoices>-statuscode EQ '9'.
*          <fs_t016_create>-Amount = 0.
*          <fs_t016_create>-%control-Amount  = if_abap_behv=>mk-on.
*        ENDIF.

      ENDIF.

      DATA: lv_invnumber TYPE zarete_dbs_t015-invoice_number,
            lv_invid     TYPE zarete_dbs_t015-dbs_invoice_id.

*      IF <fs_finteo_invoices>-invoicenumber CA '-'.
*        SPLIT <fs_finteo_invoices>-invoicenumber AT '-' INTO lv_invnumber DATA(lv_partial).
*      ELSE.
      lv_invnumber = <fs_finteo_invoices>-invoicenumber.
*      ENDIF.
      lv_invid     = <fs_finteo_invoices>-dbsinvoiceid.
      SELECT SINGLE * FROM zarete_dbs_t015 WHERE invoice_number EQ @lv_invnumber "#EC CI_ALL_FIELDS_NEEDED
                                           AND   dbs_invoice_id EQ @lv_invid INTO @DATA(ls_t015).
      IF sy-subrc EQ 0.

        APPEND INITIAL LINE TO lt_t015_update ASSIGNING FIELD-SYMBOL(<fs_t015_update>).
        <fs_t015_update>-InvoiceNumber          = ls_t015-invoice_number.
        <fs_t015_update>-Uuid                   = ls_t015-uuid.
        <fs_t015_update>-Id                     = ls_t015-id.
        <fs_t015_update>-statu                  = <fs_finteo_invoices>-statuscode.
        <fs_t015_update>-DbsInvoiceId           = <fs_finteo_invoices>-dbsinvoiceid.
        <fs_t015_update>-DbsAccountId           = <fs_finteo_invoices>-dbsaccountid.
*        <fs_t015_update>-Amount                 = <fs_finteo_invoices>-amount.
        IF <fs_finteo_invoices>-transactiondate IS NOT INITIAL.
          <fs_t015_update>-TransactionDate        = <fs_finteo_invoices>-transactiondate+6(4) && <fs_finteo_invoices>-transactiondate+3(2) && <fs_finteo_invoices>-transactiondate+0(2).
        ENDIF.

        IF <fs_finteo_invoices>-duedate IS NOT INITIAL.
          <fs_t015_update>-DueDate = <fs_finteo_invoices>-duedate+6(4) && <fs_finteo_invoices>-duedate+3(2) && <fs_finteo_invoices>-duedate+0(2).
        ENDIF.
*        <fs_t015_update>-%control-InvoiceNumber = if_abap_behv=>mk-on.
        <fs_t015_update>-%control-statu           = if_abap_behv=>mk-on.
        <fs_t015_update>-%control-DbsInvoiceId    = if_abap_behv=>mk-on.
        <fs_t015_update>-%control-DbsAccountId    = if_abap_behv=>mk-on.
        <fs_t015_update>-%control-TransactionDate = if_abap_behv=>mk-on.
*        <fs_t015_update>-%control-Amount          = if_abap_behv=>mk-on.
        IF <fs_finteo_invoices>-duedate IS NOT INITIAL.
          <fs_t015_update>-%control-DueDate  = if_abap_behv=>mk-on.
        ENDIF.

        IF <fs_finteo_invoices>-statuscode EQ '9' OR <fs_finteo_invoices>-statuscode EQ '10'.

*          DATA(lv_invno) = lv_invnumber && '*'.
*          LOOP AT lt_t016_update ASSIGNING FIELD-SYMBOL(<fs_t016_up>) WHERE InvoiceNumber CP lv_invno
*                                                                      AND   Amount IS NOT INITIAL.
*          ENDLOOP.
*          IF sy-subrc NE 0.
          <fs_t015_update>-IsCancelled = abap_true.
          <fs_t015_update>-%control-IsCancelled  = if_abap_behv=>mk-on.
*          ENDIF.

        ELSE.
          <fs_t015_update>-IsCancelled = abap_false.
          <fs_t015_update>-%control-IsCancelled  = if_abap_behv=>mk-on.
        ENDIF.

      ELSE.
*        "Finteoya manuel fatura yükleme durumunda burada başka bir case oluşur. Faturanın finteoda olması ve sap de olmaması gibi
*        "Bu konu finteo ile konuşulmalı ki kullanıcı manuel fatura yükleyemesin.
*        create_number_range_interval( IMPORTING ev_error = lv_error ).
*        IF lv_error NE abap_true.
*          get_number_next( IMPORTING ev_number = lv_number ).
*        ENDIF.
**
**
*        APPEND INITIAL LINE TO lt_t015_create ASSIGNING FIELD-SYMBOL(<fs_t015_create>).
*        <fs_t015_create>-InvoiceNumber            = <fs_finteo_invoices>-invoicenumber.
*        <fs_t015_create>-Id                       = lv_number.
*        <fs_t015_create>-ScenarioType             = '120-102'.
*        <fs_t015_create>-statu                    = <fs_finteo_invoices>-statusdescription.
*        <fs_t015_create>-DbsInvoiceId             = <fs_finteo_invoices>-dbsinvoiceid.
*        <fs_t015_create>-DbsAccountId             = <fs_finteo_invoices>-dbsaccountid.
*        <fs_t015_create>-Amount                   = <fs_finteo_invoices>-amount.
*        IF <fs_finteo_invoices>-transactiondate IS NOT INITIAL.
*          <fs_t015_create>-TransactionDate          = <fs_finteo_invoices>-transactiondate+6(4) && <fs_finteo_invoices>-transactiondate+3(2) && <fs_finteo_invoices>-transactiondate+0(2).
*        ENDIF.
*        IF <fs_finteo_invoices>-duedate IS NOT INITIAL.
*          <fs_t015_create>-DueDate          = <fs_finteo_invoices>-duedate+6(4) && <fs_finteo_invoices>-duedate+3(2) && <fs_finteo_invoices>-duedate+0(2).
*          <fs_t015_create>-%control-DueDate = if_abap_behv=>mk-on.
*        ENDIF.
*        <fs_t015_create>-%control-InvoiceNumber   = if_abap_behv=>mk-on.
*        <fs_t015_create>-%control-Id              = if_abap_behv=>mk-on.
*        <fs_t015_create>-%control-ScenarioType    = if_abap_behv=>mk-on.
*        <fs_t015_create>-%control-statu           = if_abap_behv=>mk-on.
*        <fs_t015_create>-%control-DbsInvoiceId    = if_abap_behv=>mk-on.
*        <fs_t015_create>-%control-DbsAccountId    = if_abap_behv=>mk-on.
*        <fs_t015_create>-%control-TransactionDate = if_abap_behv=>mk-on.
*        <fs_t015_create>-%control-Amount          = if_abap_behv=>mk-on.
*        IF <fs_finteo_invoices>-statuscode EQ '9'.
*          <fs_t015_create>-IsCancelled = abap_true.
*          <fs_t015_create>-%control-IsCancelled  = if_abap_behv=>mk-on.
*        ENDIF.
      ENDIF.

    ENDLOOP.

    MODIFY ENTITIES OF zarete_dbs_dd_t015 ENTITY zarete_dbs_dd_t015
    CREATE AUTO FILL CID WITH lt_t015_create
    MAPPED DATA(lt_mapped_t015_cr)
    FAILED DATA(lt_failed_t015_cr)
    REPORTED DATA(lt_reported_t015_cr).

    MODIFY ENTITIES OF zarete_dbs_dd_t015 ENTITY zarete_dbs_dd_t015
    UPDATE FIELDS ( Statu DbsAccountId DbsInvoiceId TransactionDate DueDate IsCancelled ) WITH lt_t015_update
    MAPPED DATA(lt_mapped_t015_up)
    FAILED DATA(lt_failed_t015_up)
    REPORTED DATA(lt_reported_t015_up).

    CLEAR: lt_t015_create, lt_t015_update.

    IF cl_abap_behv_aux=>get_current_handler_kind( ) IS INITIAL.
      COMMIT ENTITIES RESPONSE OF zarete_dbs_dd_t015
      FAILED DATA(lt_failed_t015_co)
      REPORTED DATA(lt_reported_t015_co).
    ENDIF.

    MODIFY ENTITIES OF zarete_dbs_dd_t016 ENTITY zarete_dbs_dd_t016
    CREATE AUTO FILL CID WITH lt_t016_create
    MAPPED DATA(lt_mapped_t016_cr)
    FAILED DATA(lt_failed_t016_cr)
    REPORTED DATA(lt_reported_t016_cr).

    MODIFY ENTITIES OF zarete_dbs_dd_t016 ENTITY zarete_dbs_dd_t016
    UPDATE FIELDS ( DueDate LastPaymentDate PaymentDescription StatusCode
                    StatusDescription PartyCode PartyTitle PartyTaxNumber
                    BankCode BankName TransactionDate Amount DeletedAmount )
    WITH lt_t016_update
    MAPPED DATA(lt_mapped_t016_up)
    FAILED DATA(lt_failed_t016_up)
    REPORTED DATA(lt_reported_t016_up).


    CLEAR: lt_t015_create, lt_t015_update,lv_error, lv_number.
    IF cl_abap_behv_aux=>get_current_handler_kind( ) IS INITIAL.
      COMMIT ENTITIES RESPONSE OF zarete_dbs_dd_t016
      FAILED DATA(lt_failed_t016_co)
      REPORTED DATA(lt_reported_t016_co).
    ENDIF.

*SAP'den gelen faturalar

    DATA lt_keys TYPE TABLE FOR READ IMPORT zarete_dbs_dd_doc_read_001.

    SELECT belge_turu                                   "#EC CI_NOWHERE
      FROM zarete_dbs_t005
      INTO TABLE @DATA(lt_t005).

    lt_keys = VALUE #( FOR ls_t005 IN lt_t005 (
                         %key-accounting_document_type = ls_t005-belge_turu
                       ) ).

*    READ ENTITIES OF zarete_dbs_dd_doc_read_001
*    ENTITY zarete_dbs_dd_doc_read_001
*    ALL FIELDS WITH VALUE #( (  ) )
*    RESULT DATA(lt_sap_invoices).

    READ ENTITIES OF zarete_dbs_dd_doc_read_001
          ENTITY zarete_dbs_dd_doc_read_001
          ALL FIELDS WITH lt_keys
          RESULT DATA(lt_sap_invoices).

    LOOP AT lt_t005 ASSIGNING FIELD-SYMBOL(<fs_t005>).
      APPEND VALUE #( sign = 'I' option = 'EQ' low = <fs_t005>-belge_turu ) TO lr_types.
    ENDLOOP.

    DELETE lt_sap_invoices WHERE debit_credit_code NE 'S'.
    DELETE lt_sap_invoices WHERE customer IS INITIAL.
    DELETE lt_sap_invoices WHERE document_reference_id IS INITIAL.
    DELETE lt_sap_invoices WHERE document_reference_id EQ '0000000000000000'.
    DELETE lt_sap_invoices WHERE accounting_document_type NOT IN lr_types.

    DELETE lt_sap_invoices WHERE ( customer = '9000'
                              OR   customer = '9001' ).

    DATA : lv_kunnr TYPE kunnr .

    lv_kunnr = |{ '9000' ALPHA = IN }|.
    DELETE lt_sap_invoices WHERE customer = lv_kunnr.
    lv_kunnr = |{ '9001' ALPHA = IN }|.
    DELETE lt_sap_invoices WHERE customer = lv_kunnr.

    DATA(lt_duedate_update) =  lt_sap_invoices.
    DATA(lt_tk_kontrol) =  lt_sap_invoices.
    DELETE lt_tk_kontrol WHERE is_reversed NE abap_true.
*Gelen faturalara denkleştirme kontrolü yapılır
    lt_filtered_invoices = CORRESPONDING #( lt_sap_invoices ).
    filter_invoices( CHANGING ct_invoices = lt_filtered_invoices ).
    lt_sap_invoices = CORRESPONDING #( lt_filtered_invoices ).

    DATA : lv_buzei TYPE buzei.

    LOOP AT lt_sap_invoices ASSIGNING FIELD-SYMBOL(<fs_sap_invoices>).

      SELECT SINGLE *                         "#EC CI_ALL_FIELDS_NEEDED
        FROM zarete_dbs_t017
        WHERE company_code             EQ @<fs_sap_invoices>-company_code
        AND   fiscal_year              EQ @<fs_sap_invoices>-fiscal_year
        AND   accounting_document      EQ @<fs_sap_invoices>-accounting_document
        AND   accounting_document_item EQ @<fs_sap_invoices>-accounting_document_item
*        AND   document_reference_id    EQ @<fs_sap_invoices>-document_reference_id
        INTO @DATA(ls_t017).

      IF sy-subrc EQ 0.

        APPEND INITIAL LINE TO lt_t017_update ASSIGNING FIELD-SYMBOL(<fs_t017_update>).
        <fs_t017_update>-CompanyCode                      = ls_t017-company_code.
        <fs_t017_update>-FiscalYear                       = ls_t017-fiscal_year.
        <fs_t017_update>-AccountingDocument               = ls_t017-accounting_document.
        <fs_t017_update>-AccountingDocumentItem           = ls_t017-accounting_document_item.
        <fs_t017_update>-DocumentReferenceId              = ls_t017-document_reference_id.
        <fs_t017_update>-DocumentItemText                 = <fs_sap_invoices>-document_item_text.
        <fs_t017_update>-CustomerName                     = <fs_sap_invoices>-customer_name.
        <fs_t017_update>-ClearingAccountingDocume         = <fs_sap_invoices>-clearing_accounting_docume.
        <fs_t017_update>-ClearingDocFiscalYear            = <fs_sap_invoices>-clearing_doc_fiscal_year.
        <fs_t017_update>-AccountingDocumentType           = <fs_sap_invoices>-accounting_document_type.
        <fs_t017_update>-NetDueDate                       = <fs_sap_invoices>-net_due_date.
        <fs_t017_update>-%control-DocumentItemText        = if_abap_behv=>mk-on.
        <fs_t017_update>-%control-CustomerName            = if_abap_behv=>mk-on.
        <fs_t017_update>-%control-ClearingAccountingDocume = if_abap_behv=>mk-on.
        <fs_t017_update>-%control-ClearingDocFiscalYear    = if_abap_behv=>mk-on.
        <fs_t017_update>-%control-AccountingDocumentType   = if_abap_behv=>mk-on.
        <fs_t017_update>-%control-NetDueDate               = if_abap_behv=>mk-on.

      ELSE.

        CLEAR lv_buzei.
        lv_buzei = |{ <fs_sap_invoices>-accounting_document_item ALPHA = IN  }|.

        APPEND INITIAL LINE TO lt_t017_create ASSIGNING FIELD-SYMBOL(<fs_t017_create>).
        <fs_t017_create>-CompanyCode                      = <fs_sap_invoices>-company_code.
        <fs_t017_create>-FiscalYear                       = <fs_sap_invoices>-fiscal_year.
        <fs_t017_create>-AccountingDocument               = <fs_sap_invoices>-accounting_document.
        <fs_t017_create>-AccountingDocumentItem           = lv_buzei.
        <fs_t017_create>-DocumentReferenceId              = <fs_sap_invoices>-document_reference_id.
        <fs_t017_create>-DebitCreditCode                  = <fs_sap_invoices>-debit_credit_code.
        <fs_t017_create>-DocumentItemText                 = <fs_sap_invoices>-document_item_text.
        <fs_t017_create>-Customer                         = |{ <fs_sap_invoices>-customer ALPHA = OUT }|.
        <fs_t017_create>-CustomerName                     = <fs_sap_invoices>-customer_name.
        <fs_t017_create>-PostingDate                      = <fs_sap_invoices>-posting_date.
        <fs_t017_create>-DocumentDate                     = <fs_sap_invoices>-document_date.
        <fs_t017_create>-NetDueDate                       = <fs_sap_invoices>-net_due_date.
        <fs_t017_create>-ValueDate                        = <fs_sap_invoices>-value_date.
        <fs_t017_create>-HouseBank                        = <fs_sap_invoices>-house_bank.
        <fs_t017_create>-AccountingDocumentType           = <fs_sap_invoices>-accounting_document_type.
        <fs_t017_create>-AmountInTransactionCurr          = abs( <fs_sap_invoices>-amount_in_transaction_curr ).
        <fs_t017_create>-TransactionCurrency              = <fs_sap_invoices>-transaction_currency.
        <fs_t017_create>-AssignmentReference              = <fs_sap_invoices>-assignment_reference.
        <fs_t017_create>-ClearingAccountingDocume         = <fs_sap_invoices>-clearing_accounting_docume.
        <fs_t017_create>-ClearingDocFiscalYear            = <fs_sap_invoices>-clearing_doc_fiscal_year.
        <fs_t017_create>-%control-CompanyCode             = if_abap_behv=>mk-on.
        <fs_t017_create>-%control-FiscalYear              = if_abap_behv=>mk-on.
        <fs_t017_create>-%control-AccountingDocument      = if_abap_behv=>mk-on.
        <fs_t017_create>-%control-AccountingDocumentItem  = if_abap_behv=>mk-on.
        <fs_t017_create>-%control-DocumentReferenceId     = if_abap_behv=>mk-on.
        <fs_t017_create>-%control-DebitCreditCode         = if_abap_behv=>mk-on.
        <fs_t017_create>-%control-DocumentItemText        = if_abap_behv=>mk-on.
        <fs_t017_create>-%control-Customer                = if_abap_behv=>mk-on.
        <fs_t017_create>-%control-CustomerName            = if_abap_behv=>mk-on.
        <fs_t017_create>-%control-PostingDate             = if_abap_behv=>mk-on.
        <fs_t017_create>-%control-DocumentDate            = if_abap_behv=>mk-on.
        <fs_t017_create>-%control-NetDueDate              = if_abap_behv=>mk-on.
        <fs_t017_create>-%control-ValueDate               = if_abap_behv=>mk-on.
        <fs_t017_create>-%control-HouseBank               = if_abap_behv=>mk-on.
        <fs_t017_create>-%control-AccountingDocumentType  = if_abap_behv=>mk-on.
        <fs_t017_create>-%control-AmountInTransactionCurr = if_abap_behv=>mk-on.
        <fs_t017_create>-%control-TransactionCurrency     = if_abap_behv=>mk-on.
        <fs_t017_create>-%control-AssignmentReference     = if_abap_behv=>mk-on.
        <fs_t017_create>-%control-ClearingAccountingDocume = if_abap_behv=>mk-on.
        <fs_t017_create>-%control-ClearingDocFiscalYear   = if_abap_behv=>mk-on.

      ENDIF.

      CLEAR lv_buzei.
      lv_buzei = |{ <fs_sap_invoices>-accounting_document_item ALPHA = IN  }|.


      SELECT SINGLE *
        FROM zarete_dbs_t015
        WHERE invoice_acc_doc EQ @<fs_sap_invoices>-accounting_document
        AND   invoice_acc_doc_item EQ @lv_buzei
        INTO @ls_t015.                        "#EC CI_ALL_FIELDS_NEEDED
      IF sy-subrc EQ 0.

        APPEND INITIAL LINE TO lt_t015_update ASSIGNING <fs_t015_update>.
        <fs_t015_update>-InvoiceNumber        = ls_t015-invoice_number.
        <fs_t015_update>-Uuid                 = ls_t015-uuid.
        <fs_t015_update>-Id                   = ls_t015-id.
*        <fs_t015_update>-Amount               = <fs_sap_invoices>-amount_in_transaction_curr.
*        <fs_t015_update>-%control-Amount      = if_abap_behv=>mk-on.
        IF <fs_sap_invoices>-net_due_date IS NOT INITIAL.
          <fs_t015_update>-DueDate = <fs_sap_invoices>-net_due_date.
          <fs_t015_update>-%control-DueDate = if_abap_behv=>mk-on.
        ENDIF.

        READ TABLE lt_finteo_invoices-data ASSIGNING <fs_finteo_invoices> WITH KEY invoicenumber = <fs_sap_invoices>-document_reference_id.
        IF sy-subrc EQ 0.
          <fs_t015_update>-statu                  = <fs_finteo_invoices>-statusdescription.
          <fs_t015_update>-DbsInvoiceId           = <fs_finteo_invoices>-dbsinvoiceid.
          <fs_t015_update>-DbsAccountId           = <fs_finteo_invoices>-dbsaccountid.
          <fs_t015_update>-%control-statu         = if_abap_behv=>mk-on.
          <fs_t015_update>-%control-DbsInvoiceId  = if_abap_behv=>mk-on.
          <fs_t015_update>-%control-DbsAccountId  = if_abap_behv=>mk-on.

        ELSE.

          <fs_t015_update>-statu                  = ls_t015-statu.
          <fs_t015_update>-DbsInvoiceId           = ls_t015-dbs_invoice_id.
          <fs_t015_update>-DbsAccountId           = ls_t015-dbs_account_id.
          <fs_t015_update>-%control-statu         = if_abap_behv=>mk-on.
          <fs_t015_update>-%control-DbsInvoiceId  = if_abap_behv=>mk-on.
          <fs_t015_update>-%control-DbsAccountId  = if_abap_behv=>mk-on.

        ENDIF.

      ELSE.

        CLEAR lv_buzei.
        lv_buzei = |{ <fs_sap_invoices>-accounting_document_item ALPHA = IN  }|.

        create_number_range_interval( IMPORTING ev_error = lv_error ).
        IF lv_error NE abap_true.
          get_number_next( IMPORTING ev_number = lv_number ).
        ENDIF.

        APPEND INITIAL LINE TO lt_t015_create ASSIGNING FIELD-SYMBOL(<fs_t015_create>).
        <fs_t015_create>-InvoiceNumber            = <fs_sap_invoices>-document_reference_id.
        <fs_t015_create>-InvoiceAccDoc            = <fs_sap_invoices>-accounting_document.
        <fs_t015_create>-InvoiceAccDocItem        = lv_buzei.
        <fs_t015_create>-Id                       = lv_number.
        <fs_t015_create>-TransactionDate          = <fs_sap_invoices>-document_date.
        <fs_t015_create>-DueDate                  = <fs_sap_invoices>-net_due_date.
        <fs_t015_create>-ScenarioType             = '120-102'.
        <fs_t015_create>-Amount                   = <fs_sap_invoices>-amount_in_transaction_curr.
        <fs_t015_create>-%control-InvoiceNumber   = if_abap_behv=>mk-on.
        <fs_t015_create>-%control-InvoiceAccDoc   = if_abap_behv=>mk-on.
        <fs_t015_create>-%control-InvoiceAccDocItem = if_abap_behv=>mk-on.
        <fs_t015_create>-%control-Id              = if_abap_behv=>mk-on.
        <fs_t015_create>-%control-ScenarioType    = if_abap_behv=>mk-on.
        <fs_t015_create>-%control-TransactionDate = if_abap_behv=>mk-on.
        <fs_t015_create>-%control-DueDate         = if_abap_behv=>mk-on.
        <fs_t015_create>-%control-Amount          = if_abap_behv=>mk-on.

        READ TABLE lt_finteo_invoices-data ASSIGNING <fs_finteo_invoices> WITH KEY invoicenumber = <fs_sap_invoices>-document_reference_id.
        IF sy-subrc EQ 0.
          <fs_t015_create>-statu                  = <fs_finteo_invoices>-statusdescription.
          <fs_t015_create>-DbsInvoiceId           = <fs_finteo_invoices>-dbsinvoiceid.
          <fs_t015_create>-DbsAccountId           = <fs_finteo_invoices>-dbsaccountid.
          <fs_t015_create>-%control-statu         = if_abap_behv=>mk-on.
          <fs_t015_create>-%control-DbsInvoiceId  = if_abap_behv=>mk-on.
          <fs_t015_create>-%control-DbsAccountId  = if_abap_behv=>mk-on.
        ENDIF.

      ENDIF.

    ENDLOOP.

**Eğer SAP sisteminde net vade tarihi güncellendiyse sap faturaları tablosundaki tarihten farklı olacaktır
**Bu sebeple Finteo'ya net vade tarihinin güncel hali iletilmelidir
    LOOP AT lt_duedate_update ASSIGNING FIELD-SYMBOL(<fs_update>).  "##LOOP_ASSIGN

      SELECT SINGLE *
         FROM zarete_dbs_t017
         WHERE company_code             EQ @<fs_update>-company_code
         AND   fiscal_year              EQ @<fs_update>-fiscal_year
         AND   accounting_document      EQ @<fs_update>-accounting_document
         AND   accounting_document_item EQ @<fs_update>-accounting_document_item
         AND   document_reference_id    EQ @<fs_update>-document_reference_id
         INTO @ls_t017.

      IF sy-subrc EQ 0.

        READ TABLE lt_duedate_update ASSIGNING FIELD-SYMBOL(<fs_update2>) WITH KEY company_code = ls_t017-company_code
                                                                                   fiscal_year  = ls_t017-fiscal_year
                                                                                   accounting_document = ls_t017-accounting_document
                                                                                   accounting_document_item = ls_t017-accounting_document_item.

        IF sy-subrc EQ 0.
          IF ls_t017-net_due_date NE <fs_update2>-net_due_date.

            UPDATE zarete_dbs_t017
                  SET net_due_date = @<fs_update2>-net_due_date
                  WHERE accounting_document = @ls_t017-accounting_document
                  AND   company_code = @ls_t017-company_code
                  AND   fiscal_year = @ls_t017-fiscal_year.

            update_due_date( iv_invoice_number = ls_t017-document_reference_id
                             iv_due_date       = CONV string( <fs_update2>-net_due_date ) ).
          ENDIF.

        ENDIF.

      ENDIF.

    ENDLOOP.

*Denkleştirmeye Uygun Belgelerin Doldurulması
*    get_documents_for_clearing( ).

    IF lt_t015_create IS NOT INITIAL.
      SORT lt_t015_create BY InvoiceNumber Id.
      DELETE ADJACENT DUPLICATES FROM lt_t015_create COMPARING InvoiceNumber Id.
    ENDIF.

    IF lt_t015_update IS NOT INITIAL.
      SORT lt_t015_update BY InvoiceNumber Id.
      DELETE ADJACENT DUPLICATES FROM lt_t015_update COMPARING InvoiceNumber Id.
    ENDIF.

    MODIFY ENTITIES OF zarete_dbs_dd_t015 ENTITY zarete_dbs_dd_t015
    CREATE AUTO FILL CID WITH lt_t015_create
    MAPPED DATA(lt_mapped_t015_2_cr)
    FAILED DATA(lt_failed_t015_2_cr)
    REPORTED DATA(lt_reported_t015_2_cr).

    LOOP AT lt_reported_t015_2_cr-zarete_dbs_dd_t015 INTO DATA(ls_rep_t015_cr) WHERE %msg IS BOUND.
      add_log_text( iv_text = ls_rep_t015_cr-%msg->if_message~get_text( ) iv_severity = if_bali_constants=>c_severity_error ).
      lv_has_error = abap_true.
    ENDLOOP.


    MODIFY ENTITIES OF zarete_dbs_dd_t015 ENTITY zarete_dbs_dd_t015
    UPDATE FIELDS ( Statu DbsAccountId DbsInvoiceId DueDate ) WITH lt_t015_update
    MAPPED DATA(lt_mapped_t015_2_up)
    FAILED DATA(lt_failed_t015_2_up)
    REPORTED DATA(lt_reported_t015_2_up).

    LOOP AT lt_reported_t015_2_up-zarete_dbs_dd_t015 INTO DATA(ls_rep_t015_up) WHERE %msg IS BOUND.
      add_log_text( iv_text = ls_rep_t015_up-%msg->if_message~get_text( ) iv_severity = if_bali_constants=>c_severity_error ).
      lv_has_error = abap_true.
    ENDLOOP.

    IF cl_abap_behv_aux=>get_current_handler_kind( ) IS INITIAL.
      COMMIT ENTITIES RESPONSE OF zarete_dbs_dd_t015
      FAILED DATA(lt_failed_t015_2_co)
      REPORTED DATA(lt_reported_t015_2_co).

    ENDIF.

    MODIFY ENTITIES OF zarete_dbs_dd_t017 ENTITY zarete_dbs_dd_t017
    CREATE AUTO FILL CID WITH lt_t017_create
    MAPPED DATA(lt_mapped_t017_cr)
    FAILED DATA(lt_failed_t017_cr)
    REPORTED DATA(lt_reported_t017_cr).

    LOOP AT lt_reported_t017_cr-zarete_dbs_dd_t017 INTO DATA(ls_rep_t017_cr) WHERE %msg IS BOUND.
      add_log_text( iv_text = ls_rep_t017_cr-%msg->if_message~get_text( ) iv_severity = if_bali_constants=>c_severity_error ).
      lv_has_error = abap_true.
    ENDLOOP.


    MODIFY ENTITIES OF zarete_dbs_dd_t017 ENTITY zarete_dbs_dd_t017
    UPDATE FIELDS (  DocumentItemText NetDueDate CustomerName  AccountingDocumentType ) WITH lt_t017_update
    MAPPED DATA(lt_mapped_t017_up)
    FAILED DATA(lt_failed_t017_up)
    REPORTED DATA(lt_reported_t017_up).

    LOOP AT lt_reported_t017_up-zarete_dbs_dd_t017 INTO DATA(ls_rep_t017_up) WHERE %msg IS BOUND.
      add_log_text( iv_text = ls_rep_t017_up-%msg->if_message~get_text( ) iv_severity = if_bali_constants=>c_severity_error ).
      lv_has_error = abap_true.
    ENDLOOP.


    IF cl_abap_behv_aux=>get_current_handler_kind( ) IS INITIAL.
      COMMIT ENTITIES RESPONSE OF zarete_dbs_dd_t017
      FAILED DATA(lt_failed_t017_co)
      REPORTED DATA(lt_reported_t017_co).                "#EC CI_VALPAR
    ENDIF.

    IF  lv_has_error = abap_true.
      add_log_text( iv_text = |Hata!.|
                iv_severity = if_bali_constants=>c_severity_error ).

    ELSE.
      add_log_text( iv_text = |Finteo faturaları: { lines( lt_finteo_invoices-data ) } kayıt işlendi. | &&
                              |SAP faturaları: { lines( lt_sap_invoices ) } kayıt işlendi.|
                iv_severity = if_bali_constants=>c_severity_status ).
    ENDIF.

    LOOP AT lt_tk_kontrol ASSIGNING FIELD-SYMBOL(<fs_tk_kontrol>).

      SELECT SINGLE *                         "#EC CI_ALL_FIELDS_NEEDED
        FROM zarete_dbs_t017
        WHERE accounting_document EQ @<fs_tk_kontrol>-accounting_document
        AND  accounting_document_item EQ @<fs_tk_kontrol>-accounting_document_item
        INTO @DATA(ls_t017_tk).
      IF sy-subrc EQ 0.
        SELECT SINGLE *                       "#EC CI_ALL_FIELDS_NEEDED
          FROM zarete_dbs_t015
          WHERE invoice_acc_doc EQ @ls_t017_tk-accounting_document
          AND   invoice_acc_doc_item EQ @ls_t017_tk-accounting_document_item
          AND   invoice_number EQ @ls_t017_tk-document_reference_id
          INTO @DATA(ls_t015_tk).
        IF sy-subrc EQ 0.
          ls_t015_tk-amount = 0.
          MODIFY zarete_dbs_t015 FROM @ls_t015_tk.
          COMMIT WORK AND WAIT.
        ENDIF.
      ENDIF.

    ENDLOOP.

*    SELECT *
*     FROM zarete_dbs_t015
*     WHERE invoice_acc_doc IS NOT INITIAL
*     INTO TABLE @DATA(lt_t015).
*    IF sy-subrc EQ 0.
*
*      SELECT *                                     "#EC CI_NO_TRANSFORM
*      FROM zarete_dbs_t016
*      FOR ALL ENTRIES IN @lt_t015
*      WHERE dbs_invoice_id EQ @lt_t015-dbs_invoice_id
*      AND id IS INITIAL
*      INTO TABLE @DATA(lt_t016).              "#EC CI_ALL_FIELDS_NEEDED
*
*    ENDIF.
*
*    LOOP AT lt_t016 ASSIGNING FIELD-SYMBOL(<fs_t016>).
*
*      READ TABLE lt_t015 ASSIGNING FIELD-SYMBOL(<fs_t015>) WITH KEY dbs_invoice_id = <fs_t016>-dbs_invoice_id.
*      IF sy-subrc EQ 0.
*
*        <fs_t016>-id = <fs_t015>-id.
*        MODIFY zarete_dbs_t016 FROM @<fs_t016>.
*        COMMIT WORK AND WAIT.
*
*      ENDIF.
*
*    ENDLOOP.


  ENDMETHOD.                                             "#EC CI_VALPAR


  METHOD get_number_next.

*    SELECT MAX( id ) FROM zarete_dbs_t015 INTO @DATA(lv_max_id).
*
*    ev_number = lv_max_id + 1.

    TRY.
        cl_numberrange_runtime=>number_get( EXPORTING nr_range_nr = '01' object = 'ZDBS_ID' quantity = 0000001
                                            IMPORTING number = DATA(lv_number) ).
        SHIFT lv_number LEFT DELETING LEADING '0'.
        ev_number = lv_number.
      CATCH cx_nr_object_not_found INTO DATA(cx_nr_object_not_found).
        DATA(lv_object_not_found) = cx_nr_object_not_found->get_longtext(  ).
      CATCH cx_number_ranges INTO DATA(cx_number_ranges).
        DATA(lv_number_ranges) = cx_number_ranges->get_longtext(  ).
      CATCH cx_root INTO DATA(cx_root).
        DATA(lv_root) = cx_root->get_longtext(  ).
    ENDTRY.

  ENDMETHOD.


  METHOD journal_entry_create.

    DATA(lo_log) = zarete_dbs_cl_log=>get_factory( ).

    CLEAR: ev_document_number,ev_fiscal_year,ev_company_code.

    DATA ls_mesaj TYPE REF TO if_abap_behv_message.
    TRY.
        DATA(destination) = cl_soap_destination_provider=>create_by_comm_arrangement(
          comm_scenario = 'ZARETE_DBS_CS_S4HANA'
          service_id    = 'ZARETE_DBS_JOURNAL_ENTRY_SPRX' ).
        DATA(proxy) = NEW zarete_dbs_co_journal_entry_cr( destination = destination ).
        DATA(ls_request) = VALUE zarete_dbs_journal_entry_bulk( ).

        MOVE-CORRESPONDING is_request TO ls_request.

        proxy->journal_entry_create_request_c( EXPORTING input  = ls_request
                                               IMPORTING output = DATA(ls_response) ).

        LOOP AT ls_response-journal_entry_bulk_create_conf-journal_entry_create_confirmat INTO DATA(ls_journal).

          IF ls_journal-journal_entry_create_confirmat-accounting_document NE '0000000000' AND
             ls_journal-journal_entry_create_confirmat-accounting_document IS NOT INITIAL .
            IF lines( ls_response-journal_entry_bulk_create_conf-journal_entry_create_confirmat ) EQ 1.

              ev_document_number = ls_journal-journal_entry_create_confirmat-accounting_document .
              ev_fiscal_year     = ls_journal-journal_entry_create_confirmat-fiscal_year .
              ev_company_code    = ls_journal-journal_entry_create_confirmat-company_code .

            ENDIF.

            APPEND VALUE #(
            reference_id        = ls_journal-message_header-reference_id-content
            accounting_document = ls_journal-journal_entry_create_confirmat-accounting_document
            company_code        = ls_journal-journal_entry_create_confirmat-company_code
            fiscal_year         = ls_journal-journal_entry_create_confirmat-fiscal_year
            ) TO et_fi_documents.

          ENDIF.

          LOOP AT ls_journal-log-item INTO DATA(ls_log).
            IF ls_log-severity_code > 1.
              DATA(lv_error_msj) = ls_log-note.

              lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                               msgtx = CONV #( lv_error_msj ) ).

              ls_mesaj = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                text     = ls_log-note ).

              APPEND ls_mesaj TO et_message.

            ENDIF.
          ENDLOOP.

        ENDLOOP.

      CATCH cx_soap_destination_error INTO DATA(lc_cx).
        lv_error_msj = lc_cx->get_longtext(  ).

        lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                         msgno = lc_cx->if_t100_message~t100key-msgno
                         msgid = lc_cx->if_t100_message~t100key-msgid
                         msgv1 = lc_cx->if_t100_dyn_msg~msgv1
                         msgv2 = lc_cx->if_t100_dyn_msg~msgv2
                         msgv3 = lc_cx->if_t100_dyn_msg~msgv3
                         msgv4 = lc_cx->if_t100_dyn_msg~msgv4
                         msgtx = CONV #( lv_error_msj ) ).

      CATCH cx_ai_system_fault INTO DATA(lc_cx_fault).
        lv_error_msj = lc_cx_fault->get_longtext(  ).

        lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                         msgtx = CONV #( lv_error_msj ) ).
    ENDTRY.

  ENDMETHOD.


  METHOD journal_entry_test_mode.

    DATA(lo_log) = zarete_dbs_cl_log=>get_factory( ).
    DATA ls_mesaj TYPE REF TO if_abap_behv_message.
    TRY.
        DATA(destination) = cl_soap_destination_provider=>create_by_comm_arrangement(
          comm_scenario = 'ZARETE_DBS_CS_S4HANA'
          service_id    = 'ZARETE_DBS_FI_SPRX' ).
        DATA(proxy) = NEW zarete_dbs_co_journal_entry_cr( destination = destination ).
        DATA(ls_request) = VALUE zarete_dbs_journal_entry_bulk( ).

        MOVE-CORRESPONDING is_request TO ls_request.

        ls_request-journal_entry_bulk_create_requ-message_header-test_data_indicator = 'X'.

        LOOP AT ls_request-journal_entry_bulk_create_requ-journal_entry_create_request ASSIGNING FIELD-SYMBOL(<fs_doc>).
          <fs_doc>-message_header-test_data_indicator = 'X'.
        ENDLOOP.


        proxy->journal_entry_create_request_c( EXPORTING input  = ls_request
                                               IMPORTING output = DATA(ls_response) ).

        LOOP AT ls_response-journal_entry_bulk_create_conf-journal_entry_create_confirmat INTO DATA(ls_journal).

          LOOP AT ls_journal-log-item INTO DATA(ls_log).
            IF ls_log-severity_code > 1.
              DATA(lv_error_msj) = ls_log-note.

              lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                               msgtx = CONV #( lv_error_msj ) ).

              ls_mesaj = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                text     = ls_log-note ).

              APPEND ls_mesaj TO et_message.

            ENDIF.
          ENDLOOP.

        ENDLOOP.

      CATCH cx_soap_destination_error INTO DATA(lc_cx).
        lv_error_msj = lc_cx->get_longtext(  ).

        lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                         msgno = lc_cx->if_t100_message~t100key-msgno
                         msgid = lc_cx->if_t100_message~t100key-msgid
                         msgv1 = lc_cx->if_t100_dyn_msg~msgv1
                         msgv2 = lc_cx->if_t100_dyn_msg~msgv2
                         msgv3 = lc_cx->if_t100_dyn_msg~msgv3
                         msgv4 = lc_cx->if_t100_dyn_msg~msgv4
                         msgtx = CONV #( lv_error_msj ) ).

      CATCH cx_ai_system_fault INTO DATA(lc_cx_fault).
        lv_error_msj = lc_cx_fault->get_longtext(  ).

        lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                         msgtx = CONV #( lv_error_msj ) ).
    ENDTRY.

  ENDMETHOD.


  METHOD run.

    DATA(lo_log) = zarete_dbs_cl_log=>get_factory(  ).

  ENDMETHOD.


  METHOD send_invoice.

    DATA: lv_error                  TYPE c,
          lv_number                 TYPE char7,
          lv_invoice_number         TYPE zarete_dbs_t016-partial_invoice_number,
          lv_partial_invoice_number TYPE zarete_dbs_t016-partial_invoice_number,
          lt_limit                  TYPE zarete_dbs_sc_finteo_api=>ty_limit,
          lv_inv                    TYPE zarete_dbs_t016-partial_invoice_number,
          lv_partial                TYPE n LENGTH 2.

    DATA: lt_t015_create TYPE TABLE FOR CREATE zarete_dbs_dd_t015,
          lt_t015_update TYPE TABLE FOR UPDATE zarete_dbs_dd_t015,
          lt_t016_create TYPE TABLE FOR CREATE zarete_dbs_dd_t016,
          lt_t016_update TYPE TABLE FOR UPDATE zarete_dbs_dd_t016.

    DATA(lo_send) = NEW zarete_dbs_sc_finteo_api( ).
    DATA(lo_log) = zarete_dbs_cl_log=>get_factory( ).

    "Fatura parçalanırken ID dolmaması durumunda fatura numarasından alınır
    LOOP AT ct_invoices ASSIGNING FIELD-SYMBOL(<fs_id>) WHERE id IS NOT INITIAL.
      LOOP AT ct_invoices ASSIGNING FIELD-SYMBOL(<fs_id2>) WHERE invoice_number = <fs_id>-invoice_number
                                                           AND   id IS INITIAL.
        <fs_id2>-id = <fs_id>-id.
      ENDLOOP.
    ENDLOOP.

*Eldeki alanlar kullanılarak fatura yaratma metoduna verilmesi gereken alanlar beslenir
    IF ct_invoices IS NOT INITIAL.

      SELECT t015~uuid,                       "#EC CI_ALL_FIELDS_NEEDED
             t015~invoice_number,
             t015~id,
*             t017~net_due_date,
             t017~amount_in_transaction_curr,
             t017~transaction_currency,
             t017~customer,
             t012~company_identifier,
             t013~partycode,
             t013~activelimit,
             t013~fundedexposure,
             OpAcc~NetDueDate AS net_due_date
        FROM zarete_dbs_t015 AS t015
        LEFT OUTER JOIN zarete_dbs_t017 AS t017 ON t017~document_reference_id = t015~invoice_number
                                               AND t017~accounting_document = t015~invoice_acc_doc
                                               AND t017~accounting_document_item = t015~invoice_acc_doc_item
        LEFT OUTER JOIN zarete_dbs_t012 AS t012 ON t012~bp_no = t017~customer
        LEFT OUTER JOIN zarete_dbs_t013 AS t013 ON t013~identifier = t012~company_identifier
                                               AND t013~limitid    = t012~limit_id
        LEFT OUTER JOIN I_OperationalAcctgDocItem AS OpAcc ON OpAcc~AccountingDocument = lpad( t015~invoice_acc_doc, 10, '0' )
                                                          AND OpAcc~Customer IS NOT INITIAL
        FOR ALL ENTRIES IN @ct_invoices
        WHERE t015~invoice_number EQ @ct_invoices-invoice_number
        AND   t015~id EQ @ct_invoices-id
        AND   t017~customer EQ @ct_invoices-customer
        AND   t012~company_bank_code EQ @ct_invoices-bank_code
        INTO TABLE @DATA(lt_send_details).

*Kısmi fatura/geri alınmış fatura tespiti
      SELECT *                                "#EC CI_ALL_FIELDS_NEEDED
        FROM zarete_dbs_t016
        FOR ALL ENTRIES IN @ct_invoices
        WHERE invoice_number EQ @ct_invoices-invoice_number
        AND   id EQ @ct_invoices-id
*        AND   amount IS NOT INITIAL
        INTO TABLE @DATA(lt_t016_partial).

      SORT lt_t016_partial BY invoice_number partial_invoice_number DESCENDING.

    ENDIF.

*Ekrandan gelen seçili satırlar için tek tek Finteo fatura yaratma metoduna istek atılır
    LOOP AT ct_invoices ASSIGNING FIELD-SYMBOL(<fs_invoices>).

      READ TABLE lt_send_details ASSIGNING FIELD-SYMBOL(<fs_send_details>) WITH KEY invoice_number = <fs_invoices>-invoice_number
                                                                                    id             = <fs_invoices>-id
                                                                                    customer       = <fs_invoices>-customer.
      IF sy-subrc EQ 0.

*Net Vade Tarihi için kontrol
        DATA(lv_system_date) = cl_abap_context_info=>get_system_date( ).

        IF <fs_send_details>-net_due_date LT lv_system_date.

          <fs_invoices>-message = 'Vade Tarihi Geçmiş Olamaz'.
          lo_log->set_sapinvoiceno( iv_sapinvoiceno = <fs_invoices>-invoice_number
                                    iv_id           = <fs_invoices>-id
                                    iv_bankcode     = <fs_invoices>-bank_code ).
          lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                           msgno = '013'  ).

        ELSEIF <fs_send_details>-net_due_date EQ lv_system_date.

          <fs_invoices>-message = 'Fatura vadesi bugün. Gönderim yapılamaz.'.
          lo_log->set_sapinvoiceno( iv_sapinvoiceno = <fs_invoices>-invoice_number
                                    iv_id           = <fs_invoices>-id
                                    iv_bankcode     = <fs_invoices>-bank_code ).
          lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                           msgno = '014'  ).

        ELSE.

          SELECT SINGLE factorycalendarid
            FROM I_FactoryCalendarBasic
            WHERE FactoryCalendarLegacyID EQ 'TR'
            INTO @DATA(lv_calendarid).
          IF sy-subrc EQ 0.
            TRY.
                DATA(lo_calendar) = cl_fhc_calendar_runtime=>create_factorycalendar_runtime( iv_factorycalendar_id = lv_calendarid ).
*                DATA(lv_workingday) = lo_calendar->is_date_workingday( iv_date = <fs_send_details>-net_due_date ).

                WHILE lo_calendar->is_date_workingday( <fs_send_details>-net_due_date ) = abap_false.
                  <fs_send_details>-net_due_date += 1.
                ENDWHILE.

              CATCH cx_fhc_runtime INTO DATA(lx_error).
                DATA(lv_text) = lx_error->get_longtext( ).
            ENDTRY.
          ENDIF.

*          IF lv_workingday EQ abap_true.

          DATA(lv_invoice_total) = REDUCE #( INIT amount TYPE zarete_dbs_de_finteo_amount
                                             FOR ls_invoices IN ct_invoices
                                             WHERE ( invoice_number = <fs_invoices>-invoice_number )
                                             NEXT amount = amount + ls_invoices-amount ).
*Ekranda parçalan fatura tutarı belgenin tutar değerinden yüksek olmamalı
          IF lv_invoice_total LE <fs_send_details>-amount_in_transaction_curr.

            SELECT SUM( amount )
              FROM zarete_dbs_t016
              WHERE invoice_number EQ @<fs_invoices>-invoice_number
              INTO @DATA(lv_send_total).

            lv_send_total += <fs_invoices>-amount.

*O anda gönderilecek fatura tutarı daha önce aynı fatura no ile gönderilmiş olan tutarlarla birleştirildiğinde
*belgenin tutar değerinden yüksek olmamalı
            IF lv_send_total LE <fs_send_details>-amount_in_transaction_curr.

*Gönderilmek istenen fatura daha önceden aynı fatura numarası ile gönderilmişse yanına kısmi kodu eklenmelidir
*Normalde aktif fatura var mı diye kontrol edilir bazı bankalar ancak aynı fatura no ile tekrar gönderimi kabul etmiyor
              READ TABLE lt_t016_partial ASSIGNING FIELD-SYMBOL(<fs_partial>) WITH KEY invoice_number = <fs_invoices>-invoice_number
                                                                                       id = <fs_invoices>-id.
              IF sy-subrc EQ 0.
                IF <fs_partial>-partial_invoice_number IS INITIAL.
                  lv_invoice_number = <fs_invoices>-invoice_number && '-01'.
                ELSE.
                  CLEAR: lv_inv, lv_partial.
                  SPLIT <fs_partial>-partial_invoice_number AT '-' INTO lv_inv lv_partial.
                  lv_partial += 1.
                  lv_invoice_number = lv_inv && '-' && lv_partial.
                ENDIF.
                lv_partial_invoice_number = lv_invoice_number.
              ELSE.
                lv_invoice_number = <fs_invoices>-invoice_number.
                lv_partial_invoice_number = ''.
              ENDIF.

              DATA(lv_due_date) =  <fs_send_details>-net_due_date+0(4) && '-' &&
                                   <fs_send_details>-net_due_date+4(2) && '-' &&
                                   <fs_send_details>-net_due_date+6(2).

              DATA(lv_amount) = CONV zarete_dbs_de_finteo_amount( COND #( WHEN iv_clr_amount IS INITIAL THEN <fs_invoices>-amount
                                                                          ELSE iv_clr_amount ) ).

*Gönderilmek istenen fatura tutarı limiti aşmamalı
              DATA : lv_partycode TYPE c LENGTH 10.
              lv_partycode = <fs_send_details>-partycode.

              CLEAR: lt_limit.
              get_limit_data( EXPORTING iv_behavior  = abap_true
                                        iv_partycode = lv_partycode
                                        iv_bankcode  = <fs_invoices>-bank_code
                              IMPORTING et_limit = lt_limit ).

              READ TABLE lt_limit-data INTO DATA(ls_data) INDEX 1.
              IF sy-subrc EQ 0 AND lv_amount LE ls_data-activelimit.

                lo_send->upload_invoice(
                  EXPORTING
                    iv_bankeftcode    = CONV string( <fs_invoices>-bank_code )
                    iv_partycode      = |{ <fs_send_details>-partycode ALPHA = IN }|
                    iv_identifier     = <fs_send_details>-company_identifier
*                    iv_amount         = CONV zarete_dbs_de_finteo_amount( <fs_invoices>-amount )
                    iv_amount         = lv_amount
                    iv_invoicenumber  = CONV string( lv_invoice_number )
                    iv_invoiceduedate = lv_due_date
                    iv_currencycode   = CONV string( <fs_send_details>-transaction_currency )
                  RECEIVING
                    rv_upload_invoice = DATA(ls_result) ).

                CLEAR: lv_amount.
*Gelen başarı mesajı ve dbsinvoiceid alanına istinaden oluşan faturanın detayları
*dbsinvoiceid kullanılarak sorgulanır
                IF ls_result-status EQ 'OK' AND ls_result-data-dbsinvoiceid IS NOT INITIAL.

*Fatura başarılı bir şekilde yaratıldıysa kısmi gönderimde numaralandırma açısından tabloya dahil edilir
                  APPEND INITIAL LINE TO lt_t016_partial ASSIGNING <fs_partial>.
                  <fs_partial>-invoice_number         = <fs_invoices>-invoice_number.
                  <fs_partial>-partial_invoice_number = lv_partial_invoice_number.
                  <fs_partial>-id                     = <fs_invoices>-id.
                  SORT lt_t016_partial BY invoice_number partial_invoice_number DESCENDING.

                  DATA(lv_startdate) =  <fs_send_details>-net_due_date+0(4) && '-01-01' .
                  DATA(lv_enddate) = lv_due_date.

                  lo_send->get_invoice(
                    EXPORTING
                      iv_startdate         = lv_startdate
                      iv_finishdate        = lv_enddate
                      iv_dbsinvoiceid      = ls_result-data-dbsinvoiceid
                    RECEIVING
                      rv_invoice           = DATA(ls_invoice)
                  ).

*Gelen satır ilgili fatura ve finteo faturaları tablolarında yaratılır ya da güncellenir
                  IF ls_invoice-status EQ 'OK' AND ls_invoice-data IS NOT INITIAL.

                    IF <fs_invoices>-id IS INITIAL.
                      create_number_range_interval( IMPORTING ev_error = lv_error ).
                      IF lv_error NE abap_true.
                        get_number_next( IMPORTING ev_number = lv_number ).
                        <fs_invoices>-id = lv_number.
                      ENDIF.

                    ENDIF.

                    LOOP AT ls_invoice-data ASSIGNING FIELD-SYMBOL(<fs_data>).

                      SELECT SINGLE *         "#EC CI_ALL_FIELDS_NEEDED
                        FROM zarete_dbs_t016
                        WHERE identifier     EQ @<fs_data>-identifier
                        AND   dbs_invoice_id EQ @<fs_data>-dbsinvoiceid
                        INTO @DATA(ls_t016).

                      IF sy-subrc EQ 0.

                        APPEND INITIAL LINE TO lt_t016_update ASSIGNING FIELD-SYMBOL(<fs_t016_update>).
                        <fs_t016_update>-Identifier                  = ls_t016-identifier.
                        <fs_t016_update>-DbsInvoiceId                = ls_result-data-dbsinvoiceid.
                        <fs_t016_update>-Amount                      = <fs_invoices>-amount.
                        <fs_t016_update>-Id                          = <fs_invoices>-id.
                        <fs_t016_update>-InvoiceNumber               = ls_t016-invoice_number.
                        <fs_t016_update>-PartialInvoiceNumber        = ls_t016-partial_invoice_number.
                        IF <fs_data>-duedate IS NOT INITIAL.
                          <fs_t016_update>-DueDate = <fs_data>-duedate+6(4) && <fs_data>-duedate+3(2) && <fs_data>-duedate+0(2).
                        ENDIF.
                        IF <fs_data>-TransactionDate IS NOT INITIAL.
                          <fs_t016_update>-TransactionDate = <fs_data>-TransactionDate+6(4) && <fs_data>-TransactionDate+3(2) && <fs_data>-TransactionDate+0(2).
                        ENDIF.
                        <fs_t016_update>-LastPaymentDate             = <fs_data>-lastpaymentdate.
                        <fs_t016_update>-PaymentDescription          = <fs_data>-paymentdescription.
                        <fs_t016_update>-StatusCode                  = <fs_data>-statuscode.
                        <fs_t016_update>-StatusDescription           = <fs_data>-statusdescription.
                        <fs_t016_update>-%control-DueDate            = if_abap_behv=>mk-on.
                        <fs_t016_update>-%control-LastPaymentDate    = if_abap_behv=>mk-on.
                        <fs_t016_update>-%control-PaymentDescription = if_abap_behv=>mk-on.
                        <fs_t016_update>-%control-StatusCode         = if_abap_behv=>mk-on.
                        <fs_t016_update>-%control-StatusDescription  = if_abap_behv=>mk-on.
                        <fs_t016_update>-%control-DbsInvoiceId       = if_abap_behv=>mk-on.
                        <fs_t016_update>-%control-Id                 = if_abap_behv=>mk-on.
                        <fs_t016_update>-%control-InvoiceNumber      = if_abap_behv=>mk-on.
                        <fs_t016_update>-%control-PartialInvoiceNumber = if_abap_behv=>mk-on.

                      ELSE.

                        APPEND INITIAL LINE TO lt_t016_create ASSIGNING FIELD-SYMBOL(<fs_t016_create>).
                        <fs_t016_create>-Identifier                           = <fs_data>-Identifier.
                        <fs_t016_create>-DbsInvoiceId                         = <fs_data>-DbsInvoiceId.
                        <fs_t016_create>-Id                                   = <fs_invoices>-id.
                        <fs_t016_create>-Amount                               = <fs_data>-Amount.
                        <fs_t016_create>-CurrencyCode                         = <fs_data>-CurrencyCode.
                        IF <fs_data>-duedate IS NOT INITIAL.
                          <fs_t016_create>-DueDate = <fs_data>-duedate+6(4) && <fs_data>-duedate+3(2) && <fs_data>-duedate+0(2).
                        ENDIF.
                        <fs_t016_create>-SendDate                             = cl_abap_context_info=>get_system_date( ).
                        <fs_t016_create>-InvoiceNumber                        = <fs_invoices>-invoice_number.
                        <fs_t016_create>-PartialInvoiceNumber                 = lv_partial_invoice_number.
                        <fs_t016_create>-InvoiceAmountDue                     = <fs_data>-InvoiceAmountDue.
                        <fs_t016_create>-LastPaymentDate                      = <fs_data>-LastPaymentDate.
                        <fs_t016_create>-PartialGuaranteedAmount              = <fs_data>-PartialGuaranteedAmount.
                        <fs_t016_create>-AmountRemainingBeforePaymen          = <fs_data>-AmountRemainingBeforePayment.
                        <fs_t016_create>-PaymentDescription                   = <fs_data>-PaymentDescription.
                        <fs_t016_create>-StatusCode                           = <fs_data>-StatusCode.
                        <fs_t016_create>-StatusDescription                    = <fs_data>-StatusDescription.
                        IF <fs_data>-TransactionDate IS NOT INITIAL.
                          <fs_t016_create>-TransactionDate = <fs_data>-TransactionDate+6(4) && <fs_data>-TransactionDate+3(2) && <fs_data>-TransactionDate+0(2).
                        ENDIF.
                        <fs_t016_create>-DbsAccountId                         = <fs_data>-DbsAccountId.
                        <fs_t016_create>-PartyCode                            = |{ <fs_data>-PartyCode ALPHA = OUT }|.
                        <fs_t016_create>-PartyTitle                           = <fs_data>-PartyTitle.
                        <fs_t016_create>-PartyTaxNumber                       = <fs_data>-PartyTaxNumber.
                        <fs_t016_create>-BankCode                             = <fs_data>-BankCode.
                        <fs_t016_create>-BankName                             = <fs_data>-BankName.
                        <fs_t016_create>-%control-Identifier                  = if_abap_behv=>mk-on.
                        <fs_t016_create>-%control-DbsInvoiceId                = if_abap_behv=>mk-on.
                        <fs_t016_create>-%control-Id                          = if_abap_behv=>mk-on.
                        <fs_t016_create>-%control-Amount                      = if_abap_behv=>mk-on.
                        <fs_t016_create>-%control-CurrencyCode                = if_abap_behv=>mk-on.
                        <fs_t016_create>-%control-DueDate                     = if_abap_behv=>mk-on.
                        <fs_t016_create>-%control-SendDate                    = if_abap_behv=>mk-on.
                        <fs_t016_create>-%control-InvoiceNumber               = if_abap_behv=>mk-on.
                        <fs_t016_create>-%control-PartialInvoiceNumber        = if_abap_behv=>mk-on.
                        <fs_t016_create>-%control-InvoiceAmountDue            = if_abap_behv=>mk-on.
                        <fs_t016_create>-%control-LastPaymentDate             = if_abap_behv=>mk-on.
                        <fs_t016_create>-%control-PartialGuaranteedAmount     = if_abap_behv=>mk-on.
                        <fs_t016_create>-%control-AmountRemainingBeforePaymen = if_abap_behv=>mk-on.
                        <fs_t016_create>-%control-PaymentDescription          = if_abap_behv=>mk-on.
                        <fs_t016_create>-%control-StatusCode                  = if_abap_behv=>mk-on.
                        <fs_t016_create>-%control-StatusDescription           = if_abap_behv=>mk-on.
                        <fs_t016_create>-%control-TransactionDate             = if_abap_behv=>mk-on.
                        <fs_t016_create>-%control-DbsAccountId                = if_abap_behv=>mk-on.
                        <fs_t016_create>-%control-PartyCode                   = if_abap_behv=>mk-on.
                        <fs_t016_create>-%control-PartyTitle                  = if_abap_behv=>mk-on.
                        <fs_t016_create>-%control-PartyTaxNumber              = if_abap_behv=>mk-on.
                        <fs_t016_create>-%control-BankCode                    = if_abap_behv=>mk-on.
                        <fs_t016_create>-%control-BankName                    = if_abap_behv=>mk-on.

                      ENDIF.

                      SELECT SINGLE *         "#EC CI_ALL_FIELDS_NEEDED
                        FROM zarete_dbs_t015
                        WHERE invoice_number EQ @<fs_invoices>-invoice_number
                        AND   id             EQ @<fs_invoices>-id
                        INTO @DATA(ls_t015).

                      IF sy-subrc EQ 0.

                        APPEND INITIAL LINE TO lt_t015_update ASSIGNING FIELD-SYMBOL(<fs_t015_update>).
                        <fs_t015_update>-InvoiceNumber          = ls_t015-invoice_number.
                        <fs_t015_update>-Uuid                   = ls_t015-uuid.
                        <fs_t015_update>-Id                     = ls_t015-id.
                        <fs_t015_update>-statu                  = <fs_data>-statusdescription.
                        <fs_t015_update>-IsCancelled            = ''.
                        <fs_t015_update>-%control-statu         = if_abap_behv=>mk-on.
                        <fs_t015_update>-%control-IsCancelled   = if_abap_behv=>mk-on.
*                        IF ls_t015-dbs_invoice_id IS INITIAL.
                        <fs_t015_update>-DbsInvoiceId           = <fs_data>-dbsinvoiceid.
                        <fs_t015_update>-DbsAccountId           = <fs_data>-dbsaccountid.
                        <fs_t015_update>-%control-DbsInvoiceId  = if_abap_behv=>mk-on.
                        <fs_t015_update>-%control-DbsAccountId  = if_abap_behv=>mk-on.
*                        ENDIF.
                      ELSE.

                        APPEND INITIAL LINE TO lt_t015_create ASSIGNING FIELD-SYMBOL(<fs_t015_create>).
                        <fs_t015_create>-InvoiceNumber            = <fs_invoices>-invoice_number.
                        <fs_t015_create>-Id                       = <fs_invoices>-id.
                        <fs_t015_create>-ScenarioType             = '120-102'.
                        <fs_t015_create>-statu                    = <fs_data>-statusdescription.
                        <fs_t015_create>-DbsInvoiceId             = <fs_data>-dbsinvoiceid.
                        <fs_t015_create>-DbsAccountId             = <fs_data>-dbsaccountid.
                        IF <fs_data>-TransactionDate IS NOT INITIAL.
                          <fs_t015_create>-TransactionDate = <fs_data>-TransactionDate+6(4) && <fs_data>-TransactionDate+3(2) && <fs_data>-TransactionDate+0(2).
                        ENDIF.
                        IF <fs_data>-duedate IS NOT INITIAL.
                          <fs_t015_create>-DueDate = <fs_data>-duedate+6(4) && <fs_data>-duedate+3(2) && <fs_data>-duedate+0(2).
                        ENDIF.
                        <fs_t015_create>-%control-InvoiceNumber   = if_abap_behv=>mk-on.
                        <fs_t015_create>-%control-Id              = if_abap_behv=>mk-on.
                        <fs_t015_create>-%control-ScenarioType    = if_abap_behv=>mk-on.
                        <fs_t015_create>-%control-statu           = if_abap_behv=>mk-on.
                        <fs_t015_create>-%control-DbsInvoiceId    = if_abap_behv=>mk-on.
                        <fs_t015_create>-%control-DbsAccountId    = if_abap_behv=>mk-on.
                        <fs_t015_create>-%control-TransactionDate = if_abap_behv=>mk-on.

                      ENDIF.

                    ENDLOOP.

                    <fs_invoices>-message = 'Fatura Yaratıldı'.
                    lo_log->set_sapinvoiceno( iv_sapinvoiceno = <fs_invoices>-invoice_number
                                              iv_id           = <fs_invoices>-id
                                              iv_bankcode     = <fs_invoices>-bank_code ).
                    lo_log->add_log( msgty = if_abap_behv_message=>severity-success
                                     msgno = '008'  ).

                  ENDIF.

                ELSE.

                  <fs_invoices>-message = ls_result-statusmessage.
                  lo_log->set_sapinvoiceno( iv_sapinvoiceno = <fs_invoices>-invoice_number
                                            iv_id           = <fs_invoices>-id
                                            iv_bankcode     = <fs_invoices>-bank_code ).
                  lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                                   msgtx = ls_result-statusmessage ).

                ENDIF.

              ELSE.

                <fs_invoices>-message = 'Limit Yetersiz'.
                lo_log->set_sapinvoiceno( iv_sapinvoiceno = <fs_invoices>-invoice_number
                                          iv_id           = <fs_invoices>-id
                                          iv_bankcode     = <fs_invoices>-bank_code ).
                lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                                 msgno = '016'  ).

              ENDIF.

            ELSE.

              <fs_invoices>-message = 'Gönderilen Tutar Belge Tutarından Yüksek'.
              lo_log->set_sapinvoiceno( iv_sapinvoiceno = <fs_invoices>-invoice_number
                                        iv_id           = <fs_invoices>-id
                                        iv_bankcode     = <fs_invoices>-bank_code ).
              lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                               msgno = '009'  ).

            ENDIF.

          ELSE.

            <fs_invoices>-message = 'Gönderilen Tutar Belge Tutarından Yüksek'.
            lo_log->set_sapinvoiceno( iv_sapinvoiceno = <fs_invoices>-invoice_number
                                      iv_id           = <fs_invoices>-id
                                      iv_bankcode     = <fs_invoices>-bank_code ).
            lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                             msgno = '009'  ).

          ENDIF.

*          ELSE.
*
*            <fs_invoices>-message = 'Vade tarihi iş günü içersininde değildir. Kontrol ediniz.'.
*            lo_log->set_sapinvoiceno( iv_sapinvoiceno = <fs_invoices>-invoice_number
*                                      iv_id           = <fs_invoices>-id
*                                      iv_bankcode     = <fs_invoices>-bank_code ).
*            lo_log->add_log( msgty = if_abap_behv_message=>severity-error
*                             msgno = '015'  ).
*
*          ENDIF.

        ENDIF.

      ELSE.

        <fs_invoices>-message = 'Cariye Ait Limit Bilgisi Bulunamadı'.
        lo_log->set_sapinvoiceno( iv_sapinvoiceno = <fs_invoices>-invoice_number
                                  iv_id           = <fs_invoices>-id
                                  iv_bankcode     = <fs_invoices>-bank_code ).
        lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                         msgno = '010'  ).

      ENDIF.

      CLEAR: lv_invoice_total, ls_result, lv_startdate, lv_enddate,
             ls_invoice, lv_error, lv_number, lv_invoice_number,
             lv_partial_invoice_number, lv_partial, lv_inv.

    ENDLOOP.

    MODIFY ENTITIES OF zarete_dbs_dd_t015 ENTITY zarete_dbs_dd_t015
    CREATE AUTO FILL CID WITH lt_t015_create
    MAPPED DATA(lt_mapped_t015_cr)
    FAILED DATA(lt_failed_t015_cr)
    REPORTED DATA(lt_reported_t015_cr).

    SORT lt_t015_update BY uuid InvoiceNumber Id.
    DELETE ADJACENT DUPLICATES FROM lt_t015_update COMPARING uuid InvoiceNumber Id.

    MODIFY ENTITIES OF zarete_dbs_dd_t015 ENTITY zarete_dbs_dd_t015
    UPDATE FIELDS ( Statu IsCancelled DbsAccountId DbsInvoiceId ) WITH lt_t015_update
    MAPPED DATA(lt_mapped_t015_up)
    FAILED DATA(lt_failed_t015_up)
    REPORTED DATA(lt_reported_t015_up).

    MODIFY ENTITIES OF zarete_dbs_dd_t016 ENTITY zarete_dbs_dd_t016
    CREATE AUTO FILL CID WITH lt_t016_create
    MAPPED DATA(lt_mapped_t016_cr)
    FAILED DATA(lt_failed_t016_cr)
    REPORTED DATA(lt_reported_t016_cr).

    MODIFY ENTITIES OF zarete_dbs_dd_t016 ENTITY zarete_dbs_dd_t016
    UPDATE FIELDS ( Amount DueDate LastPaymentDate
                    PaymentDescription StatusCode StatusDescription Id
                    InvoiceNumber PartialInvoiceNumber ) WITH lt_t016_update
    MAPPED DATA(lt_mapped_t016_up)
    FAILED DATA(lt_failed_t016_up)
    REPORTED DATA(lt_reported_t016_up).

    IF cl_abap_behv_aux=>get_current_handler_kind( ) IS INITIAL.

      COMMIT ENTITIES RESPONSE OF zarete_dbs_dd_t015
      FAILED DATA(lt_failed_t015_co)
      REPORTED DATA(lt_reported_t015_co).

      COMMIT ENTITIES RESPONSE OF zarete_dbs_dd_t016
      FAILED DATA(lt_failed_t016_co)
      REPORTED DATA(lt_reported_t016_co).
    ENDIF.

  ENDMETHOD.


  METHOD update_due_date.

    DATA: lt_t016_update TYPE TABLE FOR UPDATE zarete_dbs_dd_t016.

    DATA(lo_send) = NEW zarete_dbs_sc_finteo_api( ).
    DATA(lo_log) = zarete_dbs_cl_log=>get_factory( ).

    SELECT * FROM zarete_dbs_t016 WHERE invoice_number = @iv_invoice_number INTO TABLE @DATA(lt_t016).

    LOOP AT lt_t016 ASSIGNING FIELD-SYMBOL(<fs_t016>).

      DATA(lv_invoice_number) =  COND #( WHEN <fs_t016>-partial_invoice_number IS NOT INITIAL THEN <fs_t016>-partial_invoice_number
                                         ELSE <fs_t016>-invoice_number ).
*İlgili faturanın vade tarihi hariç tüm alanları aynı, vade tarihi SAP'den gelen güncel vade tarihi olacak şekilde
*Finteo'ya gönderilir
      lo_send->update_invoice(
        EXPORTING
          iv_bankeftcode    = CONV string( <fs_t016>-bank_code )
          iv_partycode      = CONV string( <fs_t016>-party_code )
          iv_identifier     = CONV string( <fs_t016>-identifier )
          iv_amount         = CONV zarete_dbs_de_finteo_amount( <fs_t016>-amount )
          iv_invoicenumber  = CONV string( lv_invoice_number )
          iv_invoiceduedate = iv_due_date
          iv_currencycode   = CONV string( <fs_t016>-currency_code )
        RECEIVING
          rv_update_invoice = DATA(ls_result)
      ).

      IF ls_result-status EQ 'OK'.

*Başarılı güncellemenin ardından ilgili fatura sorgulanır
*Finteo iş günü olmayan vade tarihlerinde en yakın iş gününe göre düzenleme yaptığı için
*SAP'den gelen vade tarihini direkt kullanamıyoruz
        DATA(lv_startdate) = iv_due_date+0(4) && '-01-01' .
        DATA(lv_enddate)   = iv_due_date .

        lo_send->get_invoice(
          EXPORTING
            iv_startdate         = lv_startdate
            iv_finishdate        = lv_enddate
            iv_dbsinvoiceid      = ls_result-data-dbsinvoiceid
          RECEIVING
            rv_invoice           = DATA(ls_invoice)
        ).

        IF ls_invoice-status EQ 'OK'.

*Finteo'dan alınan vade tarihi ile Finteo faturaları tablosu vade tarihi alanı güncellenir
          LOOP AT ls_invoice-data ASSIGNING FIELD-SYMBOL(<fs_data>).

            APPEND INITIAL LINE TO lt_t016_update ASSIGNING FIELD-SYMBOL(<fs_t016_update>).
            <fs_t016_update>-Identifier                  = <fs_t016>-identifier.
            <fs_t016_update>-DbsInvoiceId                = <fs_t016>-dbs_invoice_id.
            <fs_t016_update>-DueDate                     = <fs_data>-duedate.
            <fs_t016_update>-%control-DueDate            = if_abap_behv=>mk-on.

            lo_log->set_sapinvoiceno( iv_sapinvoiceno = <fs_t016>-invoice_number
                                      iv_id           = <fs_t016>-id
                                      iv_bankcode     = <fs_t016>-bank_code ).
            lo_log->add_log( msgty = if_abap_behv_message=>severity-success
                             msgno = '011'  ).

          ENDLOOP.

        ENDIF.

      ENDIF.

    ENDLOOP.

    MODIFY ENTITIES OF zarete_dbs_dd_t016 ENTITY zarete_dbs_dd_t016
    UPDATE FIELDS ( DueDate ) WITH lt_t016_update
    MAPPED DATA(lt_mapped_t016_up)
    FAILED DATA(lt_failed_t016_up)
    REPORTED DATA(lt_reported_t016_up).

    IF cl_abap_behv_aux=>get_current_handler_kind( ) IS INITIAL.
      COMMIT ENTITIES RESPONSE OF zarete_dbs_dd_t016
      FAILED DATA(lt_failed_t016_co)
      REPORTED DATA(lt_reported_t016_co).
    ENDIF.

  ENDMETHOD.


  METHOD fill_limit_tables.

    DATA: ls_t013 TYPE zarete_dbs_t013,
          lt_t013 TYPE TABLE OF zarete_dbs_t013,
          lt_t012 TYPE TABLE OF zarete_dbs_t012,
          ls_t032 TYPE TABLE FOR CREATE zarete_dbs_dd_t032.

    DATA: lr_taxno TYPE RANGE OF I_Businesspartnertaxnumber-BPTaxNumber,
          lr_iban  TYPE RANGE OF iban.

    TYPES: BEGIN OF ty_max_prio,
             bp_tax_number TYPE zarete_dbs_t012-bp_tax_number,
             max_prio      TYPE i,
           END OF ty_max_prio.

    DATA lt_max_prio TYPE HASHED TABLE OF ty_max_prio WITH UNIQUE KEY bp_tax_number.

    TYPES: BEGIN OF ty_temp_prio,
             bp_tax_number TYPE zarete_dbs_t012-bp_tax_number,
             bank_priority TYPE zarete_dbs_t012-bank_priority,
           END OF ty_temp_prio.
    DATA lt_temp_prio TYPE TABLE OF ty_temp_prio.

    IF ct_limit-data IS NOT INITIAL.

      LOOP AT ct_limit-data ASSIGNING FIELD-SYMBOL(<fs_limit>).

        IF <fs_limit>-partytaxnumber IS INITIAL.

          DATA(lv_bpno) = CONV kunnr( <fs_limit>-partycode ).
          lv_bpno = |{ lv_bpno ALPHA = IN }|.

          SELECT SINGLE tax~BPTaxNumber,
                        nam~BusinessPartnerFullName
            FROM I_Businesspartnertaxnumber WITH PRIVILEGED ACCESS AS tax
            INNER JOIN I_BusinessPartner WITH PRIVILEGED ACCESS AS nam ON nam~BusinessPartner EQ tax~BusinessPartner
            WHERE tax~BusinessPartner EQ @lv_bpno
            AND tax~BPTaxType EQ 'TR2'
            INTO @DATA(ls_bp).
          IF sy-subrc EQ 0.
            <fs_limit>-partytaxnumber = ls_bp-BPTaxNumber.
            <fs_limit>-partytitle     = ls_bp-BusinessPartnerFullName.
          ENDIF.

        ENDIF.

        IF <fs_limit>-partytaxnumber NE '0' OR <fs_limit>-partytaxnumber IS NOT INITIAL.
          APPEND VALUE #( sign = 'I' option = 'EQ' low = <fs_limit>-partytaxnumber ) TO lr_taxno.
        ENDIF.

        IF <fs_limit>-linkediban IS NOT INITIAL.
          APPEND VALUE #( sign = 'I' option = 'EQ' low = <fs_limit>-linkediban )     TO lr_iban.
        ENDIF.

      ENDLOOP.

      SORT lr_iban BY low.
      DELETE ADJACENT DUPLICATES FROM lr_iban COMPARING low.

      SELECT BusinessPartner,
             BPTaxNumber
        FROM I_Businesspartnertaxnumber
        WHERE BPTaxNumber IN @lr_taxno
        AND   BPTaxType   EQ 'TR2'
        INTO TABLE @DATA(lt_bptax).

      SELECT CompanyCode,
             HouseBank,
             HouseBankAccount,
             Iban,
             BankAccountCurrency,
             GLAccount
        FROM I_HouseBankAccountLinkage
        WHERE CompanyCode EQ @iv_company_code
        AND   iban IN @lr_iban
        INTO TABLE @DATA(lt_glaccount).

    ENDIF.

    DATA(lt_unique_bps) = ct_limit-data.
    SORT lt_unique_bps BY partytaxnumber.
    DELETE ADJACENT DUPLICATES FROM lt_unique_bps COMPARING partytaxnumber.
    DELETE lt_unique_bps WHERE partytaxnumber IS INITIAL.

    IF lt_unique_bps IS NOT INITIAL.

      SELECT bp_tax_number, bank_priority
        FROM zarete_dbs_t012
        FOR ALL ENTRIES IN @lt_unique_bps
        WHERE bp_tax_number = @lt_unique_bps-partytaxnumber
        INTO TABLE @lt_temp_prio.

      IF sy-subrc = 0.

        SORT lt_temp_prio BY bp_tax_number ASCENDING bank_priority DESCENDING.
        DELETE ADJACENT DUPLICATES FROM lt_temp_prio COMPARING bp_tax_number.

        LOOP AT lt_temp_prio INTO DATA(ls_temp).
          SELECT COUNT( * )
            FROM zarete_dbs_t012
            WHERE bp_tax_number EQ @ls_temp-bp_tax_number
            INTO @DATA(lv_count).
          INSERT VALUE #( bp_tax_number = ls_temp-bp_tax_number
*                          max_prio      = ls_temp-bank_priority )
                          max_prio      = lv_count )
                 INTO TABLE lt_max_prio.
        ENDLOOP.

      ENDIF.

    ENDIF.

    SELECT *
      FROM zarete_dbs_dd_t032
      FOR ALL ENTRIES IN @ct_limit-data
      WHERE Identifier = @ct_limit-data-identifier
      AND   LimitId    = @ct_limit-data-limitid
      AND   PartyTaxNumber = @ct_limit-data-partytaxnumber
      INTO TABLE @DATA(lt_t032).

    LOOP AT ct_limit-data ASSIGNING <fs_limit>.
      <fs_limit>-partycode = |{ <fs_limit>-partycode ALPHA = OUT }|.
      MOVE-CORRESPONDING <fs_limit> TO ls_t013.

      IF <fs_limit>-isactive IS NOT INITIAL.
        ls_t013-isactive = abap_true.
      ELSE.
        ls_t013-isactive = abap_false.
      ENDIF.

      SELECT SINGLE *                         "#EC CI_ALL_FIELDS_NEEDED
      FROM zarete_dbs_t012
      WHERE company_identifier EQ @<fs_limit>-identifier
      AND   limit_id EQ @<fs_limit>-limitid
      INTO @DATA(ls_t012).
      IF sy-subrc NE 0.
        APPEND INITIAL LINE TO lt_t012 ASSIGNING FIELD-SYMBOL(<fs_t012>).
        <fs_t012>-client = sy-mandt.
        <fs_t012>-company_identifier = <fs_limit>-identifier.
        <fs_t012>-limit_id = <fs_limit>-limitid.
        <fs_t012>-company_code = iv_company_code.
        <fs_t012>-company_bank_code = <fs_limit>-bankcode.
        <fs_t012>-bp_tax_number = <fs_limit>-partytaxnumber.

        DATA(lv_current_index) = lines( lt_t012 ).

        IF <fs_limit>-partytaxnumber IS NOT INITIAL.

          READ TABLE lt_t012 ASSIGNING FIELD-SYMBOL(<fs_prev_t012>)
               WITH KEY company_identifier = <fs_limit>-identifier
                        limit_id           = <fs_limit>-limitid.

          IF sy-subrc = 0 AND sy-tabix < lv_current_index.
            <fs_t012>-bank_priority = <fs_prev_t012>-bank_priority.
          ELSE.
            READ TABLE lt_max_prio ASSIGNING FIELD-SYMBOL(<fs_prio>)
                                   WITH TABLE KEY bp_tax_number = <fs_limit>-partytaxnumber.
            IF sy-subrc = 0.
              <fs_prio>-max_prio += 1.
              <fs_t012>-bank_priority = <fs_prio>-max_prio.
            ELSE.
              INSERT VALUE #( bp_tax_number = <fs_limit>-partytaxnumber max_prio = 1 )
                     INTO TABLE lt_max_prio ASSIGNING <fs_prio>.
              <fs_t012>-bank_priority = 1.
            ENDIF.
          ENDIF.

*          READ TABLE lt_bptax ASSIGNING FIELD-SYMBOL(<fs_bptax>) WITH KEY BPTaxNumber = <fs_limit>-partytaxnumber.
*          IF sy-subrc EQ 0.
*            <fs_t012>-bp_no = <fs_bptax>-BusinessPartner.
*          ENDIF.

        ENDIF.

        READ TABLE lt_glaccount ASSIGNING FIELD-SYMBOL(<fs_glaccount>) WITH KEY CompanyCode = iv_company_code
                                                                                Iban        = <fs_limit>-linkediban
                                                                                BankAccountCurrency = <fs_limit>-currencycode.
        IF sy-subrc EQ 0.
          <fs_t012>-glaccount = <fs_glaccount>-GLAccount.
          <fs_t012>-house_bank = <fs_glaccount>-HouseBank.
          <fs_t012>-house_bank_account = <fs_glaccount>-HouseBankAccount.
        ENDIF.

        <fs_t012>-bp_no = |{ <fs_limit>-partycode ALPHA = OUT }|.

      ELSE.

        APPEND INITIAL LINE TO lt_t012 ASSIGNING <fs_t012>.
        MOVE-CORRESPONDING ls_t012 TO <fs_t012>.
        <fs_t012>-bp_tax_number = <fs_limit>-partytaxnumber.
        <fs_t012>-bp_no = |{ <fs_limit>-partycode ALPHA = OUT }|.

        READ TABLE lt_glaccount ASSIGNING <fs_glaccount> WITH KEY CompanyCode = iv_company_code
                                                                  Iban        = <fs_limit>-linkediban
                                                                  BankAccountCurrency = <fs_limit>-currencycode.
        IF sy-subrc EQ 0.
          <fs_t012>-glaccount = <fs_glaccount>-GLAccount.
          <fs_t012>-house_bank = <fs_glaccount>-HouseBank.
          <fs_t012>-house_bank_account = <fs_glaccount>-HouseBankAccount.
        ENDIF.
      ENDIF.

      "O an gelen limit verisi en güncel limit bilgisine eşitse log atmasına gerek yok
      DATA(lv_update_required) = abap_false.
      SORT lt_t032 BY CreatedAt DESCENDING.
      READ TABLE lt_t032 ASSIGNING FIELD-SYMBOL(<fs_t032>) WITH KEY Identifier = <fs_limit>-identifier
                                                                    LimitId    = <fs_limit>-limitid
                                                                    PartyTaxNumber = <fs_limit>-partytaxnumber.

      IF sy-subrc NE 0.
        lv_update_required = abap_true.
      ELSEIF <fs_t032>-Limit                  NE <fs_limit>-limit                OR
             <fs_t032>-Activelimit            NE <fs_limit>-activelimit          OR
             <fs_t032>-Pendinginvoicecount    NE <fs_limit>-pendinginvoicecount  OR
             <fs_t032>-Pendinginvoiceamount   NE <fs_limit>-pendinginvoiceamount OR
             <fs_t032>-GuarantedInvoiceAmount NE <fs_limit>-guarantedinvoiceamount OR
             <fs_t032>-FundedExposure         NE <fs_limit>-fundedexposure.
        lv_update_required = abap_true.
      ENDIF.

      IF lv_update_required = abap_true.

        ls_t032 = VALUE #( ( Identifier                      = <fs_limit>-identifier
                             Limitid                         = <fs_limit>-limitid
                             Partycode                       = |{ <fs_limit>-partycode ALPHA = OUT }|
                             Partytaxnumber                  = <fs_limit>-partytaxnumber
                             Partytitle                      = <fs_limit>-partytitle
                             Limit                           = <fs_limit>-limit
                             Activelimit                     = <fs_limit>-activelimit
                             Pendinginvoicecount             = <fs_limit>-pendinginvoicecount
                             Pendinginvoiceamount            = <fs_limit>-pendinginvoiceamount
                             GuarantedInvoiceAmount          = <fs_limit>-guarantedinvoiceamount
                             FundedExposure                  = <fs_limit>-fundedexposure
                             Bankcode                        = <fs_limit>-bankcode
                             Bankname                        = <fs_limit>-bankname
                             Currencycode                    = <fs_limit>-currencycode
                             %control-Identifier             = if_abap_behv=>mk-on
                             %control-Limitid                = if_abap_behv=>mk-on
                             %control-Partycode              = if_abap_behv=>mk-on
                             %control-Partytaxnumber         = if_abap_behv=>mk-on
                             %control-Partytitle             = if_abap_behv=>mk-on
                             %control-Limit                  = if_abap_behv=>mk-on
                             %control-Activelimit            = if_abap_behv=>mk-on
                             %control-Pendinginvoicecount    = if_abap_behv=>mk-on
                             %control-Pendinginvoiceamount   = if_abap_behv=>mk-on
                             %control-GuarantedInvoiceAmount = if_abap_behv=>mk-on
                             %control-FundedExposure         = if_abap_behv=>mk-on
                             %control-Bankcode               = if_abap_behv=>mk-on
                             %control-Bankname               = if_abap_behv=>mk-on
                             %control-Currencycode           = if_abap_behv=>mk-on ) ).

        MODIFY ENTITIES OF zarete_dbs_dd_t032
        ENTITY zarete_dbs_dd_t032
        CREATE AUTO FILL CID WITH ls_t032
        MAPPED DATA(lt_mapped)
        FAILED DATA(lt_failed)
        REPORTED DATA(lt_reported).

        IF cl_abap_behv_aux=>get_current_handler_kind( ) IS INITIAL.
          COMMIT ENTITIES.
        ENDIF.
      ENDIF.

      ls_t013-bank_priority = <fs_t012>-bank_priority.
      ls_t013-partycode = |{ ls_t013-partycode ALPHA = OUT }|.
      APPEND ls_t013 TO lt_t013.

      ls_t013-partycode = |{ ls_t013-partycode ALPHA = OUT }|.
    ENDLOOP.



    IF iv_behavior IS INITIAL.
      MODIFY zarete_dbs_t013 FROM TABLE @lt_t013.
      MODIFY zarete_dbs_t012 FROM TABLE @lt_t012.
      COMMIT WORK AND WAIT.
    ENDIF.

    bank_list( ).

  ENDMETHOD.


  METHOD filter_invoices.

    DATA: lt_invoices  TYPE tt_selected_invoices,
          lv_partycode TYPE kunnr,
          lt_limit     TYPE zarete_dbs_sc_finteo_api=>ty_limit,
          lr_kunnr     TYPE RANGE OF kunnr,
          lv_kunnr     TYPE kunnr.

    SORT ct_invoices BY accounting_document fiscal_year.

    DATA(lt_invoices_tmp) = ct_invoices.
    DATA(lt_invoices_final) = ct_invoices.
    CLEAR: lt_invoices_final.

    SELECT *
    FROM zarete_dbs_t016
    FOR ALL ENTRIES IN @lt_invoices_tmp
    WHERE invoice_number EQ @lt_invoices_tmp-document_reference_id
    AND   amount NE 0
    INTO TABLE @DATA(lt_t016).                "#EC CI_ALL_FIELDS_NEEDED

    SELECT *
    FROM zarete_dbs_t017
    FOR ALL ENTRIES IN @lt_invoices_tmp
    WHERE accounting_document EQ @lt_invoices_tmp-accounting_document
    AND   clearing_accounting_docume EQ @lt_invoices_tmp-clearing_accounting_docume
    INTO TABLE @DATA(lt_t017).                "#EC CI_ALL_FIELDS_NEEDED

    SORT lt_t016 BY invoice_number ASCENDING partial_invoice_number DESCENDING.

    get_limit_data( EXPORTING iv_behavior  = abap_true
                    IMPORTING et_limit = lt_limit ).

    LOOP AT lt_limit-data ASSIGNING FIELD-SYMBOL(<fs_limit>).
      lv_kunnr =  |{ <fs_limit>-partycode  ALPHA = OUT }|.
      CONDENSE lv_kunnr NO-GAPS.
      APPEND VALUE #( sign = 'I' option = 'EQ' low = lv_kunnr ) TO lr_kunnr.
    ENDLOOP.

    SORT lr_kunnr BY low.
    DELETE ADJACENT DUPLICATES FROM lr_kunnr COMPARING low.

    LOOP AT lt_invoices_tmp ASSIGNING FIELD-SYMBOL(<fs_tmp>).

      lv_partycode = <fs_tmp>-customer.
      SHIFT lv_partycode LEFT DELETING LEADING '0'.
      CONDENSE lv_partycode NO-GAPS.
      "Carinin limiti yoksa faturaları dbs ekranına gelmemeli
      IF lr_kunnr IS NOT INITIAL.
        IF lv_partycode NOT IN lr_kunnr.
          CONTINUE.
        ENDIF.
      ENDIF.

      "Denkleştirme belgesi daha önce işlenmiş mi kontrolü
      IF <fs_tmp>-clearing_accounting_docume IS NOT INITIAL.
        READ TABLE lt_t017 TRANSPORTING NO FIELDS WITH KEY accounting_document        = <fs_tmp>-accounting_document
                                                           fiscal_year                = <fs_tmp>-fiscal_year
                                                           clearing_accounting_docume = <fs_tmp>-clearing_accounting_docume
                                                           clearing_doc_fiscal_year   = <fs_tmp>-clearing_doc_fiscal_year.
        IF sy-subrc EQ 0.
          CONTINUE.
        ENDIF.
      ENDIF.

      "Öncelikle is_cleared alanına göre mali yıl-denkl.mali yıl kontrolü yapılır.
      IF <fs_tmp>-is_cleared EQ abap_true AND <fs_tmp>-clearing_doc_fiscal_year NE <fs_tmp>-fiscal_year.
        CONTINUE.
      ENDIF.

      "Belge esas belge mi denkleştirme belgesi mi kontrolü yapılır
      READ TABLE lt_invoices_tmp TRANSPORTING NO FIELDS WITH KEY clearing_accounting_docume = <fs_tmp>-accounting_document.
      IF sy-subrc NE 0."Sonuç yoksa belge esas belgedir

        "Gösterge S olmalı, ters kayıtlı olmamalı
        IF <fs_tmp>-debit_credit_code EQ 'S' AND <fs_tmp>-is_reversed EQ abap_false.

          IF <fs_tmp>-clearing_accounting_docume IS INITIAL."Esas belgede denkleştirme yoksa belge olduğu gibi alınır

            APPEND INITIAL LINE TO lt_invoices_final ASSIGNING FIELD-SYMBOL(<fs_final>).
            <fs_final> = CORRESPONDING #( <fs_tmp> ).

          ELSE."Esas belgede denkleştirme varsa tutar ve ters kayıt kontrolü yapılmalı

            READ TABLE lt_invoices_tmp ASSIGNING FIELD-SYMBOL(<fs_denkl>) WITH KEY accounting_document = <fs_tmp>-clearing_accounting_docume.
            IF sy-subrc EQ 0."Belgeye ait denkleştirme belgesi bulundu

              IF <fs_denkl>-is_reversed EQ abap_true."Denkleştirme belgesinin ters kaydı alınmış, işleme dahil değil

                APPEND INITIAL LINE TO lt_invoices_final ASSIGNING <fs_final>.
                <fs_final> = CORRESPONDING #( <fs_tmp> ).

              ELSE."Denkleştirme belgesi geçerli durumda, tutarlara bakılmalı

                DATA(lv_remaining) = CONV wrbtr( abs( <fs_tmp>-amount_in_transaction_curr ) - <fs_denkl>-amount_in_transaction_curr ).

                IF lv_remaining GT 0."denkleştirme tutarı esas belge tutarının bir kısmını karşılıyor

                  READ TABLE lt_t016 TRANSPORTING NO FIELDS WITH KEY invoice_number = <fs_tmp>-document_reference_id.
                  IF sy-subrc EQ 0."Bankaya gönderim yapılmış, geri çekilip güncellenen tutarla tekrar gönderilmeli
                    DATA(lv_amount) = CONV wrbtr( <fs_denkl>-amount_in_transaction_curr ).

                    LOOP AT lt_t016 ASSIGNING FIELD-SYMBOL(<fs_t016>) WHERE invoice_number EQ <fs_tmp>-document_reference_id.

                      IF lv_amount GT 0."Denkleştirme tutarı faturalara işlenip 0 olduysa devam edilmemeli

                        "Fatura tutarı denkleştirme tutarından büyükse fatura geri çekilir, denkl.tutarı kadar düşülüp tekrar yollanır
                        IF <fs_t016>-amount GT lv_amount.

                          APPEND INITIAL LINE TO lt_invoices ASSIGNING FIELD-SYMBOL(<fs_invoices>).
                          <fs_invoices> = CORRESPONDING #( <fs_t016> ).
                          delete_invoice(  CHANGING ct_invoices =  lt_invoices ).
                          READ TABLE lt_invoices TRANSPORTING NO FIELDS WITH KEY invoice_number = <fs_t016>-invoice_number
                                                                                 message = 'Fatura Geri Alındı'.
                          IF sy-subrc EQ 0.
                            send_invoice( EXPORTING iv_clr_amount = ( <fs_t016>-amount - lv_amount )
                                          CHANGING  ct_invoices   = lt_invoices ).
                            lv_amount = 0.
                          ENDIF.

                          "Fatura tutarı denkltutarına eşitse o fatura geri çekilir başka işlem yapılmaz
                        ELSEIF <fs_t016>-amount EQ lv_amount.

                          APPEND INITIAL LINE TO lt_invoices ASSIGNING <fs_invoices>.
                          <fs_invoices> = CORRESPONDING #( <fs_t016> ).
                          delete_invoice(  CHANGING ct_invoices =  lt_invoices ).
                          READ TABLE lt_invoices TRANSPORTING NO FIELDS WITH KEY invoice_number = <fs_t016>-invoice_number
                                                                                 message = 'Fatura Geri Alındı'.
                          IF sy-subrc EQ 0.
                            lv_amount = 0.
                          ENDIF.

                          "Fatura tutarı denkl.tutarından küçükse o fatura geri çekilir, denkleştirme tutarı 0 olana kadar kontrol devam eder
                        ELSEIF <fs_t016>-amount LT lv_amount.

                          APPEND INITIAL LINE TO lt_invoices ASSIGNING <fs_invoices>.
                          <fs_invoices> = CORRESPONDING #( <fs_t016> ).
                          delete_invoice(  CHANGING ct_invoices =  lt_invoices ).
                          READ TABLE lt_invoices TRANSPORTING NO FIELDS WITH KEY invoice_number = <fs_t016>-invoice_number
                                                                                 message = 'Fatura Geri Alındı'.
                          IF sy-subrc EQ 0.
                            lv_amount -= <fs_t016>-amount.
                          ENDIF.

                        ENDIF.

                      ENDIF.

                    ENDLOOP.

                  ENDIF.

                  <fs_tmp>-amount_in_transaction_curr = lv_remaining.
                  <fs_denkl>-amount_in_transaction_curr = 0.
                  APPEND INITIAL LINE TO lt_invoices_final ASSIGNING <fs_final>.
                  <fs_final> = CORRESPONDING #( <fs_tmp> ).

                ELSE."denkleştirme tutarı esas belge tutarını tam karşılamış, esas belgenin bankaya gönderilmesine gerek yok
                  <fs_denkl>-amount_in_transaction_curr = abs( lv_remaining )."Denkleştirme belgesi birden fazla belgeye ait olabilir,
                  "                                                           "sonraki satırlar için tutar kontrolüne devam
                ENDIF.

                CLEAR: lv_remaining.

              ENDIF.

            ELSE.

              APPEND INITIAL LINE TO lt_invoices_final ASSIGNING <fs_final>.
              <fs_final> = CORRESPONDING #( <fs_tmp> ).

            ENDIF.

          ENDIF.

        ENDIF.

      ENDIF.

    ENDLOOP.

    ct_invoices = lt_invoices_final.

  ENDMETHOD.


  METHOD limits_and_invoices.

    DATA: lv_transaction_amount TYPE I_OperationalAcctgDocItem-AmountInTransactionCurrency,
          lv_companycode_amount TYPE I_OperationalAcctgDocItem-AmountInCompanyCodeCurrency.

    DATA: lt_bussinespartner LIKE it_businesspartner,
          lt_limit           TYPE zarete_dbs_sc_finteo_api=>ty_limit.

*    get_limit_data( EXPORTING iv_behavior = abap_true IMPORTING et_limit = lt_limit ).

    LOOP AT it_businesspartner ASSIGNING FIELD-SYMBOL(<fs_bp>) .
      APPEND VALUE #( businesspartner = |{ <fs_bp>-businesspartner  ALPHA = OUT }|
                      companycode = <fs_bp>-companycode ) TO lt_bussinespartner.
    ENDLOOP.

    IF it_businesspartner IS NOT INITIAL.

*Customer Balance
      SELECT *
        FROM zdd_b2b_cari_sum
        FOR ALL ENTRIES IN @it_businesspartner
        WHERE Customer EQ @it_businesspartner-businesspartner
        INTO TABLE @DATA(lt_cari).                 "#EC CI_NO_TRANSFORM

*Limit
      SELECT t012~bp_no,
             t012~company_code,
             t013~partycode,
             t013~partytitle,
             t013~limit,
             t013~activelimit,
             t013~pendinginvoicecount,
             t013~pendinginvoiceamount,
             t013~bankcode,
             t013~bankname,
             t013~currencycode,
             t013~isactive,
             t013~fundedexposure
        FROM zarete_dbs_t012 WITH PRIVILEGED ACCESS AS t012
        INNER JOIN zarete_dbs_t013 WITH PRIVILEGED ACCESS AS t013 ON t012~company_identifier EQ t013~identifier
                                                                 AND t012~limit_id EQ t013~limitid
        FOR ALL ENTRIES IN @lt_bussinespartner
        WHERE t012~company_code EQ @lt_bussinespartner-companycode
        AND   t012~bp_no EQ @lt_bussinespartner-businesspartner
        INTO TABLE @DATA(lt_limits).

*Invoices
      SELECT t017~company_code,
             t017~customer,
             t017~document_reference_id,
             t017~amount_in_transaction_curr,
             t017~transaction_currency,
             t017~accounting_document_type,
             t015~is_cancelled,
             t015~invoice_number,
             t015~id
        FROM zarete_dbs_t017 AS t017
        INNER JOIN zarete_dbs_t015 AS t015 ON t015~invoice_number EQ t017~document_reference_id
                                          AND t015~invoice_acc_doc EQ t017~accounting_document
                                          AND t015~invoice_acc_doc_item EQ t017~accounting_document_item
        FOR ALL ENTRIES IN @lt_bussinespartner
        WHERE t017~company_code EQ @lt_bussinespartner-companycode
          AND t017~customer     EQ @lt_bussinespartner-businesspartner
          AND t017~accounting_document_type IN ( 'DR', 'RV' )
        INTO TABLE @DATA(lt_invoices).

      IF sy-subrc EQ 0.

        SELECT *                              "#EC CI_ALL_FIELDS_NEEDED
          FROM zarete_dbs_dd_invoice_001 WITH PRIVILEGED ACCESS
          FOR ALL ENTRIES IN @lt_invoices
          WHERE Id EQ @lt_invoices-id
          AND   InvoiceNumber EQ @lt_invoices-invoice_number
          INTO TABLE @DATA(lt_main_inv).           "#EC CI_NO_TRANSFORM

      ENDIF.


*VL10C Hariç Tutulacak Cariler
      SELECT customer
        FROM zarete_dbs_t025
        INTO TABLE @DATA(lt_t025).                      "#EC CI_NOWHERE

    ENDIF.

    DATA(lt_currency) = lt_limits.
    SORT lt_currency BY currencycode.
    DELETE ADJACENT DUPLICATES FROM lt_currency COMPARING currencycode.

    LOOP AT it_businesspartner ASSIGNING <fs_bp>.

      DATA(lv_bp) = CONV kunnr( |{ <fs_bp>-businesspartner  ALPHA = OUT }| ).
      DATA(lv_bp_in) = CONV kunnr( |{ <fs_bp>-businesspartner  ALPHA = IN }| ).
      READ TABLE lt_t025 ASSIGNING FIELD-SYMBOL(<fs_t025>) WITH KEY customer = lv_bp.
      IF sy-subrc EQ 0.
        APPEND INITIAL LINE TO et_finallimit ASSIGNING FIELD-SYMBOL(<fs_finallimit>).
        <fs_finallimit>-customer = <fs_bp>-businesspartner.
        <fs_finallimit>-companycode = <fs_bp>-companycode.
        <fs_finallimit>-companycodecurrency = 'TRY'.
        <fs_finallimit>-amountincompanycodecurrency = '500000000.00'.
      ELSE.
        READ TABLE lt_t025 ASSIGNING <fs_t025> WITH KEY customer = lv_bp_in.
        IF sy-subrc EQ 0.
          APPEND INITIAL LINE TO et_finallimit ASSIGNING <fs_finallimit>.
          <fs_finallimit>-customer = <fs_bp>-businesspartner.
          <fs_finallimit>-companycode = <fs_bp>-companycode.
          <fs_finallimit>-companycodecurrency = 'TRY'.
          <fs_finallimit>-amountincompanycodecurrency = '500000000.00'.
        ELSE.

          LOOP AT lt_currency ASSIGNING FIELD-SYMBOL(<fs_currency>).

            APPEND INITIAL LINE TO et_finallimit ASSIGNING <fs_finallimit>.

            DATA(lv_total_limit) = REDUCE #( INIT limit TYPE dmbtr
                                   FOR ls_limit IN lt_limits
                                   WHERE ( bp_no = lv_bp
                                   AND     company_code = <fs_bp>-companycode
                                   AND     currencycode = <fs_currency>-currencycode
                                   AND     isactive EQ abap_true )
                                   NEXT limit = limit + ls_limit-activelimit ).

            DATA(lv_cari_bakiye) = REDUCE #( INIT balance TYPE dmbtr
                                   FOR ls_cari IN lt_cari
                                   WHERE ( Customer = <fs_bp>-businesspartner )
                                   NEXT balance = balance + ls_cari-Cari ).

            DATA(lv_cari_bakiye_eur) = REDUCE #( INIT balance TYPE dmbtr
                                   FOR ls_cari IN lt_cari
                                   WHERE ( Customer = <fs_bp>-businesspartner )
                                   NEXT balance = balance + ls_cari-CariEUR ).

            DATA(lv_cari_bakiye_usd) = REDUCE #( INIT balance TYPE dmbtr
                                   FOR ls_cari IN lt_cari
                                   WHERE ( Customer = <fs_bp>-businesspartner )
                                   NEXT balance = balance + ls_cari-CariUSD ).


            IF <fs_currency>-currencycode EQ 'TRY' AND lv_cari_bakiye LE 0.
              lv_total_limit = lv_total_limit - lv_cari_bakiye.
            ELSEIF <fs_currency>-currencycode EQ 'EUR' AND lv_cari_bakiye_eur LE 0.
              lv_total_limit = lv_total_limit - lv_cari_bakiye_eur.
            ELSEIF <fs_currency>-currencycode EQ 'USD' AND lv_cari_bakiye_usd LE 0.
              lv_total_limit = lv_total_limit - lv_cari_bakiye_usd.
            ENDIF.

*            DATA(lv_fatura_total) = REDUCE #( INIT amount TYPE dmbtr
*                                    FOR ls_main_inv IN lt_main_inv
*                                    WHERE ( Customer = lv_bp
*                                    AND     Currency = <fs_currency>-currencycode )
*                                    NEXT amount = amount + ( ls_main_inv-RemainingAmount ) ).

            DATA(lv_fatura_total) = REDUCE #( INIT amount TYPE dmbtr
                                    FOR ls_main_inv IN lt_main_inv
                                    WHERE ( Customer = lv_bp
                                    AND     Currency = <fs_currency>-currencycode )
                                    NEXT amount = amount + ( COND #( WHEN ls_main_inv-Amount - ls_main_inv-AggAmount - ls_main_inv-UsedAmountForClearing LT 0 THEN 0
                                                                     ELSE ls_main_inv-Amount - ls_main_inv-AggAmount - ls_main_inv-UsedAmountForClearing ) ) ).

            lv_total_limit = lv_total_limit - lv_fatura_total.

            <fs_finallimit>-customer = <fs_bp>-businesspartner.
            <fs_finallimit>-companycode = <fs_bp>-companycode.
            <fs_finallimit>-companycodecurrency = <fs_currency>-currencycode.
            <fs_finallimit>-amountincompanycodecurrency = lv_total_limit.

          ENDLOOP.

          CLEAR: lv_total_limit, lv_fatura_total, lv_cari_bakiye, lv_cari_bakiye_eur, lv_cari_bakiye_usd.

        ENDIF.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.


  METHOD delivery_limit_control.

    DATA: lv_delivery TYPE zwm_de_char10,
          lv_bpno     TYPE zarete_dbs_t013-partycode,
          lv_tutar    TYPE dmbtr,
          lt_limit    TYPE zarete_dbs_sc_finteo_api=>ty_limit.

    lv_delivery = |{ iv_delivery ALPHA = IN }|.

    "teslimat no ile teslimat tutarı ve müşteri no alınacak

    get_limit_data( EXPORTING iv_behavior = ' ' IMPORTING et_limit = lt_limit ).

    DATA(lv_cari_limit) = REDUCE #( INIT limit TYPE zarete_dbs_dd_t013-Activelimit
                                    FOR ls_limit IN lt_limit-data
                                    WHERE ( partycode = lv_bpno )
                                    NEXT limit = limit + ls_limit-activelimit  ).

    IF lv_tutar GT lv_cari_limit.
      ev_message = 'Cari limiti teslimat tutarı için yetersiz!'.
      ev_msgtype = 'E'.
    ELSE.
      ev_message = 'Cari limiti teslimat tutarı için yeterli.'.
      ev_msgtype = 'S'.
    ENDIF.

  ENDMETHOD.


  METHOD get_documents_for_clearing.

    DATA: lt_t033_create TYPE TABLE FOR CREATE zarete_dbs_dd_t033,
          lt_t033_update TYPE TABLE FOR UPDATE zarete_dbs_dd_t033,
          lr_type        TYPE RANGE OF zarete_dbs_dd_doc_read_001-accounting_document_type.

    APPEND VALUE #( sign = 'I' option = 'EQ' low = 'DR' ) TO lr_type.
    APPEND VALUE #( sign = 'I' option = 'EQ' low = 'DZ' ) TO lr_type.
    APPEND VALUE #( sign = 'I' option = 'EQ' low = 'RV' ) TO lr_type.

    READ ENTITIES OF zarete_dbs_dd_doc_read_001
    ENTITY zarete_dbs_dd_doc_read_001
    ALL FIELDS WITH VALUE #( (  ) )
    RESULT DATA(lt_sap_invoices).

    DATA(lt_sap_invoices_tmp) = lt_sap_invoices.

    DELETE lt_sap_invoices WHERE debit_credit_code NE 'H'.
    DELETE lt_sap_invoices WHERE accounting_document_type IN lr_type.
    DELETE lt_sap_invoices WHERE accounting_document_type EQ 'TK'.

    IF lt_sap_invoices IS NOT INITIAL.
      SELECT *
        FROM zarete_dbs_dd_t033
        FOR ALL ENTRIES IN @lt_sap_invoices
        WHERE CompanyCode EQ @lt_sap_invoices-company_code
        AND   FiscalYear  EQ @lt_sap_invoices-fiscal_year
        AND   AccountingDocument EQ @lt_sap_invoices-accounting_document
        AND   AccountingDocumentItem EQ @lt_sap_invoices-accounting_document_item
        INTO TABLE @DATA(lt_t033).            "#EC CI_ALL_FIELDS_NEEDED
    ENDIF.

    LOOP AT lt_sap_invoices ASSIGNING FIELD-SYMBOL(<fs_invoices>).

      IF <fs_invoices>-customer IS NOT INITIAL.

        READ TABLE lt_t033 ASSIGNING FIELD-SYMBOL(<fs_t033>) WITH KEY CompanyCode = <fs_invoices>-company_code
                                                                      FiscalYear  = <fs_invoices>-fiscal_year
                                                                      AccountingDocument = <fs_invoices>-accounting_document
                                                                      AccountingDocumentItem = <fs_invoices>-accounting_document_item.

        IF sy-subrc EQ 0.
          APPEND INITIAL LINE TO lt_t033_update ASSIGNING FIELD-SYMBOL(<fs_t033_update>).
          <fs_t033_update>-CompanyCode                      = <fs_t033>-CompanyCode.
          <fs_t033_update>-FiscalYear                       = <fs_t033>-FiscalYear.
          <fs_t033_update>-AccountingDocument               = <fs_t033>-AccountingDocument.
          <fs_t033_update>-AccountingDocumentItem           = <fs_t033>-AccountingDocumentItem.
          <fs_t033_update>-NetDueDate                       = <fs_invoices>-net_due_date.
          <fs_t033_update>-Reverse                          = ''.
          <fs_t033_update>-%control-NetDueDate              = if_abap_behv=>mk-on.
          <fs_t033_update>-%control-Reverse                 = if_abap_behv=>mk-on.

        ELSE.
          APPEND INITIAL LINE TO lt_t033_create ASSIGNING FIELD-SYMBOL(<fs_t033_create>).
          <fs_t033_create>-CompanyCode                      = <fs_invoices>-company_code.
          <fs_t033_create>-FiscalYear                       = <fs_invoices>-fiscal_year.
          <fs_t033_create>-AccountingDocument               = <fs_invoices>-accounting_document.
          <fs_t033_create>-AccountingDocumentItem           = <fs_invoices>-accounting_document_item.
          <fs_t033_create>-Customer                         = |{ <fs_invoices>-customer ALPHA = OUT }|.
          <fs_t033_create>-CustomerName                     = <fs_invoices>-customer_name.
          <fs_t033_create>-PostingDate                      = <fs_invoices>-posting_date.
          <fs_t033_create>-DocumentDate                     = <fs_invoices>-document_date.
          <fs_t033_create>-NetDueDate                       = <fs_invoices>-net_due_date.
          <fs_t033_create>-AccountingDocumentType           = <fs_invoices>-accounting_document_type.
          <fs_t033_create>-AmountInTransactionCurr          = abs( <fs_invoices>-amount_in_transaction_curr ).
          <fs_t033_create>-TransactionCurrency              = <fs_invoices>-transaction_currency.
          <fs_t033_create>-UsedAmount                       = 0.
          <fs_t033_create>-AvailableAmount                  = abs( <fs_invoices>-amount_in_transaction_curr ).
          <fs_t033_create>-%control-CompanyCode             = if_abap_behv=>mk-on.
          <fs_t033_create>-%control-FiscalYear              = if_abap_behv=>mk-on.
          <fs_t033_create>-%control-AccountingDocument      = if_abap_behv=>mk-on.
          <fs_t033_create>-%control-AccountingDocumentItem  = if_abap_behv=>mk-on.
          <fs_t033_create>-%control-Customer                = if_abap_behv=>mk-on.
          <fs_t033_create>-%control-CustomerName            = if_abap_behv=>mk-on.
          <fs_t033_create>-%control-PostingDate             = if_abap_behv=>mk-on.
          <fs_t033_create>-%control-DocumentDate            = if_abap_behv=>mk-on.
          <fs_t033_create>-%control-NetDueDate              = if_abap_behv=>mk-on.
          <fs_t033_create>-%control-AccountingDocumentType  = if_abap_behv=>mk-on.
          <fs_t033_create>-%control-AmountInTransactionCurr = if_abap_behv=>mk-on.
          <fs_t033_create>-%control-TransactionCurrency     = if_abap_behv=>mk-on.
          <fs_t033_create>-%control-UsedAmount              = if_abap_behv=>mk-on.
          <fs_t033_create>-%control-AvailableAmount         = if_abap_behv=>mk-on.

        ENDIF.

      ENDIF.

    ENDLOOP.

    MODIFY ENTITIES OF zarete_dbs_dd_t033 ENTITY zarete_dbs_dd_t033
    CREATE AUTO FILL CID WITH lt_t033_create
    MAPPED DATA(lt_mapped_t033_cr)
    FAILED DATA(lt_failed_t033_cr)
    REPORTED DATA(lt_reported_t033_cr).

    MODIFY ENTITIES OF zarete_dbs_dd_t033 ENTITY zarete_dbs_dd_t033
    UPDATE FIELDS ( NetDueDate ) WITH lt_t033_update
    MAPPED DATA(lt_mapped_t033_up)
    FAILED DATA(lt_failed_t033_up)
    REPORTED DATA(lt_reported_t033_up).

    IF cl_abap_behv_aux=>get_current_handler_kind( ) IS INITIAL.
      COMMIT ENTITIES RESPONSE OF zarete_dbs_dd_t033
      FAILED DATA(lt_failed_t033_co)
      REPORTED DATA(lt_reported_t033_co).
    ENDIF.

    CLEAR lr_type.
    APPEND VALUE #( sign = 'I' option = 'EQ' low = 'TK' ) TO lr_type.
    DELETE lt_sap_invoices_tmp WHERE accounting_document_type NOT IN lr_type.

    LOOP AT lt_sap_invoices_tmp ASSIGNING <fs_invoices>.

      UPDATE zarete_dbs_t015
        SET accounting_document = ''
        WHERE accounting_document = @<fs_invoices>-accounting_document.

      UPDATE zarete_dbs_t015
        SET clearing_document = ''
        WHERE clearing_document = @<fs_invoices>-accounting_document.

      UPDATE zarete_dbs_t020
        SET reverse = 'X'
        WHERE accounting_document = @<fs_invoices>-accounting_document
        AND   company_code = @<fs_invoices>-company_code
        AND   fiscal_year = @<fs_invoices>-fiscal_year.

      SELECT SINGLE *
        FROM zarete_dbs_t022
        WHERE accounting_document = @<fs_invoices>-accounting_document
        AND   accounting_document_item = @<fs_invoices>-accounting_document_item
        AND   company_code = @<fs_invoices>-company_code
        AND   fiscal_year = @<fs_invoices>-fiscal_year
        INTO @DATA(ls_t022).
      IF sy-subrc EQ 0.
        ls_t022-reverse = 'X'.
        ls_t022-available_amount = ls_t022-amount_in_transaction_curr.
        ls_t022-used_amount = 0.
        CLEAR: ls_t022-message, ls_t022-status.
        MODIFY zarete_dbs_t022 FROM @ls_t022.
      ENDIF.

      UPDATE zarete_dbs_t023
        SET reverse = 'X'
        WHERE clearing_document = @<fs_invoices>-accounting_document
        AND   company_code = @<fs_invoices>-company_code
        AND   fiscal_year = @<fs_invoices>-fiscal_year.

      UPDATE zarete_dbs_t024
        SET reverse = 'X'
        WHERE accounting_document = @<fs_invoices>-accounting_document
        AND   accounting_document_item = @<fs_invoices>-accounting_document_item.

      UPDATE zarete_dbs_t024
        SET reverse = 'X'
        WHERE created_clearing_document = @<fs_invoices>-accounting_document
        AND   clearing_company_code = @<fs_invoices>-company_code
        AND   clearing_fiscal_year  = @<fs_invoices>-fiscal_year.

      IF cl_abap_behv_aux=>get_current_handler_kind( ) IS INITIAL.
        COMMIT WORK AND WAIT.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.


  METHOD clearing_mapping.

    TYPES: ty_customer TYPE zarete_dbs_t022-customer,
           tt_customer TYPE STANDARD TABLE OF ty_customer WITH EMPTY KEY.

    DATA: lt_in_tab    TYPE cl_abap_parallel=>t_in_inst_tab,
          lt_out_tab   TYPE cl_abap_parallel=>t_out_inst_tab,
          lt_customers TYPE tt_customer,
          lv_itemno    TYPE zfi_denk_business_transaction VALUE '1',
          lt_t024      TYPE TABLE OF zarete_dbs_t024,
          lv_remaining TYPE zarete_dbs_t017-amount_in_transaction_curr.

    DATA(ls_request) = VALUE zfi_denk_journal_entry_bulk_cl( ).

    TRY.
        DATA(lv_uuid) = cl_system_uuid=>create_uuid_c32_static( ).
        REPLACE ALL OCCURRENCES OF '-' IN lv_uuid WITH ''.
      CATCH cx_uuid_error INTO DATA(lo_error).
        DATA(lv_longtext) = lo_error->get_longtext( ).
    ENDTRY.

    lt_customers = VALUE #(
      FOR GROUPS <group_key> OF <ls_clearing> IN it_clearing_documents
      GROUP BY <ls_clearing>-customer
      ( <group_key> )
    ).

    DATA: lv_timestamp TYPE timestampl.
    GET TIME STAMP FIELD lv_timestamp.

    DATA(lt_clearing_tmp) = it_clearing_documents.
    SORT lt_clearing_tmp BY customer accounting_document1.
    DELETE ADJACENT DUPLICATES FROM lt_clearing_tmp COMPARING customer accounting_document1.

*Message Header Verileri
    ls_request-journal_entry_bulk_clearing_re-message_header-id-content                = lv_uuid.
    ls_request-journal_entry_bulk_clearing_re-message_header-uuid-content              = lv_uuid.
    ls_request-journal_entry_bulk_clearing_re-message_header-creation_date_time        = lv_timestamp.
    ls_request-journal_entry_bulk_clearing_re-message_header-sender_business_system_id = 'EXT_SYS'.

*Clearing Request Journal Entry
    LOOP AT lt_customers ASSIGNING FIELD-SYMBOL(<fs_customers>).

      LOOP AT lt_clearing_tmp ASSIGNING FIELD-SYMBOL(<fs_clearing_tmp>) WHERE customer EQ <fs_customers>.

        TRY.
            DATA(lv_item_uuid) = cl_system_uuid=>create_uuid_c32_static( ).
            REPLACE ALL OCCURRENCES OF '-' IN lv_uuid WITH ''.
          CATCH cx_uuid_error INTO lo_error.
            lv_longtext = lo_error->get_longtext( ).
        ENDTRY.

*Clearing Request
        APPEND INITIAL LINE TO ls_request-journal_entry_bulk_clearing_re-journal_entry_clearing_request
        ASSIGNING FIELD-SYMBOL(<fs_clearing_request>).
        <fs_clearing_request>-message_header-id-content         = lv_item_uuid.
        <fs_clearing_request>-message_header-uuid-content       = lv_item_uuid.
        <fs_clearing_request>-message_header-creation_date_time = lv_timestamp.

        <fs_clearing_request>-journal_entry-company_code             = '1000'.
        <fs_clearing_request>-journal_entry-accounting_document_type = 'DZ'.
        <fs_clearing_request>-journal_entry-document_date            = cl_abap_context_info=>get_system_date( ).
        <fs_clearing_request>-journal_entry-posting_date             = cl_abap_context_info=>get_system_date( ).
        <fs_clearing_request>-journal_entry-currency_code            = <fs_clearing_tmp>-currency.
        <fs_clearing_request>-journal_entry-reference_document       = <fs_clearing_tmp>-invoice_number.
        <fs_clearing_request>-journal_entry-document_header_text     = |{ <fs_clearing_tmp>-invoice_number } { 'DNK.' }|.
        <fs_clearing_request>-journal_entry-created_by_user          = sy-uname.

*Denkleştirme belgelerinin toplam tutarı
        DATA(lv_denk_toplam) = REDUCE #( INIT tutar TYPE dmbtr
                                         FOR ls_data IN it_clearing_documents
                                         WHERE ( customer EQ <fs_clearing_tmp>-customer
                                         AND     accounting_document1 EQ <fs_clearing_tmp>-accounting_document1 )
                                         NEXT tutar = tutar + ls_data-amount ).

        DATA(lv_denk_toplam_abs) = REDUCE #( INIT tutar TYPE dmbtr
                                         FOR ls_data IN it_clearing_documents
                                         WHERE ( customer EQ <fs_clearing_tmp>-customer
                                         AND     accounting_document1 EQ <fs_clearing_tmp>-accounting_document1 )
                                         NEXT tutar = tutar + abs( ls_data-amount ) ).

        READ TABLE it_clearing_documents ASSIGNING FIELD-SYMBOL(<fs_docs>) WITH KEY accounting_document1 = <fs_clearing_tmp>-accounting_document1.


        APPEND INITIAL LINE TO <fs_clearing_request>-journal_entry-aparitems ASSIGNING FIELD-SYMBOL(<fs_aparitems>).
        <fs_aparitems>-reference_document_item  = lv_itemno.
        <fs_aparitems>-company_code             = '1000'.
        <fs_aparitems>-account_type             = 'D'.
        <fs_aparitems>-aparaccount              = |{ <fs_clearing_tmp>-customer ALPHA = OUT }|.
        <fs_aparitems>-fiscal_year              = <fs_clearing_tmp>-due_date+0(4).
        <fs_aparitems>-accounting_document      = <fs_clearing_tmp>-accounting_document1.
        <fs_aparitems>-accounting_document_item = <fs_clearing_tmp>-accounting_document_item1.

        SELECT SINGLE *                       "#EC CI_ALL_FIELDS_NEEDED
          FROM zarete_dbs_dd_invoice_001 WITH PRIVILEGED ACCESS
          WHERE InvoiceAccountingDocument EQ @<fs_clearing_tmp>-accounting_document1
          AND   InvoiceNumber EQ @<fs_clearing_tmp>-invoice_number
          INTO @DATA(ls_main_inv).

*        DATA(lv_amount) = COND #( WHEN ls_main_inv-RemainingAmount IS NOT INITIAL THEN ls_main_inv-RemainingAmount
*                                  ELSE ls_main_inv-SendAmount  ) .

        DATA(lv_amount) = ls_main_inv-Amount.

*        IF lv_denk_toplam_abs LT lv_amount OR ( ls_main_inv-Amount - ls_main_inv-UsedAmountForClearing ) EQ abs( lv_denk_toplam ).
*        IF lv_denk_toplam_abs LT lv_amount.
        IF ( ls_main_inv-Amount - ls_main_inv-UsedAmountForClearing ) GT 0 AND lv_amount NE lv_denk_toplam_abs.
          <fs_aparitems>-partial_payment_amt_in_dsp_crc-content       = ls_main_inv-Amount.
          <fs_aparitems>-partial_payment_amt_in_dsp_crc-currency_code = <fs_clearing_tmp>-Currency.
        ENDIF.

        lv_remaining = lv_amount.

        LOOP AT it_clearing_documents ASSIGNING FIELD-SYMBOL(<fs_clearing_documents>) WHERE accounting_document1 EQ <fs_clearing_tmp>-accounting_document1.

          IF <fs_clearing_documents>-amount GT 0.
            lv_remaining += <fs_clearing_documents>-amount.
          ELSE.
            lv_remaining -= abs( <fs_clearing_documents>-amount ).
          ENDIF.

          APPEND INITIAL LINE TO <fs_clearing_request>-journal_entry-aparitems ASSIGNING <fs_aparitems>.
          lv_itemno += 1.
          CONDENSE lv_itemno.
          <fs_aparitems>-reference_document_item  = lv_itemno.
          <fs_aparitems>-company_code             = '1000'.
          <fs_aparitems>-account_type             = 'D'.
          <fs_aparitems>-aparaccount              = |{ <fs_clearing_documents>-customer ALPHA = OUT }|.
          <fs_aparitems>-fiscal_year              = <fs_clearing_documents>-fiscal_year.
          <fs_aparitems>-accounting_document      = <fs_clearing_documents>-accounting_document2.
          <fs_aparitems>-accounting_document_item = <fs_clearing_documents>-accounting_document_item2.

          IF lv_remaining LT 0.
            <fs_aparitems>-partial_payment_amt_in_dsp_crc-content       = abs( <fs_clearing_documents>-amount ) - abs( lv_remaining ).
            <fs_aparitems>-partial_payment_amt_in_dsp_crc-currency_code = <fs_clearing_tmp>-Currency.
          ENDIF.

*Denkleştirme için gönderilen belgeler takip tablosunun doldurulması
          APPEND INITIAL LINE TO lt_t024 ASSIGNING FIELD-SYMBOL(<fs_t024>).
          <fs_t024>-client                         = sy-mandt.
          <fs_t024>-uuid                           = lv_uuid.
          <fs_t024>-item_uuid                      = lv_item_uuid.
          <fs_t024>-invoice_number                 = <fs_clearing_tmp>-invoice_number.
          <fs_t024>-id                             = <fs_clearing_tmp>-id.
          <fs_t024>-accounting_document            = <fs_clearing_documents>-accounting_document2.
          <fs_t024>-accounting_document_item       = <fs_clearing_documents>-accounting_document_item2.
          <fs_t024>-invoice_acc_doc                = <fs_clearing_documents>-accounting_document1.
          <fs_t024>-invoice_acc_doc_item           = <fs_clearing_documents>-accounting_document_item1.
          <fs_t024>-customer                       = <fs_clearing_tmp>-customer.
          <fs_t024>-invoice_amount                 = ls_main_inv-RemainingAmount.
          <fs_t024>-clearing_doc_amount            = abs( <fs_clearing_documents>-amount ).
          <fs_t024>-used_amount                    = COND #( WHEN lv_remaining GE 0 THEN abs( <fs_clearing_documents>-amount )
                                                             ELSE abs( <fs_clearing_documents>-amount ) - abs( lv_remaining ) ).
          <fs_t024>-currency                       = <fs_clearing_tmp>-currency.
          <fs_t024>-message                        = 'Denkleştirme İşleniyor.'.
          <fs_t024>-status                         = 'B'.
          <fs_t024>-response_date                  = cl_abap_context_info=>get_system_date( ).
          <fs_t024>-response_time                  = cl_abap_context_info=>get_system_time( ).

        ENDLOOP.

        lv_itemno = 1.

      ENDLOOP.

    ENDLOOP.

    DATA(lo_parallel) = NEW cl_abap_parallel( ).
    DATA(lo_modify) = NEW zcl_fi_denk_modify( ).

    lo_modify->input = lt_t024.
    APPEND lo_modify TO lt_in_tab.
    lo_parallel->run_inst( EXPORTING p_in_tab  = lt_in_tab  IMPORTING p_out_tab = lt_out_tab ).

    es_request = ls_request.

  ENDMETHOD.


  METHOD clearing.

    TYPES: BEGIN OF ty_customer,
             customer TYPE zarete_dbs_t022-customer,
             currency TYPE zarete_dbs_t022-transaction_currency,
           END OF ty_customer,
           tt_customer TYPE STANDARD TABLE OF ty_customer WITH EMPTY KEY.

    TYPES: BEGIN OF ty_zpdz,
             invoice_number TYPE zarete_dbs_t015-invoice_number,
             amount         TYPE dmbtr,
           END OF ty_zpdz,
           tt_zpdz TYPE STANDARD TABLE OF ty_zpdz WITH EMPTY KEY.

    DATA: ls_request            TYPE  zfi_denk_journal_entry_bulk_cl,
          lt_in_tab             TYPE cl_abap_parallel=>t_in_inst_tab,
          lt_out_tab            TYPE cl_abap_parallel=>t_out_inst_tab,
          lt_customers          TYPE tt_customer,
          lt_zpdz               TYPE tt_zpdz,
          lt_header             TYPE tt_header,
          lr_customer           TYPE RANGE OF kunnr,
          lr_types              TYPE RANGE OF zarete_dbs_t005-belge_turu,
          lr_types2             TYPE RANGE OF zarete_dbs_t005-belge_turu,
          lv_odm_total          TYPE dmbtr,
          lv_dz_total           TYPE dmbtr,
          lv_zpdz_total         TYPE dmbtr,
          lt_limit              TYPE zarete_dbs_sc_finteo_api=>ty_limit,
          lv_acc_doc            TYPE zarete_dbs_dd_t043-AccountingDocument,
          lv_AccountingDocument TYPE zarete_dbs_dd_t043-AccountingDocument.

    get_limit_data( EXPORTING iv_behavior = abap_true IMPORTING et_limit = lt_limit ).

    DATA(lo_util) = NEW zarete_dbs_cl_utility( ).
    DATA(lo_parallel) = NEW cl_abap_parallel( ).
    DATA(lo_denk) = NEW zcl_fi_denk_parallel( ).
    DATA(lo_log) = zarete_dbs_cl_log=>get_factory( ).

    lt_customers = VALUE #(
                 FOR GROUPS <group_key> OF <ls_invoices> IN ct_invoices
                 GROUP BY ( customer = <ls_invoices>-customer
                            currency = <ls_invoices>-currency )
                 ASCENDING
                 ( customer = <group_key>-customer
                   currency = <group_key>-currency ) ).

    LOOP AT lt_customers ASSIGNING FIELD-SYMBOL(<fs_customers>).
      IF <fs_customers> IS NOT INITIAL.
        APPEND VALUE #( sign = 'I' option = 'EQ' low = |{ <fs_customers>-customer ALPHA = IN }| ) TO lr_customer.
      ENDIF.
    ENDLOOP.

    APPEND VALUE #( sign = 'I' option = 'EQ' low = 'DR' ) TO lr_types.
    APPEND VALUE #( sign = 'I' option = 'EQ' low = 'RV' ) TO lr_types.
    APPEND VALUE #( sign = 'I' option = 'EQ' low = 'KT' ) TO lr_types.


    APPEND VALUE #( sign = 'I' option = 'EQ' low = 'DR' ) TO lr_types2.
    APPEND VALUE #( sign = 'I' option = 'EQ' low = 'RV' ) TO lr_types2.
    APPEND VALUE #( sign = 'I' option = 'EQ' low = 'DZ' ) TO lr_types2.
    APPEND VALUE #( sign = 'I' option = 'EQ' low = 'KT' ) TO lr_types2.

    IF ct_invoices IS NOT INITIAL.

      SELECT *                                "#EC CI_ALL_FIELDS_NEEDED
        FROM zarete_dbs_dd_invoice_001 WITH PRIVILEGED ACCESS
        FOR ALL ENTRIES IN @ct_invoices
        WHERE Id EQ @ct_invoices-id
        AND   InvoiceNumber EQ @ct_invoices-invoice_number
        INTO TABLE @DATA(lt_main_inv).

      SORT lt_main_inv BY Customer DocType DueDate InvoiceNumber.
      DELETE ADJACENT DUPLICATES FROM lt_main_inv COMPARING Customer DocType DueDate InvoiceNumber.

    ENDIF.

    SELECT *
      FROM zarete_dbs_dd_t043
      WHERE customer IN @lr_customer
*      AND   AccountingDocumentType NE 'UE'
      INTO TABLE @DATA(lt_t043).

*    IF lt_t043 IS NOT INITIAL.
*      SELECT * FROM zarete_dbs_dd_t043
*       WHERE customer IN @lr_customer
*         AND AccountingDocumentType = 'UE'
*         AND DebitCreditCode = 'H'
*       APPENDING TABLE @lt_t043.
*    ENDIF.

    SORT lt_t043 BY Customer AccountingDocumentType Kalan DESCENDING.
*    DELETE lt_t043 WHERE AccountingDocumentType NOT IN lr_types2 AND DebitCreditCode = 'S'.

    LOOP AT lt_customers ASSIGNING <fs_customers>.
      DATA(lv_customer_in) = |{ <fs_customers>-customer ALPHA = IN }|.

      CLEAR: lt_header, lt_in_tab, lt_out_tab, ls_request.

*Müşteri Bazlı header doldurulur
      APPEND INITIAL LINE TO lt_header ASSIGNING FIELD-SYMBOL(<fs_header>).
      <fs_header>-customer         = <fs_customers>-customer.
      <fs_header>-currency         = COND #( WHEN <fs_customers>-currency IS INITIAL THEN 'TRY' ELSE <fs_customers>-currency ).

      LOOP AT lt_main_inv ASSIGNING FIELD-SYMBOL(<fs_main_inv>) WHERE Customer EQ <fs_customers>-customer
                                                                AND   Currency EQ <fs_customers>-currency.

        " UE Belgeleri için eklendi !!! - (Eski Faturalar)
        IF <fs_main_inv>-DocumentDate IS INITIAL AND <fs_main_inv>-AccountingDocument IS NOT INITIAL
         AND <fs_main_inv>-DueDate LE cl_abap_context_info=>get_system_date( ).

          SELECT header~AccountingDocument,
                 header~CompanyCode,
                 header~AccountingDocumentType,
                 header~CompanyCodeCurrency,
                 item~GlAccount,
                 item~AmountInTransactionCurrency
          FROM I_JournalEntry WITH PRIVILEGED ACCESS AS header
          INNER JOIN I_JournalEntryItem AS item
             ON header~AccountingDocument = item~AccountingDocument
          WHERE customer = @lv_customer_in
            AND header~AccountingDocumentType = 'UE'
            AND item~DebitCreditCode = 'S'
          INTO TABLE @DATA(lt_journal).

          SELECT SINGLE * FROM I_JournalEntryItem
           WITH PRIVILEGED ACCESS
            WHERE AccountingDocument = @<fs_main_inv>-AccountingDocument
              AND ClearingJournalEntry IS INITIAL
               INTO @DATA(ls_journalentryitem).

          IF ls_journalentryitem IS NOT INITIAL.
            TRY.
                DATA(ls_journalentry) = lt_journal[ 1 ].
              CATCH  cx_sy_itab_line_not_found INTO DATA(lo_cx).
                DATA(lv_text) = lo_cx->get_longtext( ).
            ENDTRY.
          ENDIF.
        ENDIF.

        lv_accountingdocument = |{ <fs_main_inv>-InvoiceAccountingDocument ALPHA = IN }|.

        CLEAR: lv_acc_doc.
        lv_acc_doc = COND #( WHEN ls_journalentry-AccountingDocument IS NOT INITIAL THEN ls_journalentry-AccountingDocument
                              ELSE lv_accountingdocument ).

        IF <fs_customers>-currency IS NOT INITIAL.
          DATA(lv_currency) = <fs_customers>-currency.
        ELSE.
          lv_currency = 'TRY'.
        ENDIF.

        LOOP AT lt_t043 ASSIGNING FIELD-SYMBOL(<fs_t043>) WHERE AccountingDocument EQ lv_acc_doc.

          CLEAR: lv_odm_total, lv_dz_total.

          DATA(lv_faturalar_total) = REDUCE #( INIT amount TYPE zarete_dbs_de_finteo_amount
                                              FOR ls_main_inv IN lt_main_inv
                                              WHERE ( DocType IN lr_types
                                              AND     Customer EQ <fs_customers>-customer
                                              AND     Currency EQ lv_currency )
                                              NEXT amount = amount + ls_main_inv-Amount ).

          DATA(lv_faturadz_total) = REDUCE #( INIT amount TYPE zarete_dbs_de_finteo_amount
                                              FOR ls_t043 IN lt_t043
                                              WHERE (  AccountingDocumentType EQ 'DZ'
                                              AND     Customer EQ lv_customer_in
                                              AND     DebitCreditCode EQ 'H'
                                              AND     Currency EQ lv_currency )
                                              NEXT amount = amount + ls_t043-DocumentAmountAbs ).

          DATA(lv_odemeler_total) = REDUCE #( INIT amount TYPE zarete_dbs_de_finteo_amount
                                              FOR ls_t043 IN lt_t043
                                              WHERE ( AccountingDocumentType NOT IN lr_types
                                              AND     AccountingDocumentType NE 'DZ'
                                              AND     Customer EQ lv_customer_in
                                              AND     Currency EQ lv_currency )
                                              NEXT amount = amount + ls_t043-DocumentAmountAbs ).

          DATA(lv_denklestirmeler_total) = REDUCE #( INIT amount TYPE zarete_dbs_de_finteo_amount
                                                     FOR ls_t043 IN lt_t043
                                                     WHERE (  AccountingDocumentType EQ 'DZ'
                                                     AND     Customer EQ lv_customer_in
                                                     AND     DebitCreditCode EQ 'S'
                                                     AND     Currency EQ lv_currency )
                                                     NEXT amount = amount + ls_t043-DocumentAmountAbs ).

          IF lv_odemeler_total EQ 0. "Ödeme kalmadıysa yeni fatura kontrol edilmez

            lo_log->set_sapinvoiceno( iv_sapinvoiceno = <fs_main_inv>-InvoiceNumber
                                      iv_id           = <fs_main_inv>-Id ).
            lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                             msgno = '022'
                             msgtx = 'Ödeme Belgesi Bulunamadı' ).

            CONTINUE.
          ENDIF.

          DATA(lv_total) = CONV zarete_dbs_de_finteo_amount( lv_odemeler_total + lv_denklestirmeler_total ).

          IF lv_total EQ 0.
            CONTINUE.
          ENDIF.

          " Faturanın Denkleştirilecek Kalan Tutarı (Borç Tutarı)
          DATA(lv_inv_kalan) = COND #( WHEN <fs_t043>-Kalan IS NOT INITIAL AND ls_journalentry-AccountingDocumentType NE 'UE'
                                        THEN <fs_t043>-Kalan
                                       WHEN ls_journalentry-AccountingDocumentType = 'UE'
                                        THEN <fs_main_inv>-Amount
                                        ELSE <fs_t043>-DocumentAmount ).

          IF lv_inv_kalan EQ 0.
            CONTINUE. " Faturanın bakiyesi sıfırsa sonraki faturaya geç
          ENDIF.

          IF <fs_main_inv>-DbsInvoiceId IS NOT INITIAL AND <fs_main_inv>-DocumentDate IS NOT INITIAL.
            IF <fs_main_inv>-FinteoStatusCode EQ '6' OR <fs_main_inv>-FinteoStatusCode EQ '7'.
              lo_log->set_sapinvoiceno( iv_sapinvoiceno = <fs_main_inv>-InvoiceNumber
                                        iv_id           = <fs_main_inv>-Id ).
              lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                               msgno = '022'
                               msgtx = 'Fatura Tahsil Edilmiş' ).
              CONTINUE.
            ELSE.
              READ TABLE lt_limit-data ASSIGNING FIELD-SYMBOL(<fs_limit>) WITH KEY partycode    = <fs_customers>-customer
*                                                                                   currencycode = <fs_customers>-currency
                                                                                   bankcode     = <fs_main_inv>-HouseBank.

              IF sy-subrc EQ 0.
                DATA(lv_inv_result) = CONV dmbtr( lv_inv_kalan - lv_odemeler_total ).
*                IF lv_inv_kalan GT <fs_limit>-activelimit AND lv_inv_kalan GT lv_odemeler_total.
                IF lv_inv_result GT ( <fs_limit>-activelimit + lv_inv_kalan ).
                  lo_log->set_sapinvoiceno( iv_sapinvoiceno = <fs_main_inv>-InvoiceNumber
                                            iv_id           = <fs_main_inv>-Id ).
                  lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                                   msgno = '022'
                                   msgtx = 'Limit Yetersiz' ).
                  CONTINUE.
                ENDIF.
              ENDIF.
            ENDIF.
          ENDIF.

          DELETE <fs_header>-item WHERE accounting_document = <fs_t043>-AccountingDocument
                                    AND accounting_document_item = <fs_t043>-AccountingDocumentItem
                                    AND inv_type = 'F'.

          APPEND INITIAL LINE TO <fs_header>-item ASSIGNING FIELD-SYMBOL(<fs_fatura>).
          <fs_fatura>-accounting_document      = <fs_t043>-AccountingDocument.
          <fs_fatura>-accounting_document_item = <fs_t043>-AccountingDocumentItem.
          <fs_fatura>-currency                 = <fs_t043>-Currency.
          <fs_fatura>-fiscal_year              = <fs_t043>-FiscalYear.
          <fs_fatura>-inv_type                 = 'F'.
          APPEND INITIAL LINE TO <fs_header>-t024 ASSIGNING FIELD-SYMBOL(<fs_t024>).
          <fs_t024> = CORRESPONDING #( <fs_fatura> ).

          LOOP AT lt_t043 ASSIGNING FIELD-SYMBOL(<fs_t043_item>) WHERE Customer EQ lv_customer_in
                                                                 AND   Currency EQ lv_currency
                                                                 AND   AccountingDocumentType NOT IN lr_types
                                                                 AND   DocumentAmount NE 0.
            " Fatura tamamen kapatıldıysa bu fatura için kalem aramayı bitir
            IF lv_inv_kalan EQ 0.
              EXIT.
            ENDIF.

            IF <fs_t043_item>-kalan GT 0.
              IF <fs_t043_item>-DebitCreditCode EQ 'S'.
                <fs_t043_item>-DocumentAmount = <fs_t043_item>-kalan.
              ELSE.
                <fs_t043_item>-DocumentAmount = ( <fs_t043_item>-kalan * -1 ).
              ENDIF.
              <fs_t043_item>-DocumentAmountAbs = <fs_t043_item>-kalan.
              CLEAR: <fs_t043_item>-kalan.
            ENDIF.

*Senaryo 1 - Faturaya ait DZ belgeleri eklenir
            IF <fs_t043_item>-AccountingDocumentType = 'DZ' AND <fs_t043_item>-DebitCreditCode = 'H'
*            AND lv_inv_kalan = 0
            AND lv_inv_kalan LE lv_total.
*             AND lv_faturalar_total GE lv_faturadz_total.

              LOOP AT lt_t043 ASSIGNING FIELD-SYMBOL(<fs_t043_fatdz>)
*               WHERE InvoiceReference EQ <fs_t043_item>-AccountingDocument  "03.09.2026
               WHERE InvoiceReference EQ <fs_t043>-AccountingDocument
*                 AND InvoiceReferenceFiscalYear EQ <fs_t043_item>-FiscalYear
                 AND InvoiceReferenceFiscalYear EQ <fs_t043>-FiscalYear
                 AND DocumentAmount NE 0.

                " DZ için:
                DATA(lv_used_dz) = COND dmbtr( WHEN lv_inv_kalan < <fs_t043_fatdz>-DocumentAmountAbs
                                               THEN lv_inv_kalan
                                               ELSE <fs_t043_fatdz>-DocumentAmountAbs ).
                IF lv_used_dz > 0.

                  DELETE <fs_header>-item WHERE accounting_document = <fs_t043_fatdz>-AccountingDocument
                                           AND  accounting_document_item = <fs_t043_fatdz>-AccountingDocumentItem.
                  APPEND INITIAL LINE TO <fs_header>-item ASSIGNING FIELD-SYMBOL(<fs_item>).
                  <fs_item>-accounting_document      = <fs_t043_fatdz>-AccountingDocument.
                  <fs_item>-accounting_document_item = <fs_t043_fatdz>-AccountingDocumentItem.
                  <fs_item>-used_amount              = lv_used_dz.
                  <fs_item>-currency                 = <fs_t043_fatdz>-Currency.
                  <fs_item>-fiscal_year              = <fs_t043_fatdz>-FiscalYear.
                  <fs_item>-inv_number               = <fs_main_inv>-InvoiceNumber.
                  <fs_item>-partial_invoice_number   = <fs_main_inv>-PartialInvoiceNumber.
                  <fs_item>-id                       = <fs_main_inv>-Id.

                  APPEND INITIAL LINE TO <fs_header>-t024 ASSIGNING <fs_t024>.
                  <fs_t024> = CORRESPONDING #( <fs_item> ).

*                  lv_inv_kalan -= lv_used_dz "03.09.2026
                  lv_dz_total  += lv_used_dz.

                  " T043 Tablosundaki Kalemin Kalanını Güncelle
                  <fs_t043_item>-DocumentAmount = 0.
                  <fs_t043_item>-Changed = abap_true.
                  <fs_t043_item>-DocumentAmountAbs = abs( <fs_t043_fatdz>-DocumentAmount ).
                ENDIF.

              ENDLOOP.

            ELSEIF <fs_t043_item>-AccountingDocumentType NE 'DZ' AND <fs_t043_item>-DebitCreditCode = 'H'.

              DATA(lv_odm_amount) = COND dmbtr( WHEN <fs_t043_item>-Kalan IS NOT INITIAL
                                                THEN abs( <fs_t043_item>-Kalan )
                                                ELSE abs( <fs_t043_item>-DocumentAmount ) ).
              IF lv_odm_amount > 0.

                " Ödeme için:
                DATA(lv_used_odm) = COND dmbtr( WHEN lv_inv_kalan < lv_odm_amount
                                                THEN lv_inv_kalan
                                                ELSE lv_odm_amount ).

                DATA(lv_odm_amount_tot) =  REDUCE #( INIT amount TYPE zarete_dbs_de_finteo_amount
                                              FOR ls_itm IN <fs_header>-item
                                              WHERE ( accounting_document = <fs_t043_item>-AccountingDocument
                                                AND   accounting_document_item = <fs_t043_item>-AccountingDocumentItem )
                                              NEXT amount = amount + ls_itm-amount ).

                DATA(lv_odm_dz_tot) = REDUCE #( INIT amount TYPE zarete_dbs_de_finteo_amount
                                              FOR ls_t43 IN lt_t043
                                              WHERE ( InvoiceReference EQ <fs_t043_item>-AccountingDocument
                                                AND   InvoiceReferenceFiscalYear EQ <fs_t043_item>-FiscalYear
                                                AND   DocumentAmount NE 0 )
                                              NEXT amount = amount + ls_t43-OriginalAmount ).

                DELETE <fs_header>-item WHERE accounting_document = <fs_t043_item>-AccountingDocument
                                         AND  accounting_document_item = <fs_t043_item>-AccountingDocumentItem.

                APPEND INITIAL LINE TO <fs_header>-item ASSIGNING <fs_item>.
                <fs_item>-accounting_document      = <fs_t043_item>-AccountingDocument.
                <fs_item>-accounting_document_item = <fs_t043_item>-AccountingDocumentItem.
                <fs_item>-currency                 = <fs_t043_item>-Currency.
                <fs_item>-fiscal_year              = <fs_t043_item>-FiscalYear.
                <fs_item>-inv_number               = <fs_main_inv>-InvoiceNumber.
                <fs_item>-partial_invoice_number   = <fs_main_inv>-PartialInvoiceNumber.
                <fs_item>-id                       = <fs_main_inv>-Id.

                lv_inv_kalan -= lv_used_odm.
                lv_odm_total += lv_used_odm.

                " Ödeme Belgesinin Kalanını Düş
                IF lv_used_odm NE lv_odm_amount.
                  <fs_item>-amount += abs( lv_used_odm ) + lv_odm_amount_tot + lv_odm_dz_tot.
                  <fs_item>-used_amount = <fs_item>-amount.
                  <fs_t043_item>-DocumentAmount -= ( lv_used_odm * -1 )."abs alındığı için çıkarttık
                  <fs_t043_item>-DocumentAmountAbs = abs( <fs_t043_item>-DocumentAmount ).
                ELSE.
                  CLEAR: <fs_item>-amount.
                  <fs_item>-used_amount         = lv_used_odm.
                  <fs_t043_item>-DocumentAmount = 0.
                  <fs_t043_item>-DocumentAmountAbs = abs( <fs_t043_item>-DocumentAmount ).
                ENDIF.

                APPEND INITIAL LINE TO <fs_header>-t024 ASSIGNING <fs_t024>.
                <fs_t024> = CORRESPONDING #( <fs_item> ).

* SENARYO 3: Bu Ödemeye Bağlı Bir DZ Belgesi Var mı?
                LOOP AT lt_t043 ASSIGNING FIELD-SYMBOL(<fs_t043_dz>)
                  WHERE InvoiceReference EQ <fs_t043_item>-AccountingDocument
                    AND InvoiceReferenceFiscalYear EQ <fs_t043_item>-FiscalYear
                    AND DocumentAmount NE 0.

                  DELETE <fs_header>-item WHERE accounting_document = <fs_t043_dz>-AccountingDocument
                                           AND  accounting_document_item = <fs_t043_dz>-AccountingDocumentItem.
                  APPEND INITIAL LINE TO <fs_header>-item ASSIGNING <fs_item>.
                  <fs_item>-accounting_document      = <fs_t043_dz>-AccountingDocument.
                  <fs_item>-accounting_document_item = <fs_t043_dz>-AccountingDocumentItem.
*                  <fs_item>-used_amount              = abs( <fs_t043_dz>-DocumentAmount ).
                  <fs_item>-currency                 = <fs_t043_dz>-Currency.
                  <fs_item>-fiscal_year              = <fs_t043_dz>-FiscalYear.
                  <fs_item>-inv_number               = <fs_main_inv>-InvoiceNumber.
                  <fs_item>-partial_invoice_number   = <fs_main_inv>-PartialInvoiceNumber.
                  <fs_item>-id                       = <fs_main_inv>-Id.

                  APPEND INITIAL LINE TO <fs_header>-t024 ASSIGNING <fs_t024>.
                  <fs_t024> = CORRESPONDING #( <fs_item> ).

                  lv_zpdz_total  += <fs_t043_dz>-DocumentAmount.

                  APPEND INITIAL LINE TO lt_zpdz ASSIGNING FIELD-SYMBOL(<fs_zpdz>).
                  <fs_zpdz>-invoice_number = <fs_main_inv>-InvoiceNumber.
                  <fs_zpdz>-amount         = <fs_t043_dz>-DocumentAmount.

                  DATA(lv_odeme_dz) = CONV dmbtr( <fs_t043_dz>-DocumentAmount - abs( lv_used_odm ) ).
                  IF <fs_t043_dz>-DocumentAmount LE abs( <fs_t043_item>-OriginalAmount ).
                    <fs_t043_dz>-DocumentAmount = 0. " DZ kapandı
                  ELSE.

                    " Ödemenin DZ sini kapatabilmek için yeterli ödeme belgesi ekle !
                    LOOP AT lt_t043 ASSIGNING FIELD-SYMBOL(<fs_t043_DZ_ODM>) WHERE Customer EQ lv_customer_in
                                                                               AND Currency EQ lv_currency
                                                                               AND AccountingDocumentType NOT IN lr_types
                                                                               AND DocumentAmount NE 0.
                      IF <fs_t043_DZ_ODM>-AccountingDocumentType NE 'DZ' AND lv_odeme_dz GT 0.

                        lv_odm_amount = COND dmbtr( WHEN <fs_t043_DZ_ODM>-Kalan IS NOT INITIAL
                                                     THEN abs( <fs_t043_DZ_ODM>-Kalan )
                                                      ELSE abs( <fs_t043_DZ_ODM>-DocumentAmount ) ).
                        IF lv_odm_amount > 0.

                          " Ödeme için:
                          lv_used_odm = COND dmbtr( WHEN lv_odeme_dz < lv_odm_amount
                                                      THEN lv_odeme_dz
                                                        ELSE lv_odm_amount ).

                          lv_odm_amount_tot =  REDUCE #( INIT amount TYPE zarete_dbs_de_finteo_amount
                                                        FOR ls_itm IN <fs_header>-item
                                                        WHERE ( accounting_document = <fs_t043_DZ_ODM>-AccountingDocument
                                                          AND   accounting_document_item = <fs_t043_DZ_ODM>-AccountingDocumentItem )
                                                        NEXT amount = amount + ls_itm-amount ).

                          lv_odm_dz_tot = REDUCE #( INIT amount TYPE zarete_dbs_de_finteo_amount
                                              FOR ls_t43 IN lt_t043
                                              WHERE ( InvoiceReference EQ <fs_t043_DZ_ODM>-AccountingDocument
                                                AND   InvoiceReferenceFiscalYear EQ <fs_t043_DZ_ODM>-FiscalYear
                                                AND   DocumentAmount NE 0 )
                                              NEXT amount = amount + ls_t43-OriginalAmount ).



                          DELETE <fs_header>-item WHERE accounting_document = <fs_t043_DZ_ODM>-AccountingDocument
                                                   AND  accounting_document_item = <fs_t043_DZ_ODM>-AccountingDocumentItem.

                          APPEND INITIAL LINE TO <fs_header>-item ASSIGNING <fs_item>.
                          <fs_item>-accounting_document      = <fs_t043_DZ_ODM>-AccountingDocument.
                          <fs_item>-accounting_document_item = <fs_t043_DZ_ODM>-AccountingDocumentItem.
                          <fs_item>-currency                 = <fs_t043_DZ_ODM>-Currency.
                          <fs_item>-fiscal_year              = <fs_t043_DZ_ODM>-FiscalYear.
                          <fs_item>-inv_number               = <fs_main_inv>-InvoiceNumber.
                          <fs_item>-partial_invoice_number   = <fs_main_inv>-PartialInvoiceNumber.
                          <fs_item>-id                       = <fs_main_inv>-Id.

                          lv_odeme_dz -= lv_used_odm.
                          lv_odm_total += lv_used_odm.

                          " Ödeme Belgesinin Kalanını Düş
                          IF lv_used_odm NE lv_odm_amount.
                            <fs_item>-amount += abs( lv_used_odm ) + lv_odm_amount_tot + lv_odm_dz_tot.
                            <fs_item>-used_amount = <fs_item>-amount.
                            <fs_t043_DZ_ODM>-DocumentAmount -= ( lv_used_odm * -1 )."abs alındığı için çıkarttık
                            <fs_t043_DZ_ODM>-DocumentAmountAbs = abs( <fs_t043_DZ_ODM>-DocumentAmount ).
                          ELSE.
                            CLEAR: <fs_item>-amount.
                            <fs_item>-used_amount         = lv_used_odm.
                            <fs_t043_DZ_ODM>-DocumentAmount = 0.
                            <fs_t043_DZ_ODM>-DocumentAmountAbs = abs( <fs_t043_DZ_ODM>-DocumentAmount ).
                          ENDIF.

                          APPEND INITIAL LINE TO <fs_header>-t024 ASSIGNING <fs_t024>.
                          <fs_t024> = CORRESPONDING #( <fs_item> ).

                        ENDIF.
                      ENDIF.

                    ENDLOOP.

                  ENDIF.

                  <fs_t043_dz>-Changed = abap_true.
                  <fs_t043_dz>-DocumentAmountAbs = abs( <fs_t043_dz>-DocumentAmount ).

                ENDLOOP.

              ENDIF.
            ENDIF.

          ENDLOOP.

*Faturanın büyük olduğu durumda kalan tutar partial kısmına verilir
          IF lv_inv_kalan GT lv_odm_total AND <fs_fatura> IS ASSIGNED.
            <fs_fatura>-amount = abs( lv_odm_total ).
          ELSEIF lv_inv_kalan EQ 0.
            CLEAR: <fs_fatura>-amount.
          ELSE.
            <fs_fatura>-amount = abs( lv_odm_total ).
          ENDIF.

        ENDLOOP.

      ENDLOOP.

      " UE BELGELERİ VARSA GİR YOKSA GİRME !!!
      IF ls_journalentry IS NOT INITIAL.
        READ TABLE lt_header ASSIGNING FIELD-SYMBOL(<fs_head>) INDEX 1.
        DATA(lv_amountt) = REDUCE #( INIT amount TYPE zarete_dbs_de_finteo_amount
                                              FOR ls_main_inv IN lt_main_inv
                                              WHERE ( DocumentDate IS INITIAL
                                                AND   AccountingDocument IS NOT INITIAL )
                                              NEXT amount = amount + ls_main_inv-Amount ).

        DATA(lv_UE_DZ) = REDUCE #( INIT amount TYPE zarete_dbs_de_finteo_amount
                                              FOR ls_043 IN lt_t043
                                              WHERE ( InvoiceReference       = ls_journalentry-AccountingDocument
                                                AND   AccountingDocumentType = 'DZ'
                                                AND   DebitCreditCode        = 'H'  )
                                              NEXT amount = amount + ls_043-OriginalAmount ).

        lv_amountt += abs( lv_UE_DZ ).
        IF  lv_amountt  LE ls_journalentry-AmountInTransactionCurrency.
          LOOP AT <fs_head>-item ASSIGNING FIELD-SYMBOL(<fs_itm>) WHERE inv_type = 'F'.
            <fs_itm>-amount = lv_amountt.
          ENDLOOP.
        ELSE.
          LOOP AT <fs_head>-item ASSIGNING <fs_itm> WHERE inv_type NE 'F'.
            LOOP AT <fs_head>-t024 ASSIGNING FIELD-SYMBOL(<fs_t024_new>) WHERE accounting_document = <fs_itm>-accounting_document
                                                                           AND accounting_document_item = <fs_itm>-accounting_document_item.
              <fs_itm>-amount += <fs_t024_new>-used_amount.
            ENDLOOP.
          ENDLOOP.
        ENDIF.
      ENDIF.

      lo_util->clearing_mapping_v2( EXPORTING it_header = lt_header
                                    IMPORTING es_request = ls_request ).

      lo_denk->input = ls_request.
      APPEND lo_denk TO lt_in_tab.

      lo_parallel->run_inst( EXPORTING p_in_tab  = lt_in_tab  IMPORTING p_out_tab = lt_out_tab ).

    ENDLOOP.

  ENDMETHOD.


  METHOD clearing_new.

    TYPES: BEGIN OF ty_customer,
             customer TYPE zarete_dbs_t022-customer,
             currency TYPE zarete_dbs_t022-transaction_currency,
           END OF ty_customer,
           tt_customer TYPE STANDARD TABLE OF ty_customer WITH EMPTY KEY.

    TYPES: BEGIN OF ty_zpdz,
             invoice_number TYPE zarete_dbs_t015-invoice_number,
             amount         TYPE dmbtr,
           END OF ty_zpdz,
           tt_zpdz TYPE STANDARD TABLE OF ty_zpdz WITH EMPTY KEY.

    DATA: ls_request            TYPE  zfi_denk_journal_entry_bulk_cl,
          lt_in_tab             TYPE cl_abap_parallel=>t_in_inst_tab,
          lt_out_tab            TYPE cl_abap_parallel=>t_out_inst_tab,
          lt_customers          TYPE tt_customer,
          lt_zpdz               TYPE tt_zpdz,
          lt_header             TYPE tt_header,
          lr_customer           TYPE RANGE OF kunnr,
*          lt_t026               TYPE STANDARD TABLE OF zarete_dbs_t026 WITH EMPTY KEY,
          lr_fatura_types       TYPE RANGE OF zarete_dbs_t026-accountingdocumenttype,  "Borç (S) => Fatura tipi belgeler (eski lr_types / lr_types2 yerine)
          lr_odeme_types        TYPE RANGE OF zarete_dbs_t026-accountingdocumenttype,  "Alacak (H) => Ödeme tipi belgeler
          lv_odm_total          TYPE dmbtr,
          lv_dz_total           TYPE dmbtr,
          lv_zpdz_total         TYPE dmbtr,
          lt_limit              TYPE zarete_dbs_sc_finteo_api=>ty_limit,
          lv_acc_doc            TYPE zarete_dbs_dd_t043-AccountingDocument,
          lv_AccountingDocument TYPE zarete_dbs_dd_t043-AccountingDocument.

    get_limit_data( EXPORTING iv_behavior = abap_true IMPORTING et_limit = lt_limit ).

    DATA(lo_util) = NEW zarete_dbs_cl_utility( ).
    DATA(lo_parallel) = NEW cl_abap_parallel( ).
    DATA(lo_denk) = NEW zcl_fi_denk_parallel( ).
    DATA(lo_log) = zarete_dbs_cl_log=>get_factory( ).

    lt_customers = VALUE #(
                 FOR GROUPS <group_key> OF <ls_invoices> IN ct_invoices
                 GROUP BY ( customer = <ls_invoices>-customer
                            currency = <ls_invoices>-currency )
                 ASCENDING
                 ( customer = <group_key>-customer
                   currency = <group_key>-currency ) ).

    LOOP AT lt_customers ASSIGNING FIELD-SYMBOL(<fs_customers>).
      IF <fs_customers> IS NOT INITIAL.
        APPEND VALUE #( sign = 'I' option = 'EQ' low = |{ <fs_customers>-customer ALPHA = IN }| ) TO lr_customer.
      ENDIF.
    ENDLOOP.

*   Belge türü / borç-alacak eşlemesi artık ZARETE_DBS_T026 bakım tablosundan okunuyor.
*   Borç  (S) => Fatura tipi belgeler  (eski lr_types  / lr_types2'nin yerini alır)
*   Alacak(H) => Ödeme  tipi belgeler
    SELECT * FROM zarete_dbs_t026
      INTO TABLE @DATA(lt_t026).                        "#EC CI_NOWHERE

    lr_fatura_types = VALUE #( FOR ls_t026 IN lt_t026 WHERE ( debitcreditcode = 'S' )
                                ( sign = 'I' option = 'EQ' low = ls_t026-accountingdocumenttype ) ).

    lr_odeme_types  = VALUE #( FOR ls_t026 IN lt_t026 WHERE ( debitcreditcode = 'H' )
                                ( sign = 'I' option = 'EQ' low = ls_t026-accountingdocumenttype ) ).

    IF ct_invoices IS NOT INITIAL.

      SELECT *                                "#EC CI_ALL_FIELDS_NEEDED
        FROM zarete_dbs_dd_invoice_001 WITH PRIVILEGED ACCESS
        FOR ALL ENTRIES IN @ct_invoices
        WHERE Id EQ @ct_invoices-id
        AND   InvoiceNumber EQ @ct_invoices-invoice_number
        INTO TABLE @DATA(lt_main_inv).

      SORT lt_main_inv BY Customer DocType DueDate InvoiceNumber.
      DELETE ADJACENT DUPLICATES FROM lt_main_inv COMPARING Customer DocType DueDate InvoiceNumber.

    ENDIF.

    SELECT *
      FROM zarete_dbs_dd_t043
      WHERE customer IN @lr_customer
      INTO TABLE @DATA(lt_t043).

    SORT lt_t043 BY Customer AccountingDocumentType Kalan DESCENDING.
*    DELETE lt_t043 WHERE AccountingDocumentType NOT IN lr_fatura_types AND DebitCreditCode = 'S'.

    LOOP AT lt_customers ASSIGNING <fs_customers>.
      DATA(lv_customer_in) = |{ <fs_customers>-customer ALPHA = IN }|.

      CLEAR: lt_header, lt_in_tab, lt_out_tab, ls_request.

*Müşteri Bazlı header doldurulur
      APPEND INITIAL LINE TO lt_header ASSIGNING FIELD-SYMBOL(<fs_header>).
      <fs_header>-customer         = <fs_customers>-customer.
      <fs_header>-currency         = COND #( WHEN <fs_customers>-currency IS INITIAL THEN 'TRY' ELSE <fs_customers>-currency ).

      LOOP AT lt_main_inv ASSIGNING FIELD-SYMBOL(<fs_main_inv>) WHERE Customer EQ <fs_customers>-customer
                                                                AND   Currency EQ <fs_customers>-currency.

        " UE Belgeleri için eklendi !!! - (Eski Faturalar)
        IF <fs_main_inv>-DocumentDate IS INITIAL AND <fs_main_inv>-AccountingDocument IS NOT INITIAL
         AND <fs_main_inv>-DueDate LE cl_abap_context_info=>get_system_date( ).

          SELECT header~AccountingDocument,
                 header~CompanyCode,
                 header~AccountingDocumentType,
                 header~CompanyCodeCurrency,
                 item~GlAccount,
                 item~AmountInTransactionCurrency
          FROM I_JournalEntry WITH PRIVILEGED ACCESS AS header
          INNER JOIN I_JournalEntryItem AS item
             ON header~AccountingDocument = item~AccountingDocument
          WHERE customer = @lv_customer_in
            AND header~AccountingDocumentType = 'UE'
            AND item~DebitCreditCode = 'S'
          INTO TABLE @DATA(lt_journal).

          SELECT SINGLE * FROM I_JournalEntryItem
           WITH PRIVILEGED ACCESS
            WHERE AccountingDocument = @<fs_main_inv>-AccountingDocument
              AND ClearingJournalEntry IS INITIAL
               INTO @DATA(ls_journalentryitem).

          IF ls_journalentryitem IS NOT INITIAL.
            TRY.
                DATA(ls_journalentry) = lt_journal[ 1 ].
              CATCH  cx_sy_itab_line_not_found INTO DATA(lo_cx).
                DATA(lv_text) = lo_cx->get_longtext( ).
            ENDTRY.
          ENDIF.
        ENDIF.

        lv_accountingdocument = |{ <fs_main_inv>-InvoiceAccountingDocument ALPHA = IN }|.

        CLEAR: lv_acc_doc.
        lv_acc_doc = COND #( WHEN ls_journalentry-AccountingDocument IS NOT INITIAL THEN ls_journalentry-AccountingDocument
                              ELSE lv_accountingdocument ).

        IF <fs_customers>-currency IS NOT INITIAL.
          DATA(lv_currency) = <fs_customers>-currency.
        ELSE.
          lv_currency = 'TRY'.
        ENDIF.

        LOOP AT lt_t043 ASSIGNING FIELD-SYMBOL(<fs_t043>) WHERE AccountingDocument EQ lv_acc_doc.

          CLEAR: lv_odm_total, lv_dz_total.

          DATA(lv_faturalar_total) = REDUCE #( INIT amount TYPE zarete_dbs_de_finteo_amount
                                              FOR ls_main_inv IN lt_main_inv
                                              WHERE ( DocType IN lr_fatura_types
                                              AND     Customer EQ <fs_customers>-customer
                                              AND     Currency EQ lv_currency )
                                              NEXT amount = amount + ls_main_inv-Amount ).

          DATA(lv_faturadz_total) = REDUCE #( INIT amount TYPE zarete_dbs_de_finteo_amount
                                              FOR ls_t043 IN lt_t043
                                              WHERE (  AccountingDocumentType EQ 'DZ'
                                              AND     Customer EQ lv_customer_in
                                              AND     DebitCreditCode EQ 'H'
                                              AND     Currency EQ lv_currency )
                                              NEXT amount = amount + ls_t043-DocumentAmountAbs ).

          DATA(lv_odemeler_total) = REDUCE #( INIT amount TYPE zarete_dbs_de_finteo_amount
                                              FOR ls_t043 IN lt_t043
                                              WHERE ( AccountingDocumentType IN lr_odeme_types
                                              AND     AccountingDocumentType NE 'DZ'
                                              AND     DebitCreditCode EQ 'H'
                                              AND     Customer EQ lv_customer_in
                                              AND     Currency EQ lv_currency )
                                              NEXT amount = amount + ls_t043-DocumentAmountAbs ).

          DATA(lv_odemedz_total) = REDUCE #( INIT amount TYPE zarete_dbs_de_finteo_amount
                                                     FOR ls_t043 IN lt_t043
                                                     WHERE (  AccountingDocumentType EQ 'DZ'
                                                     AND     Customer EQ lv_customer_in
                                                     AND     DebitCreditCode EQ 'S'
                                                     AND     Currency EQ lv_currency )
                                                     NEXT amount = amount + ls_t043-DocumentAmountAbs ).

          IF lv_odemeler_total EQ 0. "Ödeme kalmadıysa yeni fatura kontrol edilmez

            lo_log->set_sapinvoiceno( iv_sapinvoiceno = <fs_main_inv>-InvoiceNumber
                                      iv_id           = <fs_main_inv>-Id ).
            lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                             msgno = '022'
                             msgtx = 'Ödeme Belgesi Bulunamadı' ).

            CONTINUE.
          ENDIF.

          DATA(lv_total) = CONV zarete_dbs_de_finteo_amount( lv_odemeler_total - lv_odemedz_total ).

          IF lv_total EQ 0.
            CONTINUE.
          ENDIF.

          " Faturanın Denkleştirilecek Kalan Tutarı (Borç Tutarı)
          DATA(lv_inv_kalan) = COND #( WHEN <fs_t043>-Kalan IS NOT INITIAL AND ls_journalentry-AccountingDocumentType NE 'UE'
                                        THEN <fs_t043>-Kalan
                                       WHEN ls_journalentry-AccountingDocumentType = 'UE'
                                        THEN <fs_main_inv>-Amount
                                        ELSE <fs_t043>-DocumentAmount ).

          IF lv_inv_kalan EQ 0.
            CONTINUE. " Faturanın bakiyesi sıfırsa sonraki faturaya geç
          ENDIF.

          IF <fs_main_inv>-DbsInvoiceId IS NOT INITIAL AND <fs_main_inv>-DocumentDate IS NOT INITIAL.
            IF <fs_main_inv>-FinteoStatusCode EQ '6' OR <fs_main_inv>-FinteoStatusCode EQ '7'.
              lo_log->set_sapinvoiceno( iv_sapinvoiceno = <fs_main_inv>-InvoiceNumber
                                        iv_id           = <fs_main_inv>-Id ).
              lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                               msgno = '022'
                               msgtx = 'Fatura Tahsil Edilmiş' ).
              CONTINUE.
            ELSE.
              READ TABLE lt_limit-data ASSIGNING FIELD-SYMBOL(<fs_limit>) WITH KEY partycode    = <fs_customers>-customer
*                                                                                   currencycode = <fs_customers>-currency
                                                                                   bankcode     = <fs_main_inv>-HouseBank.

              IF sy-subrc EQ 0.
                DATA(lv_inv_result) = CONV dmbtr( lv_inv_kalan - lv_odemeler_total ).
*                IF lv_inv_kalan GT <fs_limit>-activelimit AND lv_inv_kalan GT lv_odemeler_total.
                IF lv_inv_result GT ( <fs_limit>-activelimit + lv_inv_kalan ).
                  lo_log->set_sapinvoiceno( iv_sapinvoiceno = <fs_main_inv>-InvoiceNumber
                                            iv_id           = <fs_main_inv>-Id ).
                  lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                                   msgno = '022'
                                   msgtx = 'Limit Yetersiz' ).
                  CONTINUE.
                ENDIF.
              ENDIF.
            ENDIF.
          ENDIF.

          DELETE <fs_header>-item WHERE accounting_document = <fs_t043>-AccountingDocument
                                    AND accounting_document_item = <fs_t043>-AccountingDocumentItem
                                    AND inv_type = 'F'.

          APPEND INITIAL LINE TO <fs_header>-item ASSIGNING FIELD-SYMBOL(<fs_fatura>).
          <fs_fatura>-accounting_document      = <fs_t043>-AccountingDocument.
          <fs_fatura>-accounting_document_item = <fs_t043>-AccountingDocumentItem.
          <fs_fatura>-currency                 = <fs_t043>-Currency.
          <fs_fatura>-fiscal_year              = <fs_t043>-FiscalYear.
          <fs_fatura>-inv_type                 = 'F'.
          APPEND INITIAL LINE TO <fs_header>-t024 ASSIGNING FIELD-SYMBOL(<fs_t024>).
          <fs_t024> = CORRESPONDING #( <fs_fatura> ).

          LOOP AT lt_t043 ASSIGNING FIELD-SYMBOL(<fs_t043_item>) WHERE Customer EQ lv_customer_in
                                                                 AND   Currency EQ lv_currency
                                                                 AND   AccountingDocumentType IN lr_odeme_types
                                                                 AND   DocumentAmount NE 0.
            " Fatura tamamen kapatıldıysa bu fatura için kalem aramayı bitir
            IF lv_inv_kalan EQ 0.
              EXIT.
            ENDIF.

            IF <fs_t043_item>-kalan GT 0.
              IF <fs_t043_item>-DebitCreditCode EQ 'S'.
                <fs_t043_item>-DocumentAmount = <fs_t043_item>-kalan.
              ELSE.
                <fs_t043_item>-DocumentAmount = ( <fs_t043_item>-kalan * -1 ).
              ENDIF.
              <fs_t043_item>-DocumentAmountAbs = <fs_t043_item>-kalan.
              CLEAR: <fs_t043_item>-kalan.
            ENDIF.

*Senaryo 1 - Faturaya ait DZ belgeleri eklenir
            IF <fs_t043_item>-AccountingDocumentType = 'DZ' AND <fs_t043_item>-DebitCreditCode = 'H'
              AND lv_inv_kalan LE lv_total.

              LOOP AT lt_t043 ASSIGNING FIELD-SYMBOL(<fs_t043_fatdz>)
               WHERE InvoiceReference EQ <fs_t043>-AccountingDocument
                 AND InvoiceReferenceFiscalYear EQ <fs_t043>-FiscalYear
                 AND DocumentAmount NE 0.

                " DZ için:
                DATA(lv_used_dz) = COND dmbtr( WHEN lv_inv_kalan < <fs_t043_fatdz>-DocumentAmountAbs
                                               THEN lv_inv_kalan
                                               ELSE <fs_t043_fatdz>-DocumentAmountAbs ).
                IF lv_used_dz > 0.

                  DELETE <fs_header>-item WHERE accounting_document = <fs_t043_fatdz>-AccountingDocument
                                           AND  accounting_document_item = <fs_t043_fatdz>-AccountingDocumentItem.
                  APPEND INITIAL LINE TO <fs_header>-item ASSIGNING FIELD-SYMBOL(<fs_item>).
                  <fs_item>-accounting_document      = <fs_t043_fatdz>-AccountingDocument.
                  <fs_item>-accounting_document_item = <fs_t043_fatdz>-AccountingDocumentItem.
                  <fs_item>-used_amount              = lv_used_dz.
                  <fs_item>-currency                 = <fs_t043_fatdz>-Currency.
                  <fs_item>-fiscal_year              = <fs_t043_fatdz>-FiscalYear.
                  <fs_item>-inv_number               = <fs_main_inv>-InvoiceNumber.
                  <fs_item>-partial_invoice_number   = <fs_main_inv>-PartialInvoiceNumber.
                  <fs_item>-id                       = <fs_main_inv>-Id.

                  APPEND INITIAL LINE TO <fs_header>-t024 ASSIGNING <fs_t024>.
                  <fs_t024> = CORRESPONDING #( <fs_item> ).

*                  lv_inv_kalan -= lv_used_dz "03.09.2026
                  lv_dz_total  += lv_used_dz.

                  " T043 Tablosundaki Kalemin Kalanını Güncelle
                  <fs_t043_item>-DocumentAmount = 0.
                  <fs_t043_item>-Changed = abap_true.
                  <fs_t043_item>-DocumentAmountAbs = abs( <fs_t043_fatdz>-DocumentAmount ).
                ENDIF.

              ENDLOOP.

            ELSEIF <fs_t043_item>-AccountingDocumentType NE 'DZ' AND <fs_t043_item>-DebitCreditCode = 'H'.

              DATA(lv_odm_amount) = COND dmbtr( WHEN <fs_t043_item>-Kalan IS NOT INITIAL
                                                THEN abs( <fs_t043_item>-Kalan )
                                                ELSE abs( <fs_t043_item>-DocumentAmount ) ).
              IF lv_odm_amount > 0.

                " Ödeme için:
                DATA(lv_used_odm) = COND dmbtr( WHEN lv_inv_kalan < lv_odm_amount
                                                THEN lv_inv_kalan
                                                ELSE lv_odm_amount ).

                DATA(lv_odm_amount_tot) =  REDUCE #( INIT amount TYPE zarete_dbs_de_finteo_amount
                                              FOR ls_itm IN <fs_header>-item
                                              WHERE ( accounting_document = <fs_t043_item>-AccountingDocument
                                                AND   accounting_document_item = <fs_t043_item>-AccountingDocumentItem )
                                              NEXT amount = amount + ls_itm-amount ).

                DATA(lv_odm_dz_tot) = REDUCE #( INIT amount TYPE zarete_dbs_de_finteo_amount
                                              FOR ls_t43 IN lt_t043
                                              WHERE ( InvoiceReference EQ <fs_t043_item>-AccountingDocument
                                                AND   InvoiceReferenceFiscalYear EQ <fs_t043_item>-FiscalYear
                                                AND   DocumentAmount NE 0 )
                                              NEXT amount = amount + ls_t43-OriginalAmount ).

                DELETE <fs_header>-item WHERE accounting_document = <fs_t043_item>-AccountingDocument
                                         AND  accounting_document_item = <fs_t043_item>-AccountingDocumentItem.

                APPEND INITIAL LINE TO <fs_header>-item ASSIGNING <fs_item>.
                <fs_item>-accounting_document      = <fs_t043_item>-AccountingDocument.
                <fs_item>-accounting_document_item = <fs_t043_item>-AccountingDocumentItem.
                <fs_item>-currency                 = <fs_t043_item>-Currency.
                <fs_item>-fiscal_year              = <fs_t043_item>-FiscalYear.
                <fs_item>-inv_number               = <fs_main_inv>-InvoiceNumber.
                <fs_item>-partial_invoice_number   = <fs_main_inv>-PartialInvoiceNumber.
                <fs_item>-id                       = <fs_main_inv>-Id.

                lv_inv_kalan -= lv_used_odm.
                lv_odm_total += lv_used_odm.

                " Ödeme Belgesinin Kalanını Düş
                IF lv_used_odm NE lv_odm_amount.
                  <fs_item>-amount += abs( lv_used_odm ) + lv_odm_amount_tot + lv_odm_dz_tot.
                  <fs_item>-used_amount = <fs_item>-amount.
                  <fs_t043_item>-DocumentAmount -= ( lv_used_odm * -1 )."abs alındığı için çıkarttık
                  <fs_t043_item>-DocumentAmountAbs = abs( <fs_t043_item>-DocumentAmount ).
                ELSE.
                  CLEAR: <fs_item>-amount.
                  <fs_item>-used_amount         = lv_used_odm.
                  <fs_t043_item>-DocumentAmount = 0.
                  <fs_t043_item>-DocumentAmountAbs = abs( <fs_t043_item>-DocumentAmount ).
                ENDIF.

                APPEND INITIAL LINE TO <fs_header>-t024 ASSIGNING <fs_t024>.
                <fs_t024> = CORRESPONDING #( <fs_item> ).

* SENARYO 3: Bu Ödemeye Bağlı Bir DZ Belgesi Var mı?
                LOOP AT lt_t043 ASSIGNING FIELD-SYMBOL(<fs_t043_dz>)
                  WHERE InvoiceReference EQ <fs_t043_item>-AccountingDocument
                    AND InvoiceReferenceFiscalYear EQ <fs_t043_item>-FiscalYear
                    AND DocumentAmount NE 0.

                  DELETE <fs_header>-item WHERE accounting_document = <fs_t043_dz>-AccountingDocument
                                           AND  accounting_document_item = <fs_t043_dz>-AccountingDocumentItem.
                  APPEND INITIAL LINE TO <fs_header>-item ASSIGNING <fs_item>.
                  <fs_item>-accounting_document      = <fs_t043_dz>-AccountingDocument.
                  <fs_item>-accounting_document_item = <fs_t043_dz>-AccountingDocumentItem.
*                  <fs_item>-used_amount              = abs( <fs_t043_dz>-DocumentAmount ).
                  <fs_item>-currency                 = <fs_t043_dz>-Currency.
                  <fs_item>-fiscal_year              = <fs_t043_dz>-FiscalYear.
                  <fs_item>-inv_number               = <fs_main_inv>-InvoiceNumber.
                  <fs_item>-partial_invoice_number   = <fs_main_inv>-PartialInvoiceNumber.
                  <fs_item>-id                       = <fs_main_inv>-Id.

                  APPEND INITIAL LINE TO <fs_header>-t024 ASSIGNING <fs_t024>.
                  <fs_t024> = CORRESPONDING #( <fs_item> ).

                  lv_zpdz_total  += <fs_t043_dz>-DocumentAmount.

                  APPEND INITIAL LINE TO lt_zpdz ASSIGNING FIELD-SYMBOL(<fs_zpdz>).
                  <fs_zpdz>-invoice_number = <fs_main_inv>-InvoiceNumber.
                  <fs_zpdz>-amount         = <fs_t043_dz>-DocumentAmount.

                  DATA(lv_odeme_dz) = CONV dmbtr( <fs_t043_dz>-DocumentAmount - abs( lv_used_odm ) ).
                  IF <fs_t043_dz>-DocumentAmount LE abs( <fs_t043_item>-OriginalAmount ).
                    <fs_t043_dz>-DocumentAmount = 0. " DZ kapandı
                  ELSE.

                    " Ödemenin DZ sini kapatabilmek için yeterli ödeme belgesi ekle !
                    LOOP AT lt_t043 ASSIGNING FIELD-SYMBOL(<fs_t043_DZ_ODM>) WHERE Customer EQ lv_customer_in
                                                                               AND Currency EQ lv_currency
                                                                               AND AccountingDocumentType IN lr_odeme_types
                                                                               AND DocumentAmount NE 0
                                                                               AND DebitCreditCode = 'H'.
                      IF <fs_t043_DZ_ODM>-AccountingDocumentType NE 'DZ' AND lv_odeme_dz GT 0.

                        lv_odm_amount = COND dmbtr( WHEN <fs_t043_DZ_ODM>-Kalan IS NOT INITIAL
                                                     THEN abs( <fs_t043_DZ_ODM>-Kalan )
                                                      ELSE abs( <fs_t043_DZ_ODM>-DocumentAmount ) ).
                        IF lv_odm_amount > 0.

                          " Ödeme için:
                          lv_used_odm = COND dmbtr( WHEN lv_odeme_dz < lv_odm_amount
                                                      THEN lv_odeme_dz
                                                        ELSE lv_odm_amount ).

                          lv_odm_amount_tot =  REDUCE #( INIT amount TYPE zarete_dbs_de_finteo_amount
                                                        FOR ls_itm IN <fs_header>-item
                                                        WHERE ( accounting_document = <fs_t043_DZ_ODM>-AccountingDocument
                                                          AND   accounting_document_item = <fs_t043_DZ_ODM>-AccountingDocumentItem )
                                                        NEXT amount = amount + ls_itm-amount ).

                          lv_odm_dz_tot = REDUCE #( INIT amount TYPE zarete_dbs_de_finteo_amount
                                              FOR ls_t43 IN lt_t043
                                              WHERE ( InvoiceReference EQ <fs_t043_DZ_ODM>-AccountingDocument
                                                AND   InvoiceReferenceFiscalYear EQ <fs_t043_DZ_ODM>-FiscalYear
                                                AND   DocumentAmount NE 0 )
                                              NEXT amount = amount + ls_t43-OriginalAmount ).



                          DELETE <fs_header>-item WHERE accounting_document = <fs_t043_DZ_ODM>-AccountingDocument
                                                   AND  accounting_document_item = <fs_t043_DZ_ODM>-AccountingDocumentItem.

                          APPEND INITIAL LINE TO <fs_header>-item ASSIGNING <fs_item>.
                          <fs_item>-accounting_document      = <fs_t043_DZ_ODM>-AccountingDocument.
                          <fs_item>-accounting_document_item = <fs_t043_DZ_ODM>-AccountingDocumentItem.
                          <fs_item>-currency                 = <fs_t043_DZ_ODM>-Currency.
                          <fs_item>-fiscal_year              = <fs_t043_DZ_ODM>-FiscalYear.
                          <fs_item>-inv_number               = <fs_main_inv>-InvoiceNumber.
                          <fs_item>-partial_invoice_number   = <fs_main_inv>-PartialInvoiceNumber.
                          <fs_item>-id                       = <fs_main_inv>-Id.

                          lv_odeme_dz -= lv_used_odm.
                          lv_odm_total += lv_used_odm.

                          " Ödeme Belgesinin Kalanını Düş
                          IF lv_used_odm NE lv_odm_amount.
                            <fs_item>-amount += abs( lv_used_odm ) + lv_odm_amount_tot + lv_odm_dz_tot.
                            <fs_item>-used_amount = <fs_item>-amount.
                            <fs_t043_DZ_ODM>-DocumentAmount -= ( lv_used_odm * -1 )."abs alındığı için çıkarttık
                            <fs_t043_DZ_ODM>-DocumentAmountAbs = abs( <fs_t043_DZ_ODM>-DocumentAmount ).
                          ELSE.
                            CLEAR: <fs_item>-amount.
                            <fs_item>-used_amount         = lv_used_odm.
                            <fs_t043_DZ_ODM>-DocumentAmount = 0.
                            <fs_t043_DZ_ODM>-DocumentAmountAbs = abs( <fs_t043_DZ_ODM>-DocumentAmount ).
                          ENDIF.

                          APPEND INITIAL LINE TO <fs_header>-t024 ASSIGNING <fs_t024>.
                          <fs_t024> = CORRESPONDING #( <fs_item> ).

                        ENDIF.
                      ENDIF.

                    ENDLOOP.

                  ENDIF.

                  <fs_t043_dz>-Changed = abap_true.
                  <fs_t043_dz>-DocumentAmountAbs = abs( <fs_t043_dz>-DocumentAmount ).

                ENDLOOP.

              ENDIF.
            ENDIF.

          ENDLOOP.

*Faturanın büyük olduğu durumda kalan tutar partial kısmına verilir
          IF lv_inv_kalan GT lv_odm_total AND <fs_fatura> IS ASSIGNED.
            <fs_fatura>-amount = abs( lv_odm_total ).
          ELSEIF lv_inv_kalan EQ 0 and <fs_fatura> IS ASSIGNED.
            CLEAR: <fs_fatura>-amount.
          ELSE.
            <fs_fatura>-amount = abs( lv_odm_total ).
          ENDIF.

        ENDLOOP.

      ENDLOOP.

      " UE BELGELERİ VARSA GİR YOKSA GİRME !!!
      IF ls_journalentry IS NOT INITIAL.
        READ TABLE lt_header ASSIGNING FIELD-SYMBOL(<fs_head>) INDEX 1.
        DATA(lv_amountt) = REDUCE #( INIT amount TYPE zarete_dbs_de_finteo_amount
                                              FOR ls_main_inv IN lt_main_inv
                                              WHERE ( DocumentDate IS INITIAL
                                                AND   AccountingDocument IS NOT INITIAL )
                                              NEXT amount = amount + ls_main_inv-Amount ).

        DATA(lv_UE_DZ) = REDUCE #( INIT amount TYPE zarete_dbs_de_finteo_amount
                                             FOR ls_043 IN lt_t043
                                             WHERE ( InvoiceReference       = ls_journalentry-AccountingDocument
                                               AND   AccountingDocumentType = 'DZ'
                                               AND   DebitCreditCode        = 'H'  )
                                             NEXT amount = amount + ls_043-OriginalAmount ).
        lv_amountt += abs( lv_UE_DZ ).

        IF lv_amountt LT ls_journalentry-AmountInTransactionCurrency.
          LOOP AT <fs_head>-item ASSIGNING FIELD-SYMBOL(<fs_itm>) WHERE inv_type = 'F'.
            <fs_itm>-amount = lv_amountt.
          ENDLOOP.
        ELSE.
          LOOP AT <fs_head>-item ASSIGNING <fs_itm> WHERE inv_type NE 'F'.
            LOOP AT <fs_head>-t024 ASSIGNING FIELD-SYMBOL(<fs_t024_new>) WHERE accounting_document = <fs_itm>-accounting_document
                                                                           AND accounting_document_item = <fs_itm>-accounting_document_item.
              <fs_itm>-amount += <fs_t024_new>-used_amount.
            ENDLOOP.
          ENDLOOP.
        ENDIF.
      ENDIF.

      lo_util->clearing_mapping_v2( EXPORTING it_header = lt_header
                                    IMPORTING es_request = ls_request ).

      lo_denk->input = ls_request.
      APPEND lo_denk TO lt_in_tab.

      lo_parallel->run_inst( EXPORTING p_in_tab  = lt_in_tab  IMPORTING p_out_tab = lt_out_tab ).

    ENDLOOP.

  ENDMETHOD.


  METHOD clearing_mapping_v2.

    DATA: lt_in_tab    TYPE cl_abap_parallel=>t_in_inst_tab,
          lt_out_tab   TYPE cl_abap_parallel=>t_out_inst_tab,
          lv_itemno    TYPE zfi_denk_business_transaction,
          lt_t024      TYPE TABLE OF zarete_dbs_t024,
          lv_remaining TYPE zarete_dbs_t017-amount_in_transaction_curr,
          lv_time      TYPE n LENGTH 2.

    DATA(ls_request) = VALUE zfi_denk_journal_entry_bulk_cl( ).

    TRY.
        DATA(lv_uuid) = cl_system_uuid=>create_uuid_c32_static( ).
        REPLACE ALL OCCURRENCES OF '-' IN lv_uuid WITH ''.
      CATCH cx_uuid_error INTO DATA(lo_error).
        DATA(lv_longtext) = lo_error->get_longtext( ).
    ENDTRY.

    DATA: lv_timestamp TYPE timestampl.
    GET TIME STAMP FIELD lv_timestamp.


*Message Header Verileri
    ls_request-journal_entry_bulk_clearing_re-message_header-id-content                = lv_uuid.
    ls_request-journal_entry_bulk_clearing_re-message_header-uuid-content              = lv_uuid.
    ls_request-journal_entry_bulk_clearing_re-message_header-creation_date_time        = lv_timestamp.
    ls_request-journal_entry_bulk_clearing_re-message_header-sender_business_system_id = 'EXT_SYS'.

*Clearing Request Journal Entry

    LOOP AT it_header ASSIGNING FIELD-SYMBOL(<fs_header>).

      TRY.
          DATA(lv_item_uuid) = cl_system_uuid=>create_uuid_c32_static( ).
          REPLACE ALL OCCURRENCES OF '-' IN lv_uuid WITH ''.
        CATCH cx_uuid_error INTO lo_error.
          lv_longtext = lo_error->get_longtext( ).
      ENDTRY.

*Clearing Request
      APPEND INITIAL LINE TO ls_request-journal_entry_bulk_clearing_re-journal_entry_clearing_request
      ASSIGNING FIELD-SYMBOL(<fs_clearing_request>).
      <fs_clearing_request>-message_header-id-content         = lv_item_uuid.
      <fs_clearing_request>-message_header-uuid-content       = lv_item_uuid.
      <fs_clearing_request>-message_header-creation_date_time = lv_timestamp.

      <fs_clearing_request>-journal_entry-company_code             = '1000'.
      <fs_clearing_request>-journal_entry-accounting_document_type = 'DZ'.
      <fs_clearing_request>-journal_entry-document_date            = cl_abap_context_info=>get_system_date( ).
      <fs_clearing_request>-journal_entry-posting_date             = cl_abap_context_info=>get_system_date( ).
      <fs_clearing_request>-journal_entry-currency_code            = <fs_header>-currency.
      <fs_clearing_request>-journal_entry-reference_document       = 'DBS DENKL.'.
      <fs_clearing_request>-journal_entry-document_header_text     = 'DBS DENKLEŞTİRME'.
      <fs_clearing_request>-journal_entry-created_by_user          = sy-uname.


      LOOP AT <fs_header>-item ASSIGNING FIELD-SYMBOL(<fs_item>).

        APPEND INITIAL LINE TO <fs_clearing_request>-journal_entry-aparitems ASSIGNING FIELD-SYMBOL(<fs_aparitems>).

        lv_itemno += 1.
        CONDENSE lv_itemno.

        <fs_aparitems>-reference_document_item  = lv_itemno.
        <fs_aparitems>-company_code             = '1000'.
        <fs_aparitems>-account_type             = 'D'.
        <fs_aparitems>-aparaccount              = |{ <fs_header>-customer ALPHA = OUT }|.
        <fs_aparitems>-fiscal_year              = <fs_item>-fiscal_year.
        <fs_aparitems>-accounting_document      = <fs_item>-accounting_document.
        <fs_aparitems>-accounting_document_item = <fs_item>-accounting_document_item.

        IF <fs_item>-amount GT 0.
          <fs_aparitems>-partial_payment_amt_in_dsp_crc-content       = <fs_item>-amount.
          <fs_aparitems>-partial_payment_amt_in_dsp_crc-currency_code = <fs_item>-currency.
        ENDIF.

*Denkleştirme için gönderilen belgeler takip tablosunun doldurulması

        LOOP AT <fs_header>-t024 ASSIGNING FIELD-SYMBOL(<fs_t024>) WHERE accounting_document = <fs_item>-accounting_document
                                                                   AND   accounting_document_item = <fs_item>-accounting_document_item.

          IF <fs_t024>-inv_type EQ 'F'.

            DATA(lv_invno)   = <fs_t024>-accounting_document.
            DATA(lv_invitem) = <fs_t024>-accounting_document_item.

          ELSE.

            lv_time += 1.
            APPEND INITIAL LINE TO lt_t024 ASSIGNING FIELD-SYMBOL(<fs_t024_modif>).
            <fs_t024_modif>-client                   = sy-mandt.
            <fs_t024_modif>-uuid                     = lv_uuid.
            <fs_t024_modif>-item_uuid                = lv_item_uuid.
            <fs_t024_modif>-invoice_number           = <fs_t024>-inv_number.
            <fs_t024_modif>-partial_invoice_number   = <fs_t024>-partial_invoice_number.
            <fs_t024_modif>-id                       = <fs_t024>-id.
            <fs_t024_modif>-accounting_document      = <fs_t024>-accounting_document.
            <fs_t024_modif>-accounting_document_item = <fs_t024>-accounting_document_item.
            <fs_t024_modif>-invoice_acc_doc          = lv_invno.
            <fs_t024_modif>-invoice_acc_doc_item     = lv_invitem.
            <fs_t024_modif>-customer                 = <fs_header>-customer.
            <fs_t024_modif>-invoice_amount           = <fs_t024>-amount.
            <fs_t024_modif>-clearing_doc_amount      = <fs_t024>-amount.
            <fs_t024_modif>-used_amount              = <fs_t024>-used_amount.
            <fs_t024_modif>-currency                 = <fs_t024>-currency.
            <fs_t024_modif>-message                  = 'Denkleştirme İşleniyor.'.
            <fs_t024_modif>-status                   = 'B'.
            <fs_t024_modif>-response_date            = cl_abap_context_info=>get_system_date( ).
            <fs_t024_modif>-response_time            = cl_abap_context_info=>get_system_time( ) + lv_time.

          ENDIF.

        ENDLOOP.

      ENDLOOP.

      CLEAR: lv_invno, lv_invitem.

    ENDLOOP.


    DATA(lo_parallel) = NEW cl_abap_parallel( ).
    DATA(lo_modify) = NEW zcl_fi_denk_modify( ).

    lo_modify->input = lt_t024.
    APPEND lo_modify TO lt_in_tab.
    lo_parallel->run_inst( EXPORTING p_in_tab  = lt_in_tab  IMPORTING p_out_tab = lt_out_tab ).

    es_request = ls_request.

  ENDMETHOD.


  METHOD add_log_text.
    IF go_log IS NOT BOUND OR iv_text IS INITIAL.
      RETURN.
    ENDIF.
    TRY.
        go_log->add_item( cl_bali_free_text_setter=>create(
                            severity = iv_severity
                            text     = CONV #( iv_text ) ) ).
      CATCH cx_bali_runtime ##NO_HANDLER.
    ENDTRY.
  ENDMETHOD.


  METHOD get_limit_data.

    DATA: lt_limit     TYPE zarete_dbs_sc_finteo_api=>ty_limit.

    DATA(lo_finteo_lmt) = NEW zarete_dbs_sc_finteo_api( ).
    DATA(lo_log) = zarete_dbs_cl_log=>get_factory( ).

    SELECT *                                            "#EC CI_NOWHERE
    FROM zarete_dbs_t014
    INTO TABLE @DATA(lt_t014).                "#EC CI_ALL_FIELDS_NEEDED


    LOOP AT lt_t014 ASSIGNING FIELD-SYMBOL(<fs_t014>).

      lo_finteo_lmt->get_limit(
      EXPORTING
      iv_identifier = <fs_t014>-company_identifier
      iv_bankid     = CONV string( iv_bankcode )
      iv_partycode  = CONV string( iv_partycode )
      RECEIVING
      rv_limit      = lt_limit ).


      IF lt_limit-status EQ 'OK'.

        me->fill_limit_tables( EXPORTING iv_company_code = '1000' iv_behavior = iv_behavior
                               CHANGING  ct_limit = lt_limit  ).

        et_limit-status = lt_limit-status.
        et_limit-statusmessage = lt_limit-statusmessage.
        APPEND LINES OF lt_limit-data TO et_limit-data.

        IF lt_limit-statusmessage IS NOT INITIAL.
          add_log_text( iv_text     = |{ <fs_t014>-company_identifier }: { lt_limit-statusmessage }|
                        iv_severity = if_bali_constants=>c_severity_status ).
        ELSE.
          add_log_text( iv_text     = |{ <fs_t014>-company_identifier }: Limit verisi başarıyla işlendi ({ lines( lt_limit-data ) } kayıt).|
                        iv_severity = if_bali_constants=>c_severity_status ).
        ENDIF.
      ELSE.
        " Finteo limit servisi OK dönmedi → hata logla
        add_log_text( iv_text     = |{ <fs_t014>-company_identifier }: Limit alınamadı. Status: { lt_limit-status } { lt_limit-statusmessage }|
                      iv_severity = if_bali_constants=>c_severity_error ).
      ENDIF.

    ENDLOOP.

  ENDMETHOD.


  METHOD set_log.
    go_log = io_log.
  ENDMETHOD.
ENDCLASS.
