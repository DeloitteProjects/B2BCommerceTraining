/**
 * Created by aketa on 5/28/2022.
 */
@RestResource(UrlMapping='/OpportunityAssert/*')
global with sharing class OpportunityRestCommunicator {

    @HttpGet
    global static Opportunity getOpportunity(){
        Opportunity opp = [SELECT Id, Name FROM Opportunity ORDER BY CreatedDate DESC LIMIT 1];
        return opp;
    }

    @HttpDelete
    global static void deleteOpportunity(){
        RestRequest request=RestContext.request;
        String oppId=request.requestURI.substring(request.requestUri.lastIndexOf('/')+1);
        Opportunity opp = [SELECT Id, Name FROM Opportunity WHERE Id =:oppId LIMIT 1];
        delete opp;
    }
}