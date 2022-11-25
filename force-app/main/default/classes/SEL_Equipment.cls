/**
 * Created by aketa on 10/23/2022.
 */

global with sharing class SEL_Equipment {

   public static List<String> fieldsToRetrieve = new List<String>{
           'Account__r.Name',
           'CC_Product__r.Name',
           'CC_Product__r.ccrz__SKU__c',
           'Name',
           'PricePerUnit__c',
           'Quantity__c'
   };

   public static List<Equipment__c> getAllEquipments(){
      String query = 'SELECT '+
              String.join(fieldsToRetrieve,',') +
              ' FROM Equipment__c';
      return Database.query(query);
   }

   public static Equipment__c getEquipment(String equipmentId){
      String query = 'SELECT '+
              String.join(fieldsToRetrieve, ',') +
              ' FROM Equipment__c' +
              ' WHERE Id = :equipmentId';
      return Database.query(query);
   }

}