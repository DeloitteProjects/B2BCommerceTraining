/**
 * Created by aketa on 10/26/2021.
 */
@RestResource(UrlMapping='/Webinar/*')
global with sharing class TestCrud {
@HttpGet
global static Webinar__c getAllWebinars(){
RestRequest request=RestContext.request;
    String webId=request.requestURI.substring(request.requestUri.lastIndexOf('/')+1);
    Webinar__c web=[SELECT Id,Name FROM Webinar__c WHERE Id=:webId LIMIT 1];
    return web;
}
    @HttpPost
    global static void setWebinar(String name) {
        Webinar__c web=new Webinar__c(Name=name);
        insert web;
    }
    @HttpPut
    global static void updateWebinar(String name, String webId){
        Webinar__c web=[SELECT Id,Name FROM Webinar__c WHERE Id=:webId LIMIT 1];
        web.Name=name;
        update web;
    }
    @HttpDelete
    global static void deleteWebinar(){
        RestRequest request=RestContext.request;
        String webId=request.requestURI.substring(request.requestUri.lastIndexOf('/')+1);
        Webinar__c web=[SELECT Id,Name FROM Webinar__c WHERE Id=:webId LIMIT 1];

        delete web;
    }

}