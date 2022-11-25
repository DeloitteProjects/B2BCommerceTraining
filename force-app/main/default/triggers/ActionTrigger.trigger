/**
 * Created by aketa on 10/29/2021.
 */

trigger ActionTrigger on Action__c (after update) {
    ActionTriggerHandler actionTriggerHandler=new ActionTriggerHandler();
if(Trigger.isAfter && Trigger.isUpdate){
    actionTriggerHandler.changeEmployeeActions(Trigger.new);
}
}