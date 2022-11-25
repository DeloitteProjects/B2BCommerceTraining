/**
 * Created by aketa on 10/27/2021.
 */

public with sharing class CollectionTriggerHandler {
 public void isCollectionUpdatedWithdrawn(List<Collection__c> collections){
     Set<Id> collectionId=new Set<Id>();
     for(Collection__c collection:collections){
         if(collection.Status__c=='Withdrawn'){
         collectionId.add(collection.Id);
         }
     }
     List<Product2> products=[SELECT isActive__c FROM Product2 WHERE Collection__c in:collectionId];
     for(Product2 product: products){
         product.isActive__c=false;
     }
     update products;
     }
    public void deactivatedCollection(List<Collection__c> collectionsNew,List<Collection__c> collectionOld){
        Set<Id> collectionIds=new Set<Id>();
        for(Collection__c collection: collectionsNew){
            if(!collection.isActive__c && collectionOld.get(collectionsNew.indexOf(collection)).isActive__c){
            collectionIds.add(collection.Id);
            }
        }
        List<Product2> products=[SELECT isActive FROM Product2 WHERE Collection__c IN :collectionIds];
        for(Product2 product: products){
            product.IsActive=false;
        }
        update products;
    }

 }