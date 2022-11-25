/**
 * Created by aketa on 10/28/2021.
 */

public with sharing class OpportunityTriggerHandler {
 public void opportunityCreated(List<Opportunity> opportunities){
     Pricebook2 pricebook=[SELECT Id FROM Pricebook2 WHERE IsStandard=TRUE LIMIT 1];
     for(Opportunity opportunity: opportunities){
         pricebook.IsActive=true;
         opportunity.Pricebook2Id=pricebook.Id;
     }
 }
}