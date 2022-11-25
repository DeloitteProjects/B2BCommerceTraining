/**
 * Created by aketa on 10/26/2021.
 */

global with sharing class RestControllerChange {
   public WebinarWrapper getWebinar(String extId){
    Http http = new Http();
    HttpRequest request = new HttpRequest();
       String var='callout:connectChangePrice/'+extId;
       System.debug(var);
       request.setEndpoint(var);
    //request.setEndpoint('https://calculateprice.getsandbox.com/calculatePrice/'+extId);
    request.setMethod('GET');
    HttpResponse response = http.send(request);
       if(response.getStatusCode() == 200) {
           WebinarWrapper web;
         web= (WebinarWrapper)JSON.deserialize(response.getBody(), WebinarWrapper.class);
          // Map<String, Object> webinarMap =  (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
           System.debug('Received the following webinars:');


           return  web;

    }
       return null;
}


    public void updateWebinars(Id webId){
        Webinar__c webinar=[Select Price_Per_Participant__c,External_Id__c
        from Webinar__c where Id= :webId AND External_Id__c!=null];
        webinar.Price_Per_Participant__c = getWebinar(webinar.External_Id__c).price;
   update webinar;

    }
    public class WebinarWrapper{
        public String extId;
       public Integer price;
public String currencyCode;
    }

}