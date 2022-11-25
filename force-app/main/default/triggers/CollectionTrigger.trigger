/**
 * Created by aketa on 10/27/2021.
 */

trigger CollectionTrigger on Collection__c (after update) {
CollectionTriggerHandler collectionTriggerHandler=new CollectionTriggerHandler();
    if(Trigger.isUpdate){
        collectionTriggerHandler.deactivatedCollection(Trigger.new,Trigger.old);
    }
}