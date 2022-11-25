/**
 * Created by aketa on 10/27/2021.
 */

trigger ProductTrigger on Product2 (after update,after insert) {
   /* System.debug('I am here');
    System.enqueueJob(new ProductTriggerHandler(Trigger.new,Trigger.old));*/
   ProductTriggerHandler productTriggerHandler=new ProductTriggerHandler();
   if(Trigger.isAfter && Trigger.IsInsert){
      productTriggerHandler.createNewPriceBookEntry(Trigger.new);
   }
}