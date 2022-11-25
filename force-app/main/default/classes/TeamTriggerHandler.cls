/**
 * Created by aketa on 10/29/2021.
 */

public with sharing class TeamTriggerHandler {
public void fillPointsWithZero(List<Team__c> teams){
    Set<Id> teamIds=new Set<Id>();
    for(Team__c team:teams){
        teamIds.add(team.Id);
    }
    List<Team__c> teaming=[SELECT Total_Points__c FROM Team__c WHERE Id IN : teamIds];
    for(Team__c teamFul: teaming){
        teamFul.Total_Points__c=0;
    }
    update teaming;
}
}