/**
 * Created by aketa on 10/21/2021.
 */
public with sharing class WebinarComponentController {
    @AuraEnabled
    public static List<Webinar__c> getWebinarsList(){
        return [SELECT Id, Name FROM Webinar__c WHERE Cost__c >= 100 AND Approval_Status__c = 'Pending' ];
    }
}