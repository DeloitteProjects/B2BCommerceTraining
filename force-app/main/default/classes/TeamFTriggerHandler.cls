/**
 * Created by aketa on 4/29/2022.
 */

public with sharing class TeamFTriggerHandler {

   public void UpdateTeamName(List<Team_Foosball__c> teams){

       for(Team_Foosball__c team: teams){
           team.Name = team.First_Player__r.Name +' - '+ team.Second_Player__r.Name;
       }

   }

   public List<Team_Foosball__c> TeamCombinationExists(List<Team_Foosball__c> teams){

       List<Team_Foosball__c> teams2Check = [SELECT Name, Second_Player__c, First_Player__c FROM Team_Foosball__c];
       List<Team_Foosball__c> uniqueTeams=new List<Team_Foosball__c>();

       for(Team_Foosball__c team: teams){
           Boolean isUnique=true;
           for(Team_Foosball__c team2Check: teams2Check){
               if((team.First_Player__c == team2Check.First_Player__c && team.Second_Player__c == team2Check.Second_Player__c) || (team.First_Player__c == team2Check.Second_Player__c && team.Second_Player__c == team2Check.First_Player__c)){
                   team.addError('This team has been registered before as: '+ team2Check.Name);
                   isUnique=false;
                   break;
               }

           }

           if(isUnique){
               uniqueTeams.add(team);
           }
       }

       return uniqueTeams;
   }
}