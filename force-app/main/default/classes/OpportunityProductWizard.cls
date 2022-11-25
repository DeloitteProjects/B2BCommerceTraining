/**
 * Created by aketa on 10/28/2021.
 */

public with sharing class OpportunityProductWizard {
    @AuraEnabled(Cacheable=true)
    public static List<String> getPicklistTypeValue() {
        List <String> picklistType = new List<String>();
        Schema.DescribeFieldResult fieldResult = Collection__c.Category__c.getDescribe();
        List<PicklistEntry> picklistEntries = fieldResult.getPicklistValues();
        for (PicklistEntry pick : picklistEntries) {
            picklistType.add(pick.getLabel());
        }
        return picklistType;
    }
    @AuraEnabled(Cacheable=true)
    public static List<CollectionDto> getSelectedCollections(String name, List<String> category) {
        System.debug(name + ' ' + category);
        List<Collection__c> collections = new List<Collection__c>();
        if (name == '' && category.isEmpty()) {
            collections = [SELECT name,Status__c,isActive__c,Category__c FROM Collection__c];
        } else if (name != '' && category.isEmpty()) {
            System.debug('here');
            String key = '%' + name + '%';
            collections = [SELECT name,Status__c,isActive__c,Category__c FROM Collection__c where name LIKE :key];
        } else if (!category.isEmpty() && name == '') {
            collections = [SELECT name,Status__c,isActive__c,Category__c FROM Collection__c where Category__c IN :category];

        } else if (!category.isEmpty() && name != '') {
            System.debug('here is something else');
            String key = '%' + name + '%';
            collections = [SELECT name,Status__c,isActive__c,Category__c FROM Collection__c where name LIKE :key AND Category__c IN :category];
        }
        List<CollectionDto> collectionDtos = new List<CollectionDto>();
        for (Collection__c collection : collections) {
            CollectionDto collectionDto = new CollectionDto();
            collectionDto.category = collection.Category__c;
            collectionDto.status = collection.Status__c;
            collectionDto.isActive = collection.isActive__c;
            collectionDto.name = collection.Name;
            collectionDto.id = collection.Id;
            collectionDtos.add(collectionDto);
        }
        System.debug(collectionDtos);
        return collectionDtos;
    }
    @AuraEnabled(Cacheable=true)
    public static List<ProductDto> getRelatedProducts(List<String> ids) {
        List<Product2> products = [SELECT Name, Price__c, (SELECT Name from PricebookEntries) from Product2 where Collection__c IN :ids];
        List<ProductDto> productDtos = new List<ProductDto>();
         for(Product2 product: products){
             ProductDto productDto=new ProductDto();
             productDto.name=product.Name;
             productDto.price=(Integer) product.Price__c;
             productDto.priceBookName=product.PricebookEntries[0].Name;
             productDtos.add(productDto);
         }
        return productDtos;
    }
    public class ProductDto {
        @AuraEnabled public String name;
        @AuraEnabled public Integer price;
        @AuraEnabled public String priceBookName;
    }
    public class CollectionDto {
        @AuraEnabled public String id;
        @AuraEnabled public String name;
        @AuraEnabled public String status;
        @AuraEnabled public String category;
        @AuraEnabled public Boolean isActive;
    }
}