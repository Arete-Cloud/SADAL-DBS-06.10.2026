"! <p class="shorttext synchronized">Consumption model for client proxy - generated</p>
"! This class has been generated based on the metadata with namespace
"! <em>API_OPLACCTGDOCITEMCUBE_SRV</em>
CLASS zarete_dbs_sc_doc_read_api DEFINITION
  PUBLIC
  INHERITING FROM /iwbep/cl_v4_abs_pm_model_prov
  CREATE PUBLIC.

  PUBLIC SECTION.

    TYPES:
      "! <p class="shorttext synchronized">A_OperationalAcctgDocItemCubeType</p>
      BEGIN OF tys_a_operational_acctg_doc__2,
        "! <em>Key property</em> CompanyCode
        company_code               TYPE c LENGTH 4,
        "! <em>Key property</em> FiscalYear
        fiscal_year                TYPE c LENGTH 4,
        "! <em>Key property</em> AccountingDocument
        accounting_document        TYPE c LENGTH 10,
        "! <em>Key property</em> AccountingDocumentItem
        accounting_document_item   TYPE c LENGTH 3,
        "! CompanyCodeName
        company_code_name          TYPE c LENGTH 25,
        "! ChartOfAccounts
        chart_of_accounts          TYPE c LENGTH 4,
        "! AccountingDocumentItemType
        accounting_document_item_t TYPE c LENGTH 1,
        "! ClearingDate
        clearing_date              TYPE datn,
        "! ClearingCreationDate
        clearing_creation_date     TYPE datn,
        "! ClearingAccountingDocument
        clearing_accounting_docume TYPE c LENGTH 10,
        "! IsCleared
        is_cleared                 TYPE abap_bool,
        "! PostingKey
        posting_key                TYPE c LENGTH 2,
        "! FinancialAccountType
        financial_account_type     TYPE c LENGTH 1,
        "! SpecialGLCode
        special_glcode             TYPE c LENGTH 1,
        "! SpecialGLTransactionType
        special_gltransaction_type TYPE c LENGTH 1,
        "! DebitCreditCode
        debit_credit_code          TYPE c LENGTH 1,
        "! BusinessArea
        business_area              TYPE c LENGTH 4,
        "! BusinessAreaName
        business_area_name         TYPE c LENGTH 30,
        "! PartnerBusinessArea
        partner_business_area      TYPE c LENGTH 4,
        "! TaxCode
        tax_code                   TYPE c LENGTH 2,
        "! WithholdingTaxCode
        withholding_tax_code       TYPE c LENGTH 2,
        "! TaxType
        tax_type                   TYPE c LENGTH 1,
        "! TransactionTypeDetermination
        transaction_type_determina TYPE c LENGTH 3,
        "! ValueDate
        value_date                 TYPE datn,
        "! AssignmentReference
        assignment_reference       TYPE c LENGTH 18,
        "! DocumentItemText
        document_item_text         TYPE c LENGTH 50,
        "! PartnerCompany
        partner_company            TYPE c LENGTH 6,
        "! FinancialTransactionType
        financial_transaction_type TYPE c LENGTH 3,
        "! CorporateGroupAccount
        corporate_group_account    TYPE c LENGTH 10,
        "! PlanningLevel
        planning_level             TYPE c LENGTH 2,
        "! ControllingArea
        controlling_area           TYPE c LENGTH 4,
        "! ControllingAreaName
        controlling_area_name      TYPE c LENGTH 25,
        "! CostCenter
        cost_center                TYPE c LENGTH 10,
        "! CostCenterName
        cost_center_name           TYPE c LENGTH 20,
        "! Project
        project                    TYPE c LENGTH 24,
        "! OrderID
        order_id                   TYPE c LENGTH 12,
        "! BillingDocument
        billing_document           TYPE c LENGTH 10,
        "! SalesDocument
        sales_document             TYPE c LENGTH 10,
        "! SalesDocumentItem
        sales_document_item        TYPE c LENGTH 6,
        "! ScheduleLine
        schedule_line              TYPE c LENGTH 4,
        "! MasterFixedAsset
        master_fixed_asset         TYPE c LENGTH 12,
        "! FixedAsset
        fixed_asset                TYPE c LENGTH 4,
        "! AssetTransactionType
        asset_transaction_type     TYPE c LENGTH 3,
        "! AssetValueDate
        asset_value_date           TYPE datn,
        "! PersonnelNumber
        personnel_number           TYPE c LENGTH 8,
        "! IsSalesRelated
        is_sales_related           TYPE abap_bool,
        "! LineItemDisplayIsEnabled
        line_item_display_is_enabl TYPE abap_bool,
        "! IsOpenItemManaged
        is_open_item_managed       TYPE c LENGTH 1,
        "! IsNotCashDiscountLiable
        is_not_cash_discount_liabl TYPE abap_bool,
        "! IsAutomaticallyCreated
        is_automatically_created   TYPE abap_bool,
        "! IsUsedInPaymentTransaction
        is_used_in_payment_transac TYPE abap_bool,
        "! OperationalGLAccount
        operational_glaccount      TYPE c LENGTH 10,
        "! GLAccount
        glaccount                  TYPE c LENGTH 10,
        "! GLAccountName
        glaccount_name             TYPE c LENGTH 30,
        "! GLAccountLongName
        glaccount_long_name        TYPE c LENGTH 50,
        "! Customer
        customer                   TYPE c LENGTH 10,
        "! CustomerName
        customer_name              TYPE c LENGTH 80,
        "! Supplier
        supplier                   TYPE c LENGTH 10,
        "! SupplierName
        supplier_name              TYPE c LENGTH 80,
        "! BranchAccount
        branch_account             TYPE c LENGTH 10,
        "! IsBalanceSheetAccount
        is_balance_sheet_account   TYPE abap_bool,
        "! ProfitLossAccountType
        profit_loss_account_type   TYPE c LENGTH 2,
        "! SpecialGLAccountAssignment
        special_glaccount_assignme TYPE c LENGTH 18,
        "! DueCalculationBaseDate
        due_calculation_base_date  TYPE datn,
        "! PaymentTerms
        payment_terms              TYPE c LENGTH 4,
        "! CashDiscount1Days
        cash_discount_1_days       TYPE p LENGTH 2 DECIMALS 0,
        "! CashDiscount2Days
        cash_discount_2_days       TYPE p LENGTH 2 DECIMALS 0,
        "! NetPaymentDays
        net_payment_days           TYPE p LENGTH 2 DECIMALS 0,
        "! CashDiscount1Percent
        cash_discount_1_percent    TYPE p LENGTH 3 DECIMALS 3,
        "! CashDiscount2Percent
        cash_discount_2_percent    TYPE p LENGTH 3 DECIMALS 3,
        "! PaymentReason
        payment_reason             TYPE c LENGTH 4,
        "! PaymentMethod
        payment_method             TYPE c LENGTH 1,
        "! PaymentBlockingReason
        payment_blocking_reason    TYPE c LENGTH 1,
        "! FixedCashDiscount
        fixed_cash_discount        TYPE c LENGTH 1,
        "! HouseBank
        house_bank                 TYPE c LENGTH 5,
        "! BPBankAccountInternalID
        bpbank_account_internal_id TYPE c LENGTH 4,
        "! TaxDistributionCode1
        tax_distribution_code_1    TYPE c LENGTH 2,
        "! TaxDistributionCode2
        tax_distribution_code_2    TYPE c LENGTH 2,
        "! TaxDistributionCode3
        tax_distribution_code_3    TYPE c LENGTH 2,
        "! InvoiceReference
        invoice_reference          TYPE c LENGTH 10,
        "! InvoiceReferenceFiscalYear
        invoice_reference_fiscal_y TYPE c LENGTH 4,
        "! InvoiceItemReference
        invoice_item_reference     TYPE c LENGTH 3,
        "! FollowOnDocumentType
        follow_on_document_type    TYPE c LENGTH 1,
        "! StateCentralBankPaymentReason
        state_central_bank_payment TYPE c LENGTH 3,
        "! SupplyingCountry
        supplying_country          TYPE c LENGTH 3,
        "! InvoiceList
        invoice_list               TYPE c LENGTH 8,
        "! BillOfExchangeUsage
        bill_of_exchange_usage     TYPE c LENGTH 1,
        "! DunningKey
        dunning_key                TYPE c LENGTH 1,
        "! DunningBlockingReason
        dunning_blocking_reason    TYPE c LENGTH 1,
        "! LastDunningDate
        last_dunning_date          TYPE datn,
        "! DunningLevel
        dunning_level              TYPE c LENGTH 1,
        "! DunningArea
        dunning_area               TYPE c LENGTH 2,
        "! WithholdingTaxCertificate
        withholding_tax_certificat TYPE c LENGTH 10,
        "! Material
        material                   TYPE c LENGTH 40,
        "! Product
        product                    TYPE c LENGTH 40,
        "! Plant
        plant                      TYPE c LENGTH 4,
        "! PurchasingDocument
        purchasing_document        TYPE c LENGTH 10,
        "! PurchasingDocumentItem
        purchasing_document_item   TYPE c LENGTH 5,
        "! AccountAssignmentNumber
        account_assignment_number  TYPE c LENGTH 2,
        "! IsCompletelyDelivered
        is_completely_delivered    TYPE abap_bool,
        "! MaterialPriceControl
        material_price_control     TYPE c LENGTH 1,
        "! ValuationArea
        valuation_area             TYPE c LENGTH 4,
        "! InventoryValuationType
        inventory_valuation_type   TYPE c LENGTH 10,
        "! VATRegistration
        vatregistration            TYPE c LENGTH 20,
        "! DelivOfGoodsDestCountry
        deliv_of_goods_dest_countr TYPE c LENGTH 3,
        "! PaymentDifferenceReason
        payment_difference_reason  TYPE c LENGTH 3,
        "! ProfitCenter
        profit_center              TYPE c LENGTH 10,
        "! ProfitCenterName
        profit_center_name         TYPE c LENGTH 20,
        "! JointVenture
        joint_venture              TYPE c LENGTH 6,
        "! JointVentureCostRecoveryCode
        joint_venture_cost_recover TYPE c LENGTH 2,
        "! JointVentureEquityGroup
        joint_venture_equity_group TYPE c LENGTH 3,
        "! JointVenturePartner
        joint_venture_partner      TYPE c LENGTH 10,
        "! TreasuryContractType
        treasury_contract_type     TYPE c LENGTH 1,
        "! AssetContract
        asset_contract             TYPE c LENGTH 13,
        "! CashFlowType
        cash_flow_type             TYPE c LENGTH 4,
        "! TaxJurisdiction
        tax_jurisdiction           TYPE c LENGTH 15,
        "! RealEstateObject
        real_estate_object         TYPE c LENGTH 40,
        "! SettlementReferenceDate
        settlement_reference_date  TYPE datn,
        "! CommitmentItem
        commitment_item            TYPE c LENGTH 24,
        "! CostObject
        cost_object                TYPE c LENGTH 12,
        "! ProjectNetwork
        project_network            TYPE c LENGTH 12,
        "! OrderInternalBillOfOperations
        order_internal_bill_of_ope TYPE c LENGTH 10,
        "! OrderIntBillOfOperationsItem
        order_int_bill_of_operatio TYPE c LENGTH 8,
        "! WBSElementInternalID
        wbselement_internal_id     TYPE c LENGTH 8,
        "! ProfitabilitySegment
        profitability_segment      TYPE c LENGTH 10,
        "! JointVentureBillingType
        joint_venture_billing_type TYPE c LENGTH 2,
        "! JointVentureEquityType
        joint_venture_equity_type  TYPE c LENGTH 3,
        "! IsEUTriangularDeal
        is_eutriangular_deal       TYPE abap_bool,
        "! CostOriginGroup
        cost_origin_group          TYPE c LENGTH 4,
        "! CompanyCodeCurrencyDetnMethod
        company_code_currency_detn TYPE c LENGTH 1,
        "! ClearingIsReversed
        clearing_is_reversed       TYPE abap_bool,
        "! PaymentMethodSupplement
        payment_method_supplement  TYPE c LENGTH 2,
        "! AlternativeGLAccount
        alternative_glaccount      TYPE c LENGTH 10,
        "! FundsCenter
        funds_center               TYPE c LENGTH 16,
        "! Fund
        fund                       TYPE c LENGTH 10,
        "! PartnerProfitCenter
        partner_profit_center      TYPE c LENGTH 10,
        "! Reference1IDByBusinessPartner
        reference_1_idby_business  TYPE c LENGTH 12,
        "! Reference2IDByBusinessPartner
        reference_2_idby_business  TYPE c LENGTH 12,
        "! IsNegativePosting
        is_negative_posting        TYPE abap_bool,
        "! PaymentCardItem
        payment_card_item          TYPE c LENGTH 3,
        "! PaymentCardPaymentSettlement
        payment_card_payment_settl TYPE c LENGTH 10,
        "! CreditControlArea
        credit_control_area        TYPE c LENGTH 4,
        "! Reference3IDByBusinessPartner
        reference_3_idby_business  TYPE c LENGTH 20,
        "! DataExchangeInstruction1
        data_exchange_instruction  TYPE c LENGTH 2,
        "! DataExchangeInstruction2
        data_exchange_instructio_2 TYPE c LENGTH 2,
        "! DataExchangeInstruction3
        data_exchange_instructio_3 TYPE c LENGTH 2,
        "! DataExchangeInstruction4
        data_exchange_instructio_4 TYPE c LENGTH 2,
        "! Region
        region                     TYPE c LENGTH 3,
        "! HasPaymentOrder
        has_payment_order          TYPE abap_bool,
        "! PaymentReference
        payment_reference          TYPE c LENGTH 30,
        "! TaxDeterminationDate
        tax_determination_date     TYPE datn,
        "! ClearingItem
        clearing_item              TYPE p LENGTH 3 DECIMALS 0,
        "! BusinessPlace
        business_place             TYPE c LENGTH 4,
        "! TaxSection
        tax_section                TYPE c LENGTH 4,
        "! CostCtrActivityType
        cost_ctr_activity_type     TYPE c LENGTH 6,
        "! AccountsReceivableIsPledged
        accounts_receivable_is_ple TYPE c LENGTH 2,
        "! BusinessProcess
        business_process           TYPE c LENGTH 12,
        "! GrantID
        grant_id                   TYPE c LENGTH 20,
        "! FunctionalArea
        functional_area            TYPE c LENGTH 16,
        "! FunctionalAreaName
        functional_area_name       TYPE c LENGTH 30,
        "! CustomerIsInExecution
        customer_is_in_execution   TYPE abap_bool,
        "! FundedProgram
        funded_program             TYPE c LENGTH 24,
        "! ClearingDocFiscalYear
        clearing_doc_fiscal_year   TYPE c LENGTH 4,
        "! LedgerGLLineItem
        ledger_glline_item         TYPE c LENGTH 6,
        "! Segment
        segment                    TYPE c LENGTH 10,
        "! SegmentName
        segment_name               TYPE c LENGTH 50,
        "! PartnerSegment
        partner_segment            TYPE c LENGTH 10,
        "! PartnerFunctionalArea
        partner_functional_area    TYPE c LENGTH 16,
        "! HouseBankAccount
        house_bank_account         TYPE c LENGTH 5,
        "! CostElement
        cost_element               TYPE c LENGTH 10,
        "! SEPAMandate
        sepamandate                TYPE c LENGTH 35,
        "! ReferenceDocumentType
        reference_document_type    TYPE c LENGTH 5,
        "! OriginalReferenceDocument
        original_reference_documen TYPE c LENGTH 20,
        "! ReferenceDocumentLogicalSystem
        reference_document_logical TYPE c LENGTH 10,
        "! AccountingDocumentItemRef
        accounting_document_item_r TYPE c LENGTH 10,
        "! FiscalPeriod
        fiscal_period              TYPE c LENGTH 3,
        "! AccountingDocumentCategory
        accounting_document_catego TYPE c LENGTH 1,
        "! AccountingDocumentCategoryName
        accounting_document_cate_2 TYPE c LENGTH 60,
        "! PostingDate
        posting_date               TYPE datn,
        "! DocumentDate
        document_date              TYPE datn,
        "! AccountingDocumentType
        accounting_document_type   TYPE c LENGTH 2,
        "! AccountingDocumentTypeName
        accounting_document_type_n TYPE c LENGTH 20,
        "! NetDueDate
        net_due_date               TYPE datn,
        "! CashDiscount1DueDate
        cash_discount_1_due_date   TYPE datn,
        "! CashDiscount2DueDate
        cash_discount_2_due_date   TYPE datn,
        "! OffsettingAccount
        offsetting_account         TYPE c LENGTH 10,
        "! OffsettingAccountType
        offsetting_account_type    TYPE c LENGTH 1,
        "! PartnerFund
        partner_fund               TYPE c LENGTH 10,
        "! PartnerGrant
        partner_grant              TYPE c LENGTH 20,
        "! BudgetPeriod
        budget_period              TYPE c LENGTH 10,
        "! PartnerBudgetPeriod
        partner_budget_period      TYPE c LENGTH 10,
        "! BranchCode
        branch_code                TYPE c LENGTH 5,
        "! JointVentureProductionDate
        joint_venture_production_d TYPE datn,
        "! CompanyCodeCurrency
        company_code_currency      TYPE c LENGTH 5,
        "! AmountInCompanyCodeCurrency
        amount_in_company_code_cur TYPE p LENGTH 13 DECIMALS 3,
        "! TaxAmountInCoCodeCrcy
        tax_amount_in_co_code_crcy TYPE p LENGTH 13 DECIMALS 3,
        "! TaxBaseAmountInCoCodeCrcy
        tax_base_amount_in_co_code TYPE p LENGTH 13 DECIMALS 3,
        "! ValuationDiffAmtInCoCodeCrcy
        valuation_diff_amt_in_co_c TYPE p LENGTH 13 DECIMALS 3,
        "! CashDiscountAmtInCoCodeCrcy
        cash_discount_amt_in_co_co TYPE p LENGTH 13 DECIMALS 3,
        "! InvoiceAmtInCoCodeCrcy
        invoice_amt_in_co_code_crc TYPE p LENGTH 13 DECIMALS 3,
        "! TransactionCurrency
        transaction_currency       TYPE c LENGTH 5,
        "! AmountInTransactionCurrency
        amount_in_transaction_curr TYPE p LENGTH 13 DECIMALS 3,
        "! OriginalTaxBaseAmount
        original_tax_base_amount   TYPE p LENGTH 13 DECIMALS 3,
        "! TaxAmount
        tax_amount                 TYPE p LENGTH 13 DECIMALS 3,
        "! TaxBaseAmountInTransCrcy
        tax_base_amount_in_trans_c TYPE p LENGTH 13 DECIMALS 3,
        "! WithholdingTaxBaseAmount
        withholding_tax_base_amoun TYPE p LENGTH 13 DECIMALS 3,
        "! PlannedAmtInTransactionCrcy
        planned_amt_in_transaction TYPE p LENGTH 13 DECIMALS 3,
        "! CashDiscountBaseAmount
        cash_discount_base_amount  TYPE p LENGTH 13 DECIMALS 3,
        "! CashDiscountAmount
        cash_discount_amount       TYPE p LENGTH 13 DECIMALS 3,
        "! NetPaymentAmount
        net_payment_amount         TYPE p LENGTH 13 DECIMALS 3,
        "! WithholdingTaxAmount
        withholding_tax_amount     TYPE p LENGTH 13 DECIMALS 3,
        "! WithholdingTaxExemptionAmt
        withholding_tax_exemption  TYPE p LENGTH 13 DECIMALS 3,
        "! InvoiceAmountInFrgnCurrency
        invoice_amount_in_frgn_cur TYPE p LENGTH 13 DECIMALS 3,
        "! BalanceTransactionCurrency
        balance_transaction_curren TYPE c LENGTH 5,
        "! AmountInBalanceTransacCrcy
        amount_in_balance_transac  TYPE p LENGTH 13 DECIMALS 3,
        "! AdditionalCurrency1
        additional_currency_1      TYPE c LENGTH 5,
        "! ValuationDiffAmtInAddlCrcy1
        valuation_diff_amt_in_addl TYPE p LENGTH 13 DECIMALS 3,
        "! AmountInAdditionalCurrency1
        amount_in_additional_curre TYPE p LENGTH 13 DECIMALS 3,
        "! AdditionalCurrency2
        additional_currency_2      TYPE c LENGTH 5,
        "! AmountInAdditionalCurrency2
        amount_in_additional_cur_2 TYPE p LENGTH 13 DECIMALS 3,
        "! ValuationDiffAmtInAddlCrcy2
        valuation_diff_amt_in_ad_2 TYPE p LENGTH 13 DECIMALS 3,
        "! PaymentCurrency
        payment_currency           TYPE c LENGTH 5,
        "! AmountInPaymentCurrency
        amount_in_payment_currency TYPE p LENGTH 13 DECIMALS 3,
        "! CreditControlAreaCurrency
        credit_control_area_curren TYPE c LENGTH 5,
        "! HedgedAmount
        hedged_amount              TYPE p LENGTH 13 DECIMALS 3,
        "! BaseUnit
        base_unit                  TYPE c LENGTH 3,
        "! Quantity
        quantity                   TYPE p LENGTH 12 DECIMALS 3,
        "! GoodsMovementEntryUnit
        goods_movement_entry_unit  TYPE c LENGTH 3,
        "! QuantityInEntryUnit
        quantity_in_entry_unit     TYPE p LENGTH 7 DECIMALS 3,
        "! PurchasingDocumentPriceUnit
        purchasing_document_price  TYPE c LENGTH 3,
        "! PurchaseOrderQty
        purchase_order_qty         TYPE p LENGTH 7 DECIMALS 3,
        "! MaterialPriceUnitQty
        material_price_unit_qty    TYPE p LENGTH 3 DECIMALS 0,
        "! NumberOfItems
        number_of_items            TYPE p LENGTH 7 DECIMALS 0,
        "! AccountingDocumentCreationDate
        accounting_document_creati TYPE datn,
        "! CreationTime
        creation_time              TYPE timn,
        "! LastChangeDate
        last_change_date           TYPE datn,
        "! ExchangeRateDate
        exchange_rate_date         TYPE datn,
        "! AccountingDocCreatedByUser
        accounting_doc_created_by  TYPE c LENGTH 12,
        "! TransactionCode
        transaction_code           TYPE c LENGTH 20,
        "! IntercompanyTransaction
        intercompany_transaction   TYPE c LENGTH 16,
        "! DocumentReferenceID
        document_reference_id      TYPE c LENGTH 16,
        "! RecurringAccountingDocument
        recurring_accounting_docum TYPE c LENGTH 10,
        "! ReverseDocument
        reverse_document           TYPE c LENGTH 10,
        "! ReverseDocumentFiscalYear
        reverse_document_fiscal_ye TYPE c LENGTH 4,
        "! AccountingDocumentHeaderText
        accounting_document_header TYPE c LENGTH 25,
        "! ExchangeRate
        exchange_rate              TYPE p LENGTH 5 DECIMALS 5,
        "! BusinessTransactionType
        business_transaction_type  TYPE c LENGTH 4,
        "! BatchInputSession
        batch_input_session        TYPE c LENGTH 12,
        "! FinancialManagementArea
        financial_management_area  TYPE c LENGTH 4,
        "! ReversalIsPlanned
        reversal_is_planned        TYPE abap_bool,
        "! PlannedReversalDate
        planned_reversal_date      TYPE datn,
        "! TaxIsCalculatedAutomatically
        tax_is_calculated_automati TYPE abap_bool,
        "! TaxBaseAmountIsNetAmount
        tax_base_amount_is_net_amo TYPE abap_bool,
        "! SourceCompanyCode
        source_company_code        TYPE c LENGTH 4,
        "! LogicalSystem
        logical_system             TYPE c LENGTH 10,
        "! TaxExchangeRate
        tax_exchange_rate          TYPE p LENGTH 5 DECIMALS 5,
        "! ReversalReason
        reversal_reason            TYPE c LENGTH 2,
        "! Branch
        branch                     TYPE c LENGTH 4,
        "! Reference1InDocumentHeader
        reference_1_in_document_he TYPE c LENGTH 20,
        "! Reference2InDocumentHeader
        reference_2_in_document_he TYPE c LENGTH 20,
        "! InvoiceReceiptDate
        invoice_receipt_date       TYPE datn,
        "! Ledger
        ledger                     TYPE c LENGTH 2,
        "! LedgerGroup
        ledger_group               TYPE c LENGTH 4,
        "! AlternativeReferenceDocument
        alternative_reference_docu TYPE c LENGTH 26,
        "! TaxReportingDate
        tax_reporting_date         TYPE datn,
        "! AccountingDocumentClass
        accounting_document_class  TYPE c LENGTH 6,
        "! ExchangeRateType
        exchange_rate_type         TYPE c LENGTH 4,
        "! LatePaymentReason
        late_payment_reason        TYPE c LENGTH 2,
        "! SalesDocumentCondition
        sales_document_condition   TYPE c LENGTH 10,
        "! IsReversal
        is_reversal                TYPE abap_bool,
        "! IsReversed
        is_reversed                TYPE abap_bool,
      END OF tys_a_operational_acctg_doc__2,
      "! <p class="shorttext synchronized">List of A_OperationalAcctgDocItemCubeType</p>
      tyt_a_operational_acctg_doc__2 TYPE STANDARD TABLE OF tys_a_operational_acctg_doc__2 WITH DEFAULT KEY.


    CONSTANTS:
      "! <p class="shorttext synchronized">Internal Names of the entity sets</p>
      BEGIN OF gcs_entity_set,
        "! A_OperationalAcctgDocItemCube
        "! <br/> Collection of type 'A_OperationalAcctgDocItemCubeType'
        a_operational_acctg_doc_it TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'A_OPERATIONAL_ACCTG_DOC_IT',
      END OF gcs_entity_set .

    CONSTANTS:
      "! <p class="shorttext synchronized">Internal names for entity types</p>
      BEGIN OF gcs_entity_type,
        "! <p class="shorttext synchronized">Internal names for A_OperationalAcctgDocItemCubeType</p>
        "! See also structure type {@link ..tys_a_operational_acctg_doc__2}
        BEGIN OF a_operational_acctg_doc__2,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! Dummy field - Structure must not be empty
            dummy TYPE int1 VALUE 0,
          END OF navigation,
        END OF a_operational_acctg_doc__2,
      END OF gcs_entity_type.


    METHODS /iwbep/if_v4_mp_basic_pm~define REDEFINITION.


  PRIVATE SECTION.

    "! <p class="shorttext synchronized">Model</p>
    DATA mo_model TYPE REF TO /iwbep/if_v4_pm_model.


    "! <p class="shorttext synchronized">Define A_OperationalAcctgDocItemCubeType</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_a_operational_acctg_doc__2 RAISING /iwbep/cx_gateway.

ENDCLASS.



CLASS ZARETE_DBS_SC_DOC_READ_API IMPLEMENTATION.


  METHOD /iwbep/if_v4_mp_basic_pm~define.

    mo_model = io_model.
    mo_model->set_schema_namespace( 'API_OPLACCTGDOCITEMCUBE_SRV' ) ##NO_TEXT.

    def_a_operational_acctg_doc__2( ).

  ENDMETHOD.


  METHOD def_a_operational_acctg_doc__2.

    DATA:
      lo_complex_property    TYPE REF TO /iwbep/if_v4_pm_cplx_prop,
      lo_entity_type         TYPE REF TO /iwbep/if_v4_pm_entity_type,
      lo_entity_set          TYPE REF TO /iwbep/if_v4_pm_entity_set,
      lo_navigation_property TYPE REF TO /iwbep/if_v4_pm_nav_prop,
      lo_primitive_property  TYPE REF TO /iwbep/if_v4_pm_prim_prop.


    lo_entity_type = mo_model->create_entity_type_by_struct(
                                    iv_entity_type_name       = 'A_OPERATIONAL_ACCTG_DOC__2'
                                    is_structure              = VALUE tys_a_operational_acctg_doc__2( )
                                    iv_do_gen_prim_props         = abap_true
                                    iv_do_gen_prim_prop_colls    = abap_true
                                    iv_do_add_conv_to_prim_props = abap_true ).

    lo_entity_type->set_edm_name( 'A_OperationalAcctgDocItemCubeType' ) ##NO_TEXT.


    lo_entity_set = lo_entity_type->create_entity_set( 'A_OPERATIONAL_ACCTG_DOC_IT' ).
    lo_entity_set->set_edm_name( 'A_OperationalAcctgDocItemCube' ) ##NO_TEXT.


    lo_primitive_property = lo_entity_type->get_primitive_property( 'COMPANY_CODE' ).
    lo_primitive_property->set_edm_name( 'CompanyCode' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'FISCAL_YEAR' ).
    lo_primitive_property->set_edm_name( 'FiscalYear' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ACCOUNTING_DOCUMENT' ).
    lo_primitive_property->set_edm_name( 'AccountingDocument' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ACCOUNTING_DOCUMENT_ITEM' ).
    lo_primitive_property->set_edm_name( 'AccountingDocumentItem' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'COMPANY_CODE_NAME' ).
    lo_primitive_property->set_edm_name( 'CompanyCodeName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 25 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CHART_OF_ACCOUNTS' ).
    lo_primitive_property->set_edm_name( 'ChartOfAccounts' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ACCOUNTING_DOCUMENT_ITEM_T' ).
    lo_primitive_property->set_edm_name( 'AccountingDocumentItemType' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CLEARING_DATE' ).
    lo_primitive_property->set_edm_name( 'ClearingDate' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Date' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CLEARING_CREATION_DATE' ).
    lo_primitive_property->set_edm_name( 'ClearingCreationDate' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Date' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CLEARING_ACCOUNTING_DOCUME' ).
    lo_primitive_property->set_edm_name( 'ClearingAccountingDocument' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'IS_CLEARED' ).
    lo_primitive_property->set_edm_name( 'IsCleared' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'POSTING_KEY' ).
    lo_primitive_property->set_edm_name( 'PostingKey' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'FINANCIAL_ACCOUNT_TYPE' ).
    lo_primitive_property->set_edm_name( 'FinancialAccountType' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'SPECIAL_GLCODE' ).
    lo_primitive_property->set_edm_name( 'SpecialGLCode' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'SPECIAL_GLTRANSACTION_TYPE' ).
    lo_primitive_property->set_edm_name( 'SpecialGLTransactionType' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'DEBIT_CREDIT_CODE' ).
    lo_primitive_property->set_edm_name( 'DebitCreditCode' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'BUSINESS_AREA' ).
    lo_primitive_property->set_edm_name( 'BusinessArea' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'BUSINESS_AREA_NAME' ).
    lo_primitive_property->set_edm_name( 'BusinessAreaName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 30 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PARTNER_BUSINESS_AREA' ).
    lo_primitive_property->set_edm_name( 'PartnerBusinessArea' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'TAX_CODE' ).
    lo_primitive_property->set_edm_name( 'TaxCode' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'WITHHOLDING_TAX_CODE' ).
    lo_primitive_property->set_edm_name( 'WithholdingTaxCode' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'TAX_TYPE' ).
    lo_primitive_property->set_edm_name( 'TaxType' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'TRANSACTION_TYPE_DETERMINA' ).
    lo_primitive_property->set_edm_name( 'TransactionTypeDetermination' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'VALUE_DATE' ).
    lo_primitive_property->set_edm_name( 'ValueDate' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Date' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ASSIGNMENT_REFERENCE' ).
    lo_primitive_property->set_edm_name( 'AssignmentReference' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 18 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'DOCUMENT_ITEM_TEXT' ).
    lo_primitive_property->set_edm_name( 'DocumentItemText' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 50 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PARTNER_COMPANY' ).
    lo_primitive_property->set_edm_name( 'PartnerCompany' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 6 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'FINANCIAL_TRANSACTION_TYPE' ).
    lo_primitive_property->set_edm_name( 'FinancialTransactionType' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CORPORATE_GROUP_ACCOUNT' ).
    lo_primitive_property->set_edm_name( 'CorporateGroupAccount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PLANNING_LEVEL' ).
    lo_primitive_property->set_edm_name( 'PlanningLevel' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CONTROLLING_AREA' ).
    lo_primitive_property->set_edm_name( 'ControllingArea' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CONTROLLING_AREA_NAME' ).
    lo_primitive_property->set_edm_name( 'ControllingAreaName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 25 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'COST_CENTER' ).
    lo_primitive_property->set_edm_name( 'CostCenter' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'COST_CENTER_NAME' ).
    lo_primitive_property->set_edm_name( 'CostCenterName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 20 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PROJECT' ).
    lo_primitive_property->set_edm_name( 'Project' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 24 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ORDER_ID' ).
    lo_primitive_property->set_edm_name( 'OrderID' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 12 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'BILLING_DOCUMENT' ).
    lo_primitive_property->set_edm_name( 'BillingDocument' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'SALES_DOCUMENT' ).
    lo_primitive_property->set_edm_name( 'SalesDocument' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'SALES_DOCUMENT_ITEM' ).
    lo_primitive_property->set_edm_name( 'SalesDocumentItem' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 6 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'SCHEDULE_LINE' ).
    lo_primitive_property->set_edm_name( 'ScheduleLine' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MASTER_FIXED_ASSET' ).
    lo_primitive_property->set_edm_name( 'MasterFixedAsset' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 12 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'FIXED_ASSET' ).
    lo_primitive_property->set_edm_name( 'FixedAsset' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ASSET_TRANSACTION_TYPE' ).
    lo_primitive_property->set_edm_name( 'AssetTransactionType' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ASSET_VALUE_DATE' ).
    lo_primitive_property->set_edm_name( 'AssetValueDate' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Date' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PERSONNEL_NUMBER' ).
    lo_primitive_property->set_edm_name( 'PersonnelNumber' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 8 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'IS_SALES_RELATED' ).
    lo_primitive_property->set_edm_name( 'IsSalesRelated' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'LINE_ITEM_DISPLAY_IS_ENABL' ).
    lo_primitive_property->set_edm_name( 'LineItemDisplayIsEnabled' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'IS_OPEN_ITEM_MANAGED' ).
    lo_primitive_property->set_edm_name( 'IsOpenItemManaged' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'IS_NOT_CASH_DISCOUNT_LIABL' ).
    lo_primitive_property->set_edm_name( 'IsNotCashDiscountLiable' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'IS_AUTOMATICALLY_CREATED' ).
    lo_primitive_property->set_edm_name( 'IsAutomaticallyCreated' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'IS_USED_IN_PAYMENT_TRANSAC' ).
    lo_primitive_property->set_edm_name( 'IsUsedInPaymentTransaction' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'OPERATIONAL_GLACCOUNT' ).
    lo_primitive_property->set_edm_name( 'OperationalGLAccount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'GLACCOUNT' ).
    lo_primitive_property->set_edm_name( 'GLAccount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'GLACCOUNT_NAME' ).
    lo_primitive_property->set_edm_name( 'GLAccountName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 30 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'GLACCOUNT_LONG_NAME' ).
    lo_primitive_property->set_edm_name( 'GLAccountLongName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 50 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CUSTOMER' ).
    lo_primitive_property->set_edm_name( 'Customer' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CUSTOMER_NAME' ).
    lo_primitive_property->set_edm_name( 'CustomerName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 80 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'SUPPLIER' ).
    lo_primitive_property->set_edm_name( 'Supplier' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'SUPPLIER_NAME' ).
    lo_primitive_property->set_edm_name( 'SupplierName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 80 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'BRANCH_ACCOUNT' ).
    lo_primitive_property->set_edm_name( 'BranchAccount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'IS_BALANCE_SHEET_ACCOUNT' ).
    lo_primitive_property->set_edm_name( 'IsBalanceSheetAccount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PROFIT_LOSS_ACCOUNT_TYPE' ).
    lo_primitive_property->set_edm_name( 'ProfitLossAccountType' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'SPECIAL_GLACCOUNT_ASSIGNME' ).
    lo_primitive_property->set_edm_name( 'SpecialGLAccountAssignment' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 18 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'DUE_CALCULATION_BASE_DATE' ).
    lo_primitive_property->set_edm_name( 'DueCalculationBaseDate' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Date' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PAYMENT_TERMS' ).
    lo_primitive_property->set_edm_name( 'PaymentTerms' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CASH_DISCOUNT_1_DAYS' ).
    lo_primitive_property->set_edm_name( 'CashDiscount1Days' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CASH_DISCOUNT_2_DAYS' ).
    lo_primitive_property->set_edm_name( 'CashDiscount2Days' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'NET_PAYMENT_DAYS' ).
    lo_primitive_property->set_edm_name( 'NetPaymentDays' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CASH_DISCOUNT_1_PERCENT' ).
    lo_primitive_property->set_edm_name( 'CashDiscount1Percent' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 5 ) ##NUMBER_OK.
    lo_primitive_property->set_scale( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CASH_DISCOUNT_2_PERCENT' ).
    lo_primitive_property->set_edm_name( 'CashDiscount2Percent' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 5 ) ##NUMBER_OK.
    lo_primitive_property->set_scale( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PAYMENT_REASON' ).
    lo_primitive_property->set_edm_name( 'PaymentReason' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PAYMENT_METHOD' ).
    lo_primitive_property->set_edm_name( 'PaymentMethod' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PAYMENT_BLOCKING_REASON' ).
    lo_primitive_property->set_edm_name( 'PaymentBlockingReason' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'FIXED_CASH_DISCOUNT' ).
    lo_primitive_property->set_edm_name( 'FixedCashDiscount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'HOUSE_BANK' ).
    lo_primitive_property->set_edm_name( 'HouseBank' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 5 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'BPBANK_ACCOUNT_INTERNAL_ID' ).
    lo_primitive_property->set_edm_name( 'BPBankAccountInternalID' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'TAX_DISTRIBUTION_CODE_1' ).
    lo_primitive_property->set_edm_name( 'TaxDistributionCode1' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'TAX_DISTRIBUTION_CODE_2' ).
    lo_primitive_property->set_edm_name( 'TaxDistributionCode2' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'TAX_DISTRIBUTION_CODE_3' ).
    lo_primitive_property->set_edm_name( 'TaxDistributionCode3' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'INVOICE_REFERENCE' ).
    lo_primitive_property->set_edm_name( 'InvoiceReference' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'INVOICE_REFERENCE_FISCAL_Y' ).
    lo_primitive_property->set_edm_name( 'InvoiceReferenceFiscalYear' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'INVOICE_ITEM_REFERENCE' ).
    lo_primitive_property->set_edm_name( 'InvoiceItemReference' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'FOLLOW_ON_DOCUMENT_TYPE' ).
    lo_primitive_property->set_edm_name( 'FollowOnDocumentType' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'STATE_CENTRAL_BANK_PAYMENT' ).
    lo_primitive_property->set_edm_name( 'StateCentralBankPaymentReason' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'SUPPLYING_COUNTRY' ).
    lo_primitive_property->set_edm_name( 'SupplyingCountry' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'INVOICE_LIST' ).
    lo_primitive_property->set_edm_name( 'InvoiceList' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 8 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'BILL_OF_EXCHANGE_USAGE' ).
    lo_primitive_property->set_edm_name( 'BillOfExchangeUsage' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'DUNNING_KEY' ).
    lo_primitive_property->set_edm_name( 'DunningKey' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'DUNNING_BLOCKING_REASON' ).
    lo_primitive_property->set_edm_name( 'DunningBlockingReason' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'LAST_DUNNING_DATE' ).
    lo_primitive_property->set_edm_name( 'LastDunningDate' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Date' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'DUNNING_LEVEL' ).
    lo_primitive_property->set_edm_name( 'DunningLevel' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'DUNNING_AREA' ).
    lo_primitive_property->set_edm_name( 'DunningArea' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'WITHHOLDING_TAX_CERTIFICAT' ).
    lo_primitive_property->set_edm_name( 'WithholdingTaxCertificate' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MATERIAL' ).
    lo_primitive_property->set_edm_name( 'Material' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 40 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PRODUCT' ).
    lo_primitive_property->set_edm_name( 'Product' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 40 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PLANT' ).
    lo_primitive_property->set_edm_name( 'Plant' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PURCHASING_DOCUMENT' ).
    lo_primitive_property->set_edm_name( 'PurchasingDocument' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PURCHASING_DOCUMENT_ITEM' ).
    lo_primitive_property->set_edm_name( 'PurchasingDocumentItem' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 5 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ACCOUNT_ASSIGNMENT_NUMBER' ).
    lo_primitive_property->set_edm_name( 'AccountAssignmentNumber' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'IS_COMPLETELY_DELIVERED' ).
    lo_primitive_property->set_edm_name( 'IsCompletelyDelivered' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MATERIAL_PRICE_CONTROL' ).
    lo_primitive_property->set_edm_name( 'MaterialPriceControl' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'VALUATION_AREA' ).
    lo_primitive_property->set_edm_name( 'ValuationArea' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'INVENTORY_VALUATION_TYPE' ).
    lo_primitive_property->set_edm_name( 'InventoryValuationType' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'VATREGISTRATION' ).
    lo_primitive_property->set_edm_name( 'VATRegistration' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 20 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'DELIV_OF_GOODS_DEST_COUNTR' ).
    lo_primitive_property->set_edm_name( 'DelivOfGoodsDestCountry' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PAYMENT_DIFFERENCE_REASON' ).
    lo_primitive_property->set_edm_name( 'PaymentDifferenceReason' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PROFIT_CENTER' ).
    lo_primitive_property->set_edm_name( 'ProfitCenter' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PROFIT_CENTER_NAME' ).
    lo_primitive_property->set_edm_name( 'ProfitCenterName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 20 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOINT_VENTURE' ).
    lo_primitive_property->set_edm_name( 'JointVenture' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 6 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOINT_VENTURE_COST_RECOVER' ).
    lo_primitive_property->set_edm_name( 'JointVentureCostRecoveryCode' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOINT_VENTURE_EQUITY_GROUP' ).
    lo_primitive_property->set_edm_name( 'JointVentureEquityGroup' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOINT_VENTURE_PARTNER' ).
    lo_primitive_property->set_edm_name( 'JointVenturePartner' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'TREASURY_CONTRACT_TYPE' ).
    lo_primitive_property->set_edm_name( 'TreasuryContractType' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ASSET_CONTRACT' ).
    lo_primitive_property->set_edm_name( 'AssetContract' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 13 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CASH_FLOW_TYPE' ).
    lo_primitive_property->set_edm_name( 'CashFlowType' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'TAX_JURISDICTION' ).
    lo_primitive_property->set_edm_name( 'TaxJurisdiction' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 15 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'REAL_ESTATE_OBJECT' ).
    lo_primitive_property->set_edm_name( 'RealEstateObject' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 40 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'SETTLEMENT_REFERENCE_DATE' ).
    lo_primitive_property->set_edm_name( 'SettlementReferenceDate' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Date' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'COMMITMENT_ITEM' ).
    lo_primitive_property->set_edm_name( 'CommitmentItem' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 24 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'COST_OBJECT' ).
    lo_primitive_property->set_edm_name( 'CostObject' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 12 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PROJECT_NETWORK' ).
    lo_primitive_property->set_edm_name( 'ProjectNetwork' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 12 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ORDER_INTERNAL_BILL_OF_OPE' ).
    lo_primitive_property->set_edm_name( 'OrderInternalBillOfOperations' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ORDER_INT_BILL_OF_OPERATIO' ).
    lo_primitive_property->set_edm_name( 'OrderIntBillOfOperationsItem' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 8 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'WBSELEMENT_INTERNAL_ID' ).
    lo_primitive_property->set_edm_name( 'WBSElementInternalID' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 8 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PROFITABILITY_SEGMENT' ).
    lo_primitive_property->set_edm_name( 'ProfitabilitySegment' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOINT_VENTURE_BILLING_TYPE' ).
    lo_primitive_property->set_edm_name( 'JointVentureBillingType' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOINT_VENTURE_EQUITY_TYPE' ).
    lo_primitive_property->set_edm_name( 'JointVentureEquityType' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'IS_EUTRIANGULAR_DEAL' ).
    lo_primitive_property->set_edm_name( 'IsEUTriangularDeal' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'COST_ORIGIN_GROUP' ).
    lo_primitive_property->set_edm_name( 'CostOriginGroup' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'COMPANY_CODE_CURRENCY_DETN' ).
    lo_primitive_property->set_edm_name( 'CompanyCodeCurrencyDetnMethod' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CLEARING_IS_REVERSED' ).
    lo_primitive_property->set_edm_name( 'ClearingIsReversed' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PAYMENT_METHOD_SUPPLEMENT' ).
    lo_primitive_property->set_edm_name( 'PaymentMethodSupplement' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ALTERNATIVE_GLACCOUNT' ).
    lo_primitive_property->set_edm_name( 'AlternativeGLAccount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'FUNDS_CENTER' ).
    lo_primitive_property->set_edm_name( 'FundsCenter' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 16 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'FUND' ).
    lo_primitive_property->set_edm_name( 'Fund' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PARTNER_PROFIT_CENTER' ).
    lo_primitive_property->set_edm_name( 'PartnerProfitCenter' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'REFERENCE_1_IDBY_BUSINESS' ).
    lo_primitive_property->set_edm_name( 'Reference1IDByBusinessPartner' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 12 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'REFERENCE_2_IDBY_BUSINESS' ).
    lo_primitive_property->set_edm_name( 'Reference2IDByBusinessPartner' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 12 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'IS_NEGATIVE_POSTING' ).
    lo_primitive_property->set_edm_name( 'IsNegativePosting' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PAYMENT_CARD_ITEM' ).
    lo_primitive_property->set_edm_name( 'PaymentCardItem' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PAYMENT_CARD_PAYMENT_SETTL' ).
    lo_primitive_property->set_edm_name( 'PaymentCardPaymentSettlement' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CREDIT_CONTROL_AREA' ).
    lo_primitive_property->set_edm_name( 'CreditControlArea' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'REFERENCE_3_IDBY_BUSINESS' ).
    lo_primitive_property->set_edm_name( 'Reference3IDByBusinessPartner' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 20 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'DATA_EXCHANGE_INSTRUCTION' ).
    lo_primitive_property->set_edm_name( 'DataExchangeInstruction1' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'DATA_EXCHANGE_INSTRUCTIO_2' ).
    lo_primitive_property->set_edm_name( 'DataExchangeInstruction2' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'DATA_EXCHANGE_INSTRUCTIO_3' ).
    lo_primitive_property->set_edm_name( 'DataExchangeInstruction3' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'DATA_EXCHANGE_INSTRUCTIO_4' ).
    lo_primitive_property->set_edm_name( 'DataExchangeInstruction4' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'REGION' ).
    lo_primitive_property->set_edm_name( 'Region' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'HAS_PAYMENT_ORDER' ).
    lo_primitive_property->set_edm_name( 'HasPaymentOrder' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PAYMENT_REFERENCE' ).
    lo_primitive_property->set_edm_name( 'PaymentReference' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 30 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'TAX_DETERMINATION_DATE' ).
    lo_primitive_property->set_edm_name( 'TaxDeterminationDate' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Date' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CLEARING_ITEM' ).
    lo_primitive_property->set_edm_name( 'ClearingItem' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 5 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'BUSINESS_PLACE' ).
    lo_primitive_property->set_edm_name( 'BusinessPlace' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'TAX_SECTION' ).
    lo_primitive_property->set_edm_name( 'TaxSection' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'COST_CTR_ACTIVITY_TYPE' ).
    lo_primitive_property->set_edm_name( 'CostCtrActivityType' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 6 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ACCOUNTS_RECEIVABLE_IS_PLE' ).
    lo_primitive_property->set_edm_name( 'AccountsReceivableIsPledged' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'BUSINESS_PROCESS' ).
    lo_primitive_property->set_edm_name( 'BusinessProcess' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 12 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'GRANT_ID' ).
    lo_primitive_property->set_edm_name( 'GrantID' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 20 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'FUNCTIONAL_AREA' ).
    lo_primitive_property->set_edm_name( 'FunctionalArea' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 16 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'FUNCTIONAL_AREA_NAME' ).
    lo_primitive_property->set_edm_name( 'FunctionalAreaName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 30 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CUSTOMER_IS_IN_EXECUTION' ).
    lo_primitive_property->set_edm_name( 'CustomerIsInExecution' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'FUNDED_PROGRAM' ).
    lo_primitive_property->set_edm_name( 'FundedProgram' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 24 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CLEARING_DOC_FISCAL_YEAR' ).
    lo_primitive_property->set_edm_name( 'ClearingDocFiscalYear' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'LEDGER_GLLINE_ITEM' ).
    lo_primitive_property->set_edm_name( 'LedgerGLLineItem' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 6 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'SEGMENT' ).
    lo_primitive_property->set_edm_name( 'Segment' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'SEGMENT_NAME' ).
    lo_primitive_property->set_edm_name( 'SegmentName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 50 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PARTNER_SEGMENT' ).
    lo_primitive_property->set_edm_name( 'PartnerSegment' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PARTNER_FUNCTIONAL_AREA' ).
    lo_primitive_property->set_edm_name( 'PartnerFunctionalArea' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 16 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'HOUSE_BANK_ACCOUNT' ).
    lo_primitive_property->set_edm_name( 'HouseBankAccount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 5 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'COST_ELEMENT' ).
    lo_primitive_property->set_edm_name( 'CostElement' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'SEPAMANDATE' ).
    lo_primitive_property->set_edm_name( 'SEPAMandate' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 35 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'REFERENCE_DOCUMENT_TYPE' ).
    lo_primitive_property->set_edm_name( 'ReferenceDocumentType' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 5 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ORIGINAL_REFERENCE_DOCUMEN' ).
    lo_primitive_property->set_edm_name( 'OriginalReferenceDocument' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 20 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'REFERENCE_DOCUMENT_LOGICAL' ).
    lo_primitive_property->set_edm_name( 'ReferenceDocumentLogicalSystem' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ACCOUNTING_DOCUMENT_ITEM_R' ).
    lo_primitive_property->set_edm_name( 'AccountingDocumentItemRef' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'FISCAL_PERIOD' ).
    lo_primitive_property->set_edm_name( 'FiscalPeriod' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ACCOUNTING_DOCUMENT_CATEGO' ).
    lo_primitive_property->set_edm_name( 'AccountingDocumentCategory' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ACCOUNTING_DOCUMENT_CATE_2' ).
    lo_primitive_property->set_edm_name( 'AccountingDocumentCategoryName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 60 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'POSTING_DATE' ).
    lo_primitive_property->set_edm_name( 'PostingDate' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Date' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'DOCUMENT_DATE' ).
    lo_primitive_property->set_edm_name( 'DocumentDate' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Date' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ACCOUNTING_DOCUMENT_TYPE' ).
    lo_primitive_property->set_edm_name( 'AccountingDocumentType' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ACCOUNTING_DOCUMENT_TYPE_N' ).
    lo_primitive_property->set_edm_name( 'AccountingDocumentTypeName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 20 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'NET_DUE_DATE' ).
    lo_primitive_property->set_edm_name( 'NetDueDate' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Date' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CASH_DISCOUNT_1_DUE_DATE' ).
    lo_primitive_property->set_edm_name( 'CashDiscount1DueDate' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Date' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CASH_DISCOUNT_2_DUE_DATE' ).
    lo_primitive_property->set_edm_name( 'CashDiscount2DueDate' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Date' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'OFFSETTING_ACCOUNT' ).
    lo_primitive_property->set_edm_name( 'OffsettingAccount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'OFFSETTING_ACCOUNT_TYPE' ).
    lo_primitive_property->set_edm_name( 'OffsettingAccountType' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PARTNER_FUND' ).
    lo_primitive_property->set_edm_name( 'PartnerFund' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PARTNER_GRANT' ).
    lo_primitive_property->set_edm_name( 'PartnerGrant' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 20 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'BUDGET_PERIOD' ).
    lo_primitive_property->set_edm_name( 'BudgetPeriod' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PARTNER_BUDGET_PERIOD' ).
    lo_primitive_property->set_edm_name( 'PartnerBudgetPeriod' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'BRANCH_CODE' ).
    lo_primitive_property->set_edm_name( 'BranchCode' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 5 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOINT_VENTURE_PRODUCTION_D' ).
    lo_primitive_property->set_edm_name( 'JointVentureProductionDate' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Date' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'COMPANY_CODE_CURRENCY' ).
    lo_primitive_property->set_edm_name( 'CompanyCodeCurrency' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 5 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'AMOUNT_IN_COMPANY_CODE_CUR' ).
    lo_primitive_property->set_edm_name( 'AmountInCompanyCodeCurrency' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 24 ) ##NUMBER_OK.
    lo_primitive_property->set_scale( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'TAX_AMOUNT_IN_CO_CODE_CRCY' ).
    lo_primitive_property->set_edm_name( 'TaxAmountInCoCodeCrcy' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 24 ) ##NUMBER_OK.
    lo_primitive_property->set_scale( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'TAX_BASE_AMOUNT_IN_CO_CODE' ).
    lo_primitive_property->set_edm_name( 'TaxBaseAmountInCoCodeCrcy' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 24 ) ##NUMBER_OK.
    lo_primitive_property->set_scale( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'VALUATION_DIFF_AMT_IN_CO_C' ).
    lo_primitive_property->set_edm_name( 'ValuationDiffAmtInCoCodeCrcy' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 24 ) ##NUMBER_OK.
    lo_primitive_property->set_scale( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CASH_DISCOUNT_AMT_IN_CO_CO' ).
    lo_primitive_property->set_edm_name( 'CashDiscountAmtInCoCodeCrcy' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 24 ) ##NUMBER_OK.
    lo_primitive_property->set_scale( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'INVOICE_AMT_IN_CO_CODE_CRC' ).
    lo_primitive_property->set_edm_name( 'InvoiceAmtInCoCodeCrcy' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 24 ) ##NUMBER_OK.
    lo_primitive_property->set_scale( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'TRANSACTION_CURRENCY' ).
    lo_primitive_property->set_edm_name( 'TransactionCurrency' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 5 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'AMOUNT_IN_TRANSACTION_CURR' ).
    lo_primitive_property->set_edm_name( 'AmountInTransactionCurrency' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 24 ) ##NUMBER_OK.
    lo_primitive_property->set_scale( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ORIGINAL_TAX_BASE_AMOUNT' ).
    lo_primitive_property->set_edm_name( 'OriginalTaxBaseAmount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 24 ) ##NUMBER_OK.
    lo_primitive_property->set_scale( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'TAX_AMOUNT' ).
    lo_primitive_property->set_edm_name( 'TaxAmount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 24 ) ##NUMBER_OK.
    lo_primitive_property->set_scale( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'TAX_BASE_AMOUNT_IN_TRANS_C' ).
    lo_primitive_property->set_edm_name( 'TaxBaseAmountInTransCrcy' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 24 ) ##NUMBER_OK.
    lo_primitive_property->set_scale( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'WITHHOLDING_TAX_BASE_AMOUN' ).
    lo_primitive_property->set_edm_name( 'WithholdingTaxBaseAmount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 24 ) ##NUMBER_OK.
    lo_primitive_property->set_scale( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PLANNED_AMT_IN_TRANSACTION' ).
    lo_primitive_property->set_edm_name( 'PlannedAmtInTransactionCrcy' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 24 ) ##NUMBER_OK.
    lo_primitive_property->set_scale( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CASH_DISCOUNT_BASE_AMOUNT' ).
    lo_primitive_property->set_edm_name( 'CashDiscountBaseAmount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 24 ) ##NUMBER_OK.
    lo_primitive_property->set_scale( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CASH_DISCOUNT_AMOUNT' ).
    lo_primitive_property->set_edm_name( 'CashDiscountAmount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 24 ) ##NUMBER_OK.
    lo_primitive_property->set_scale( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'NET_PAYMENT_AMOUNT' ).
    lo_primitive_property->set_edm_name( 'NetPaymentAmount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 24 ) ##NUMBER_OK.
    lo_primitive_property->set_scale( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'WITHHOLDING_TAX_AMOUNT' ).
    lo_primitive_property->set_edm_name( 'WithholdingTaxAmount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 24 ) ##NUMBER_OK.
    lo_primitive_property->set_scale( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'WITHHOLDING_TAX_EXEMPTION' ).
    lo_primitive_property->set_edm_name( 'WithholdingTaxExemptionAmt' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 24 ) ##NUMBER_OK.
    lo_primitive_property->set_scale( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'INVOICE_AMOUNT_IN_FRGN_CUR' ).
    lo_primitive_property->set_edm_name( 'InvoiceAmountInFrgnCurrency' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 24 ) ##NUMBER_OK.
    lo_primitive_property->set_scale( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'BALANCE_TRANSACTION_CURREN' ).
    lo_primitive_property->set_edm_name( 'BalanceTransactionCurrency' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 5 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'AMOUNT_IN_BALANCE_TRANSAC' ).
    lo_primitive_property->set_edm_name( 'AmountInBalanceTransacCrcy' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 24 ) ##NUMBER_OK.
    lo_primitive_property->set_scale( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ADDITIONAL_CURRENCY_1' ).
    lo_primitive_property->set_edm_name( 'AdditionalCurrency1' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 5 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'VALUATION_DIFF_AMT_IN_ADDL' ).
    lo_primitive_property->set_edm_name( 'ValuationDiffAmtInAddlCrcy1' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 24 ) ##NUMBER_OK.
    lo_primitive_property->set_scale( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'AMOUNT_IN_ADDITIONAL_CURRE' ).
    lo_primitive_property->set_edm_name( 'AmountInAdditionalCurrency1' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 24 ) ##NUMBER_OK.
    lo_primitive_property->set_scale( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ADDITIONAL_CURRENCY_2' ).
    lo_primitive_property->set_edm_name( 'AdditionalCurrency2' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 5 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'AMOUNT_IN_ADDITIONAL_CUR_2' ).
    lo_primitive_property->set_edm_name( 'AmountInAdditionalCurrency2' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 24 ) ##NUMBER_OK.
    lo_primitive_property->set_scale( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'VALUATION_DIFF_AMT_IN_AD_2' ).
    lo_primitive_property->set_edm_name( 'ValuationDiffAmtInAddlCrcy2' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 24 ) ##NUMBER_OK.
    lo_primitive_property->set_scale( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PAYMENT_CURRENCY' ).
    lo_primitive_property->set_edm_name( 'PaymentCurrency' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 5 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'AMOUNT_IN_PAYMENT_CURRENCY' ).
    lo_primitive_property->set_edm_name( 'AmountInPaymentCurrency' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 24 ) ##NUMBER_OK.
    lo_primitive_property->set_scale( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CREDIT_CONTROL_AREA_CURREN' ).
    lo_primitive_property->set_edm_name( 'CreditControlAreaCurrency' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 5 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'HEDGED_AMOUNT' ).
    lo_primitive_property->set_edm_name( 'HedgedAmount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 24 ) ##NUMBER_OK.
    lo_primitive_property->set_scale( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'BASE_UNIT' ).
    lo_primitive_property->set_edm_name( 'BaseUnit' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'QUANTITY' ).
    lo_primitive_property->set_edm_name( 'Quantity' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 23 ) ##NUMBER_OK.
    lo_primitive_property->set_scale( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'GOODS_MOVEMENT_ENTRY_UNIT' ).
    lo_primitive_property->set_edm_name( 'GoodsMovementEntryUnit' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'QUANTITY_IN_ENTRY_UNIT' ).
    lo_primitive_property->set_edm_name( 'QuantityInEntryUnit' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 13 ) ##NUMBER_OK.
    lo_primitive_property->set_scale( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PURCHASING_DOCUMENT_PRICE' ).
    lo_primitive_property->set_edm_name( 'PurchasingDocumentPriceUnit' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PURCHASE_ORDER_QTY' ).
    lo_primitive_property->set_edm_name( 'PurchaseOrderQty' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 13 ) ##NUMBER_OK.
    lo_primitive_property->set_scale( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MATERIAL_PRICE_UNIT_QTY' ).
    lo_primitive_property->set_edm_name( 'MaterialPriceUnitQty' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 5 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'NUMBER_OF_ITEMS' ).
    lo_primitive_property->set_edm_name( 'NumberOfItems' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 12 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ACCOUNTING_DOCUMENT_CREATI' ).
    lo_primitive_property->set_edm_name( 'AccountingDocumentCreationDate' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Date' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CREATION_TIME' ).
    lo_primitive_property->set_edm_name( 'CreationTime' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'TimeOfDay' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->set_edm_type_v2( 'Time' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'LAST_CHANGE_DATE' ).
    lo_primitive_property->set_edm_name( 'LastChangeDate' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Date' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'EXCHANGE_RATE_DATE' ).
    lo_primitive_property->set_edm_name( 'ExchangeRateDate' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Date' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ACCOUNTING_DOC_CREATED_BY' ).
    lo_primitive_property->set_edm_name( 'AccountingDocCreatedByUser' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 12 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'TRANSACTION_CODE' ).
    lo_primitive_property->set_edm_name( 'TransactionCode' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 20 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'INTERCOMPANY_TRANSACTION' ).
    lo_primitive_property->set_edm_name( 'IntercompanyTransaction' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 16 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'DOCUMENT_REFERENCE_ID' ).
    lo_primitive_property->set_edm_name( 'DocumentReferenceID' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 16 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'RECURRING_ACCOUNTING_DOCUM' ).
    lo_primitive_property->set_edm_name( 'RecurringAccountingDocument' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'REVERSE_DOCUMENT' ).
    lo_primitive_property->set_edm_name( 'ReverseDocument' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'REVERSE_DOCUMENT_FISCAL_YE' ).
    lo_primitive_property->set_edm_name( 'ReverseDocumentFiscalYear' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ACCOUNTING_DOCUMENT_HEADER' ).
    lo_primitive_property->set_edm_name( 'AccountingDocumentHeaderText' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 25 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'EXCHANGE_RATE' ).
    lo_primitive_property->set_edm_name( 'ExchangeRate' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 9 ) ##NUMBER_OK.
    lo_primitive_property->set_scale( 5 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'BUSINESS_TRANSACTION_TYPE' ).
    lo_primitive_property->set_edm_name( 'BusinessTransactionType' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'BATCH_INPUT_SESSION' ).
    lo_primitive_property->set_edm_name( 'BatchInputSession' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 12 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'FINANCIAL_MANAGEMENT_AREA' ).
    lo_primitive_property->set_edm_name( 'FinancialManagementArea' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'REVERSAL_IS_PLANNED' ).
    lo_primitive_property->set_edm_name( 'ReversalIsPlanned' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PLANNED_REVERSAL_DATE' ).
    lo_primitive_property->set_edm_name( 'PlannedReversalDate' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Date' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'TAX_IS_CALCULATED_AUTOMATI' ).
    lo_primitive_property->set_edm_name( 'TaxIsCalculatedAutomatically' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'TAX_BASE_AMOUNT_IS_NET_AMO' ).
    lo_primitive_property->set_edm_name( 'TaxBaseAmountIsNetAmount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'SOURCE_COMPANY_CODE' ).
    lo_primitive_property->set_edm_name( 'SourceCompanyCode' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'LOGICAL_SYSTEM' ).
    lo_primitive_property->set_edm_name( 'LogicalSystem' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'TAX_EXCHANGE_RATE' ).
    lo_primitive_property->set_edm_name( 'TaxExchangeRate' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 9 ) ##NUMBER_OK.
    lo_primitive_property->set_scale( 5 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'REVERSAL_REASON' ).
    lo_primitive_property->set_edm_name( 'ReversalReason' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'BRANCH' ).
    lo_primitive_property->set_edm_name( 'Branch' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'REFERENCE_1_IN_DOCUMENT_HE' ).
    lo_primitive_property->set_edm_name( 'Reference1InDocumentHeader' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 20 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'REFERENCE_2_IN_DOCUMENT_HE' ).
    lo_primitive_property->set_edm_name( 'Reference2InDocumentHeader' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 20 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'INVOICE_RECEIPT_DATE' ).
    lo_primitive_property->set_edm_name( 'InvoiceReceiptDate' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Date' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'LEDGER' ).
    lo_primitive_property->set_edm_name( 'Ledger' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'LEDGER_GROUP' ).
    lo_primitive_property->set_edm_name( 'LedgerGroup' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ALTERNATIVE_REFERENCE_DOCU' ).
    lo_primitive_property->set_edm_name( 'AlternativeReferenceDocument' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 26 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'TAX_REPORTING_DATE' ).
    lo_primitive_property->set_edm_name( 'TaxReportingDate' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Date' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ACCOUNTING_DOCUMENT_CLASS' ).
    lo_primitive_property->set_edm_name( 'AccountingDocumentClass' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 6 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'EXCHANGE_RATE_TYPE' ).
    lo_primitive_property->set_edm_name( 'ExchangeRateType' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'LATE_PAYMENT_REASON' ).
    lo_primitive_property->set_edm_name( 'LatePaymentReason' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'SALES_DOCUMENT_CONDITION' ).
    lo_primitive_property->set_edm_name( 'SalesDocumentCondition' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'IS_REVERSAL' ).
    lo_primitive_property->set_edm_name( 'IsReversal' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'IS_REVERSED' ).
    lo_primitive_property->set_edm_name( 'IsReversed' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

  ENDMETHOD.
ENDCLASS.
