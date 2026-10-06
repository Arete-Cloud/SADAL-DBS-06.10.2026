@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BP-Finteo-Şirket Eşleşmesi'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZARETE_DBS_DD_T012
  as select from    zarete_dbs_t012 as Relation
    inner join      zarete_dbs_t013 as Finteo  on  Finteo.identifier = Relation.company_identifier
                                               and Finteo.limitid    = Relation.limit_id
                                               and Finteo.isactive   = 'X'
    inner join      zarete_dbs_t014 as Company on Company.company_identifier = Relation.company_identifier
    left outer join zarete_dbs_t018 as BP      on BP.business_partner = Relation.bp_no
  association [1..*] to zarete_dbs_t014 as _company on  $projection.CompanyIdentifier = _company.company_identifier
  association [1]    to zarete_dbs_t013 as _finteo  on  $projection.CompanyIdentifier = _finteo.identifier
                                                    and $projection.LimitId           = _finteo.limitid
  association [1]    to zarete_dbs_t018 as _bp      on  $projection.BpNo = _bp.business_partner
{
  key Relation.company_identifier   as CompanyIdentifier,
  key Relation.limit_id             as LimitId,
      Company.company_code          as CompanyCode,
      Relation.company_bank_code    as CompanyBankCode,
      Relation.bp_no                as BpNo,
      Relation.bp_tax_number        as BpTaxNumber,
      Relation.glaccount            as Glaccount,
      Relation.house_bank           as HouseBank,
      Relation.house_bank_account   as HouseBankAccount,
      Relation.bank_priority        as BankPriority,
      Finteo.bankcode               as FinteoBankCode,
      Finteo.identifier             as Identifier,
      Finteo.partycode              as PartyCode,
      Finteo.partytaxnumber         as PartyTaxNumber,
      BP.business_partner_full_name as BpName,

      _company,
      _finteo,
      _bp
}
