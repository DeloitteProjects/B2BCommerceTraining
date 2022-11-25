/**
 * Created by aketa on 10/29/2021.
 */

trigger TeamTrigger on Team__c (after insert) {
TeamTriggerHandler teamTriggerHandler=new TeamTriggerHandler();
    teamTriggerHandler.fillPointsWithZero(Trigger.new);
}