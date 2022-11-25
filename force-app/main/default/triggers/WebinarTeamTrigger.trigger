/**
 * Created by aketa on 10/15/2021.
 */

trigger WebinarTeamTrigger on Webinar_Team_Member__c (after insert,after update,before insert,before update,before delete, after delete) {
WebinarTeamTriggerHandler webinarTeamTriggerHandler=new WebinarTeamTriggerHandler();
    if(Trigger.isBefore&&(Trigger.isInsert||Trigger.isUpdate)) {
        webinarTeamTriggerHandler.contactOnlyInExternalType(Trigger.new);
        webinarTeamTriggerHandler.commentToBeFilled(Trigger.new);
        webinarTeamTriggerHandler.neverContactAndUserFieldSimultaneosly(Trigger.new);
        webinarTeamTriggerHandler.twoWebinarTeamMembersWithTheSameFields(Trigger.new);
    }
    if(Trigger.isAfter&&(Trigger.isInsert||Trigger.isUpdate)){
        webinarTeamTriggerHandler.fillInParticipantsAutomatically(Trigger.new);
    }
   /* if(Trigger.isAfter&&Trigger.isDelete){
        webinarTeamTriggerHandler.removeParticipantsAutomatically(Trigger.old);
    }

    */
}