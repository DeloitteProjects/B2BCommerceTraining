/**
 * Created by aketa on 10/15/2021.
 */

trigger WebinarTrigger on Webinar__c(before insert,before update){
    WebinarTriggerHandler webinarTriggerHandler=new WebinarTriggerHandler();
   // for(Webinar__c web:Trigger.new){
    /*if(web.Cost__c<=100){
        web.Approval_Status__c='Approved';
    }
        if(web.Status__c=='Canceled'){
            web.Approval_Status__c='Rejected';
        }*/
       /*4-List<Webinar_Team_Member__c> webTeam=
        [Select Related_Contact__c
        from Webinar_Team_Member__c
        where Related_Webinar__c
        in (select id from Webinar__c
        where Type__c='Internal')];
    for(Webinar_Team_Member__c web:webTeam){
        web.Related_Contact__c=null;
    }
        update webTeam;
*/

  /*6- List<Webinar__c> web2Delete=new List<Webinar__c>();

    for (Webinar__c webinar: web2Delete){
        webinar.Number_of_Participants__c.addError('This field should be less than the number of fields!');
    }

}
if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
    if(Trigger.isUpdate){
        webinarTriggerHandler.onStatusUpdateIsPending(Trigger.old,Trigger.new);
    }
    webinarTriggerHandler.calculatePricePerParticipant(Trigger.new);
    webinarTriggerHandler.exceededNumberOfParticipants(Trigger.new);
}*/
}