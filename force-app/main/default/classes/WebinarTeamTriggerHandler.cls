/**
 * Created by aketa on 10/15/2021.
 */

public with sharing class WebinarTeamTriggerHandler {
    //3-
    public void fillInParticipantsAutomatically(List<Webinar_Team_Member__c> webinarTeamMembers){
      Set<Id> webId=new Set<Id>();
        for(Webinar_Team_Member__c webTeam: webinarTeamMembers){
            webId.add(webTeam.Related_Webinar__c);
        }
        List<Webinar__c> webinars=[select Number_of_Participants__c from Webinar__c where id in:webId];
        Map<Id,Webinar__c> webinarMap=new Map<Id,Webinar__c>(webinars);
        for(Webinar_Team_Member__c webTeam: webinarTeamMembers){
            if(webinarMap.get(webTeam.Related_Webinar__c).Number_of_Participants__c==null){
                webinarMap.get(webTeam.Related_Webinar__c).Number_of_Participants__c = 1;
            }else{
            webinarMap.get(webTeam.Related_Webinar__c).Number_of_Participants__c += 1;
            }
        }
        /*List<AggregateResult> participants =
              [SELECT count(id)numberofparticipants
        from Webinar_Team_Member__c
        where Related_Webinar__c
                in(select id from Webinar__c)
        GROUP BY Related_Webinar__c];
        List<Webinar__c> webinars=[select Number_of_Participants__c from Webinar__c];

        Integer index=0;
        for(;index<webinars.size();index++){
            webinars.get(index).Number_of_Participants__c=(Integer) participants[index].get('numberofparticipants');
        }*/
        update webinarMap.values();
        }
   /* public void removeParticipantsAutomatically(List<Webinar_Team_Member__c> webinarTeamMembers){
        Set<Id> webId=new Set<Id>();
        for(Webinar_Team_Member__c webTeam:webinarTeamMembers){
            webId.add(webTeam.Related_Webinar__c);
        }
        List<Webinar__c> webinars=[SELECT Number_of_Participants__c from Webinar__c where id in :webId];
        Map<Id,Webinar__c> webinarMap=new Map<Id,Webinar__c>(webinars);
        for(Webinar_Team_Member__c webTeam: webinarTeamMembers){
            webinarMap.get(webTeam.Related_Webinar__c).Number_of_Participants__c-=1;
        }
        update webinarMap.values();
    }*/
    //4-
    public void contactOnlyInExternalType(List<Webinar_Team_Member__c> webinarTeamMembers){
        Set<Id> webId=new Set<Id>();
        for(Webinar_Team_Member__c webTeam: webinarTeamMembers){
            webId.add(webTeam.Related_Webinar__c);
        }
        List<Webinar__c> webinars=[SELECT Type__c from Webinar__c where id in :webId];
        for(Webinar_Team_Member__c webTeam: webinarTeamMembers){
            if( webTeam.Related_Contact__c != null ){
                for(Webinar__c web:webinars){
                    if(web.Id == webTeam.Related_Webinar__c && web.Type__c == 'Internal'){
                        webTeam.Related_Contact__c.addError('An Internal Type Webinar does n\'t have contacts' );
                    break;
                    }
                }
            }
        }
    }
    //5-
    public void neverContactAndUserFieldSimultaneosly(List<Webinar_Team_Member__c> webinarTeamMembers){
            for(Webinar_Team_Member__c webTeamMember:webinarTeamMembers){
        if(webTeamMember.Related_Contact__c != null && webTeamMember.Related_User__c != null){
            webTeamMember.addError('There should be only one field: User or Contact');
        }
    }
    }

//9-
    public void commentToBeFilled(List<Webinar_Team_Member__c> webinarTeamMember){
        for(Webinar_Team_Member__c webTeamMember: webinarTeamMember){
            if(webTeamMember.Status__c=='Rejected' && webTeamMember.Comments__c==null){
                webTeamMember.Comments__c.addError('Comment must be filled if status is rejected');
            }
        }
    }
    //10-
    public void twoWebinarTeamMembersWithTheSameFields(List<Webinar_Team_Member__c> webinarTeamMember){
        List<Webinar_Team_Member__c> webinarTeam=[SELECT Related_User__c,Related_Contact__c,Related_Webinar__c from Webinar_Team_Member__c];
        for(Webinar_Team_Member__c webTeamMember: webinarTeamMember){
            for(Webinar_Team_Member__c webTeam: webinarTeam){
                if((webTeam.Related_Contact__c == webTeamMember.Related_Contact__c
                        || webTeam.Related_User__c == webTeamMember.Related_User__c)
                        && webTeam.Related_Webinar__c == webTeamMember.Related_Webinar__c
                        ){
                    webTeamMember.addError('The Fields Contact and Use should NOT be the same as the other Web Team Member record');
                    break;
                }
            }

        }
    }
}