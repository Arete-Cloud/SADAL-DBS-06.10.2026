@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BP-Finteo-Şirket Eşleşmesi PV'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZARETE_DBS_PV_T012 provider contract transactional_query as projection on ZARETE_DBS_DD_T012
{
    key CompanyIdentifier,
    key LimitId,
    CompanyCode,
    CompanyBankCode,
    BpNo,
    BpTaxNumber,
    Glaccount,
    HouseBank,
    HouseBankAccount,
    BankPriority,
    FinteoBankCode,
    Identifier,
    PartyCode,
    PartyTaxNumber,
    /* Associations */
    _company,
    _finteo
}
