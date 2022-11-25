/**
 * Created by aketa on 10/28/2021.
 */

trigger OpportunityTrigger on Opportunity (before insert) {
OpportunityTriggerHandler opportunityTriggerHandler=new OpportunityTriggerHandler();
    if(Trigger.isBefore && Trigger.isInsert){
        opportunityTriggerHandler.opportunityCreated(Trigger.new);
    }
}