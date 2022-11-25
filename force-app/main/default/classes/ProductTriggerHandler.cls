/**
 * Created by aketa on 10/27/2021.
 */

public with sharing class ProductTriggerHandler{
    /*public List<Product2> newProducts;
    public List<Product2> oldProducts;
    public ProductTriggerHandler(List<Product2> newProducts, List<Product2> oldProducts) {
        this.newProducts = newProducts;
        this.oldProducts = oldProducts;
    }
    public void execute(QueueableContext param1) {
        System.debug('I am here');
        Set<Id> productId = new Set<Id>();
        for (Product2 product : newProducts) {
            productId.add(product.Id);
        }
        AggregateResult[] product=(AggregateResult[]) [SELECT Product2.Id Id FROM OrderItem WHERE Product2.Id IN :productId];
        productId=new Set<Id>();
        for(Integer i=0;i<product.size();i++){
            productId.add(product[i].get('Id'));
        }
        List<OrderItem> orderItems = [SELECT OrderId,Product2Id FROM OrderItem WHERE Product2.Id IN :productId];
        System.debug(orderItems);
        List<Id> ordersId = new List<Id>();
        for (OrderItem orderItem : orderItems) {
            ordersId.add(orderItem.OrderId);
        }

        List<Order> orders = [SELECT Id,Status from Order where Id in:ordersId];
        List<Case> cases = new List<Case>();
        for (Product2 product : newProducts) {
            if (productId.contains(product.Id)) {
                Date newProductDate = product.Release_Date__c;
                Date oldProductDate = oldProducts.get(newProducts.indexOf(product)).Release_Date__c;
                if (newProductDate != null && oldProductDate != null) {
                    if (newProductDate > oldProductDate && (orders.get(newProducts.indexOf(product)).Status == 'Pending')
                            || orders.get(newProducts.indexOf(product)).Status == 'Confirmed') {
                        Case anotherCase = new Case();
                        anotherCase.Case_Category__c = 'Release delay';
                        anotherCase.Order__c = orderItems.get(newProducts.indexOf(product)).OrderId;
                        System.debug(anotherCase);
                        cases.add(anotherCase);
                    }
                }
            }
            insert cases;
        }
    }*/

    public void createNewPriceBookEntry(List<Product2> products){
        Pricebook2 pricebook=[SELECT Id,IsActive FROM Pricebook2 WHERE IsStandard=TRUE LIMIT 1];
        System.debug(pricebook);
        List<PricebookEntry> pricebookEntries=new List<PricebookEntry>();
        for(Product2 product: products){
            PricebookEntry pricebookEntry =new PricebookEntry();
            pricebookEntry.UnitPrice=product.Price__c;
            pricebookEntry.Pricebook2Id=pricebook.Id;
            pricebookEntry.Product2Id=product.Id;
            //pricebookEntry.IsActive=true;
            pricebookEntries.add(pricebookEntry);
        }
        insert pricebookEntries;
    }
}