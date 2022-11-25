/**
 * Created by aketa on 10/27/2021.
 */

public with sharing class GetBookTittles {
@AuraEnabled(Cacheable=true)
public static List<OrderItemDto> getBookTittles(String title){
    System.debug(title);
    List<OrderItem> orderItems;
    if(title==''){
       orderItems= [SELECT Order.OrderNumber, Order.EffectiveDate,Order.Status, Quantity,Product2.Name from OrderItem];
    }else{
       String key='%'+title+'%';
        List<Product2> products= [SELECT Id from Product2 where Name Like :key];
        orderItems = [SELECT Order.OrderNumber, Order.EffectiveDate,Order.Status, Quantity,Product2.Name from OrderItem where Product2Id IN :products];
    }
    List<OrderItemDto> orderItemDtos=new List<OrderItemDto>();
    for(OrderItem orderItem:orderItems){
        OrderItemDto orderItemDto=new OrderItemDto();
        orderItemDto.orderStatus=orderItem.Order.Status;
        orderItemDto.orderCreatedDate=(Date) orderItem.Order.EffectiveDate;
        orderItemDto.quantity=(Integer) orderItem.Quantity;
        orderItemDto.orderName= orderItem.Order.OrderNumber;
        orderItemDto.name=orderItem.Product2.Name;
        orderItemDtos.add(orderItemDto);
    }
    return orderItemDtos;
}
    public class OrderItemDto{
        @AuraEnabled public String orderName;
        @AuraEnabled public Date orderCreatedDate;
        @AuraEnabled public String orderStatus;
        @AuraEnabled public Integer quantity;
        @AuraEnabled public String name;
    }
}