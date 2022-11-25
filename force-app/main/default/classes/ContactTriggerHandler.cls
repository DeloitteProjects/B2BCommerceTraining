/**
 * Created by aketa on 10/17/2021.
 */

public with sharing class ContactTriggerHandler {
    public void createAccountWhenContactAccountFieldEmpty(List<Contact> contacts){
        List<Account> accountToAdd=new List<Account>();
        for(Contact contact: contacts){
            if(contact.AccountId==null){
                Account account=new Account(Name=contact.Name);
                accountToAdd.add(account);
            }
        }
        if(!accountToAdd.isEmpty()) {
            insert accountToAdd;
        }
    }
    public void modifyAllAccountsWherePostalIsNull(List<Contact> contacts){
        Set<Id> accountId=new Set<Id>();
        for(Contact contact: contacts){
            if(contact.AccountId!=null && contact.MailingPostalCode==null){
                accountId.add(contact.AccountId);
            }
        }
        Map<Id,Account> accountMap=new Map<Id,Account>([Select Out_of_Zip__c from Account where id in : accountId]);
        for(Contact contact: contacts){
            if(contact.AccountId!=null && contact.MailingPostalCode==null){
                accountMap.get(contact.AccountId).Out_of_Zip__c=true;
            }
        }
        update accountMap.values();
    }

}