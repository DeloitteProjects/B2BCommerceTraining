/**
 * Created by aketa on 10/18/2021.
 */
@IsTest
public with sharing class WebinarTeamTriggerTest {
@IsTest
    public static void fillInParticipantsAutomaticallyTest(){
    Webinar__c webinar=new Webinar__c(Name='new webinar');
    insert webinar;
    Webinar_Team_Member__c webinarTeam=new Webinar_Team_Member__c(Name='new webinar team',Related_Webinar__c=webinar.Id);
    Test.startTest();
    insert webinarTeam;
    Test.stopTest();
    Webinar__c web=[select Number_of_Participants__c from Webinar__c];
    System.assertEquals(web.Number_of_Participants__c,1);
}
    @IsTest
    public static void contactOnlyOnExternalTest(){
        Webinar__c webinar=new Webinar__c(Name='new Webinar',Type__c='Internal');
        insert webinar;
        Contact contact=new Contact(LastName='keta');
        insert contact;
        Webinar_Team_Member__c webTeam=new Webinar_Team_Member__c(Name='New team',Related_Webinar__c=webinar.Id
        ,Related_Contact__c=contact.Id);
        try{
            insert webTeam;
        }catch(Exception e){
            boolean condition=e.getMessage().contains('An Internal Type Webinar does n\'t have contacts')?true:false;
            System.assertEquals(condition,true);
        }
    }
    @IsTest
    public static void neverUserAndContactSimultaneoslyTest(){
        Contact contact=new Contact(LastName='keta');
        User user=[Select id from User limit 1];
        insert contact;
      Webinar_Team_Member__c webTeam=new Webinar_Team_Member__c(Name='webTeam',Related_Contact__c=contact.id,Related_User__c=user.Id);
        try{
            insert webTeam;
        }catch(Exception e){
            boolean condition=e.getMessage().contains('There should be only one field: User or Contact')?true:false;
            System.assertEquals(condition,true);
        }
    }
    @IsTest
    public static void commentToBeFilledTest(){
        Webinar_Team_Member__c webinarTeamMember=new Webinar_Team_Member__c(Name='new Teama',Status__c='Rejected');
        try{
            insert webinarTeamMember;
        }catch(Exception e){
            boolean condition=e.getMessage().contains('Comment must be filled if status is rejected')?true:false;
            System.assertEquals(condition,true);
        }
    }
    @IsTest
    public static void twoWebinarTeamMembersWithTheSameFieldsTest(){

        User user=[SELECT id from User LIMIT 1];
        Webinar__c webinar=new Webinar__c(Name='new Webinar');
        insert webinar;
        Webinar_Team_Member__c webTeam1=new Webinar_Team_Member__c(Name='webTeam1',Related_User__c=user.id,
                Related_Webinar__c=webinar.id);
        insert webTeam1;

        Webinar_Team_Member__c webTeam2=new Webinar_Team_Member__c(Name='webTeam1',Related_User__c=user.id,
                Related_Webinar__c=webinar.id);
        try{
            insert webTeam2;
        }catch(Exception e){
            boolean condition=e.getMessage().contains('The Fields Contact and Use should NOT be the same as the other Web Team Member record')?true:false;
            System.assertEquals(condition,true);
        }

    }


}