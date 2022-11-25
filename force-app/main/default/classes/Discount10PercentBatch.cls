/**
 * Created by aketa on 10/28/2021.
 */

public with sharing class Discount10PercentBatch implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext param1) {
        System.debug('I am here');
        return Database.getQueryLocator([Select Product2.Price__c,Product2.Target_Warehouse_Quantiy__c,Product2.Available_Warehouse_Quantity__c, UnitPrice from PricebookEntry]);
    }

    public void execute(Database.BatchableContext param1, List<PricebookEntry> pricebookEntries) {
        System.debug('I am here');
     for(PricebookEntry pricebookEntry: pricebookEntries){
         if(pricebookEntry.Product2.Available_Warehouse_Quantity__c> pricebookEntry.Product2.Target_Warehouse_Quantiy__c){
             pricebookEntry.UnitPrice=pricebookEntry.UnitPrice-(0.1)*pricebookEntry.UnitPrice;
         }else{
             pricebookEntry.UnitPrice=pricebookEntry.Product2.Price__c;
         }
        System.debug(pricebookEntry);
     }
        Database.update(pricebookEntries,false);

    }

    public void finish(Database.BatchableContext param1) {
    }


}