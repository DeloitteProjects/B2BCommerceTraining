/**
 * Created by aketa on 10/29/2021.
 */

public with sharing class SendEmailParticipation implements Database.Batchable<sObject> {

    public Database.QueryLocator start(Database.BatchableContext param1) {
        Datetime tomorrow=System.now().addDays(1);
        return Database.getQueryLocator([
                SELECT Employee__r.Mail__c, Employee__r.First_Name__c
                        ,Employee__r.Last_Name__c, Action__r.Name, Action__r.Start_Date__c
                FROM EmployeeAction__c
        ]);
    }

    public void execute(Database.BatchableContext param1, List<EmployeeAction__c> employeeActions) {
        List<String> emails = new List<String>();
      System.debug(employeeActions);
        List<Messaging.SingleEmailMessage> emailMsgList = new List<Messaging.SingleEmailMessage>();
        for (EmployeeAction__c employeeAction : employeeActions) {
            emails = new List<String>();
            emails.add(employeeAction.Employee__r.Mail__c);
            System.debug(emails);
            Messaging.SingleEmailMessage emailMessage = new Messaging.SingleEmailMessage();
            emailMessage.toaddresses = emails;
            emailMessage.subject = 'Participation in an Action';
            String message = 'Dear ' + employeeAction.Employee__r.First_Name__c + ' ' + employeeAction.Employee__r.Last_Name__c + '<br>' +
                    'This message is sent to you that the Action Named: ' + employeeAction.Action__r.Name + ' is going to take place on ' +
                    employeeAction.Action__r.Start_Date__c;
            emailMessage.setHtmlBody(message);
            emailMsgList.add(emailMessage);
        }
        System.debug(emailMsgList.size());
        if (emailMsgList.size() > 0) {
            //Sent email
            Messaging.sendEmail(emailMsgList);
            system.debug('Email is sent Successfully.');
        }
    }

    public void finish(Database.BatchableContext param1) {
    }

}