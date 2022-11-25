public with sharing class ExampleController {

    @AuraEnabled
    public static Opportunity getCalculatedOpportunity(Id oppId, Decimal proposedAmount) {
        Opportunity oppRec = new Opportunity(Id = oppId);
        Decimal discountedAmount = proposedAmount - proposedAmount * ExampleService.newInstance().getDiscount(oppId);
        oppRec.Amount = discountedAmount;
        return oppRec;
    }

}