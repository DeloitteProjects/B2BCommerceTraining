/**
 * Created by aketa on 10/18/2021.
 */
@IsTest
public with sharing class WebinarTriggerTest {
@IsTest
    public static void testWebinarTrigger(){
  Webinar__c webinar=new Webinar__c(Name='new Webinar',Cost__c=120,Number_of_Seats__c=20,Number_of_Participants__c=10);
    insert webinar;
    Webinar__c web=[Select Price_Per_Participant__c from Webinar__c];
    System.assertEquals(web.Price_Per_Participant__c, 6);
}
  @IsTest
  public static void testWebinarInserted(){
    Webinar__c webinar=new Webinar__c(Name='new Webinar',Cost__c=120,Number_of_Seats__c=20,Number_of_Participants__c=30);
    try{
    insert webinar;
    }catch(Exception e){
      boolean condition=e.getMessage().contains('This Field should Not be bigger than the number of seats!')?true:false;
      System.assertEquals(condition,true);
    }

  }
  @IsTest
  public static void testUpdateOnChangeStatus(){
    Webinar__c webinar=new Webinar__c(Name='new Webinar',Status__c='New',Approval_Status__c='Pending');
    insert webinar;
    Webinar__c web=[select Status__c,Approval_Status__c from Webinar__c];
    web.Status__c='';
    try{
      update web;
    }catch (Exception e){
      boolean condition=e.getMessage().contains('This Field can no longer be Pending')?true:false;
      System.assertEquals(condition,true);
    }
  }

}