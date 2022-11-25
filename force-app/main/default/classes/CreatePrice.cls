public with sharing class CreatePrice {
    public String extId;
    public Integer price;
    public String currencyCode;

    public static CreatePrice parse (String json){
        return (CreatePrice) System.JSON.deserialize(json,CreatePrice.class);
    }
}