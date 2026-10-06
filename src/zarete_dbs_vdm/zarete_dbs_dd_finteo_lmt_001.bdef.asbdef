unmanaged implementation in class zbp_arete_dbs_dd_finteo_lmt_00 unique;
strict ( 2 ); //Uncomment this line in order to enable strict mode 2. The strict mode has two variants (strict(1), strict(2)) and is prerequisite to be future proof regarding syntax and to be able to release your BO.

define behavior for ZARETE_DBS_DD_FINTEO_LMT_001 //alias <alias_name>
//late numbering
lock master
authorization master ( global )
//etag master <field_name>
{
  //  create ( authorization : global );
  //  update;
  //  delete;
  action musteri_ekle result [1] $self;
  field ( readonly : update ) partyTaxNumber, bankCode, bankName;
}