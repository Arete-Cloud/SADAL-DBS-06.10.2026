managed implementation in class zbp_arete_dbs_dd_t031 unique;
strict ( 2 );

define behavior for ZARETE_DBS_DD_T031 //alias <alias_name>
persistent table zarete_dbs_t020
lock master
authorization master ( global )
//etag master <field_name>
{
  create;
  update;
  delete;
//  field ( readonly : update ) AccountingDocument, CompanyCode, FiscalYear;

  mapping for zarete_dbs_t020
    {
      AccountingDocument = accounting_document;
      CompanyCode        = company_code;
      FiscalYear         = fiscal_year;
      InvoiceNumber      = invoice_number;
      Id                 = id;
      Customer           = customer;
      CreatedBy          = created_by;
      CreatedAt          = created_at;
      LastChangedAt      = last_changed_at;
      LocalLastChangedBy = local_last_changed_by;
      LocalLastChangedAt = local_last_changed_at;
    }
}