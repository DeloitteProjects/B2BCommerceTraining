/**
 * Created by aketa on 10/27/2021.
 */

public with sharing class GetLocation {
    @AuraEnabled(Cacheable=true)
    public static List<LocationDto> getProductLocation(Id productId) {
        List<OrderItem> orderItems=[SELECT Order.Account.Name,Order.Account.BillingState,Order.Account.BillingStreet,
        Order.Account.BillingCity,Order.Account.BillingCountry,Order.Account.BillingPostalCode
        FROM OrderItem WHERE Product2Id=:productId];
        List<LocationDto> locations=new List<LocationDto>();
        for(OrderItem orderItem:orderItems){
            LocationDto locationDto=new LocationDto();
            locationDto.state=orderItem.Order.Account.BillingState;
            locationDto.street=orderItem.Order.Account.BillingStreet;
            locationDto.country=orderItem.Order.Account.BillingCountry;
            locationDto.city=orderItem.Order.Account.BillingCity;
            locationDto.postalCode=orderItem.Order.Account.BillingPostalCode;
            locationDto.accountName=orderItem.Order.Account.Name;
            locations.add(locationDto);
        }
        return locations;
    }
    public class LocationDto {
        @AuraEnabled public String accountName;
        @AuraEnabled public String city;
        @AuraEnabled public String country;
        @AuraEnabled public String postalCode;
        @AuraEnabled public String state;
        @AuraEnabled public String street;
    }
}