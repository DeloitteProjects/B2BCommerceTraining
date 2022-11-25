/**
 * Created by aketa on 10/15/2021.
 */

public with sharing class WebinarTriggerHandler {

    public void exceededNumberOfParticipants(List<Webinar__c> webinars){
        for(Webinar__c web:webinars){
            if(web.Number_of_Participants__c!=null && web.Number_of_Seats__c!=null && web.Number_of_Participants__c > web.Number_of_Seats__c){
                web.Number_of_Participants__c.addError('This Field should Not be bigger than the number of seats!');
            }
        }
    }
    public void calculatePricePerParticipant(List<Webinar__c> webinars){
        for(Webinar__c web: webinars){
            if(web.Cost__c!=null && web.Number_of_Seats__c != null) {
                web.Price_Per_Participant__c = web.Cost__c / web.Number_of_Seats__c;
            }
        }
    }
    public void onStatusUpdateIsPending(List<Webinar__c> webinarsOld,List<Webinar__c> webinarsNew){
        Integer index=0;
        for(;index<webinarsNew.size();index++){
            if(webinarsOld.get(index).Status__c == 'New' &&
                    webinarsNew.get(index).Status__c != 'Cancelled' &&
                    webinarsNew.get(index).Status__c != 'New' &&
                    webinarsNew.get(index).Approval_Status__c =='Pending'){
                webinarsNew.get(index).Approval_Status__c.addError('This Field can no longer be Pending');
            }
        }
    }
}