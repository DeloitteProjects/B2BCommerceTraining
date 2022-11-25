/**
 * Created by aketa on 4/29/2022.
 */

trigger TRG_Team on Team_Foosball__c (before insert) {

    TeamFTriggerHandler teamTriggerHandler = new TeamFTriggerHandler();

    if(Trigger.isInsert && Trigger.isBefore){
        teamTriggerHandler.UpdateTeamName(teamTriggerHandler.TeamCombinationExists(Trigger.new));
    }
}