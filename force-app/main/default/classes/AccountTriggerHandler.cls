/**
 * Created by aketa on 10/17/2021.
 */

public with sharing class AccountTriggerHandler {
public void addProfileFieldToContacts(List<Account> accounts){
   Set<Id> contactId=new Set<Id>();
    for(Account account:accounts){
        for(Contact contact: account.Contacts){
            contactId.add(contact.Id);
        }
    }
    Map<Id,Contact> contactMap=new Map<Id,Contact>([Select Profile__c from Contact where id in: contactId]);
    for(Id id:contactId){
        contactMap.get(Id).Profile__c='Website';
    }
    if(!contactMap.isEmpty()){
        Database.update(contactMap.values(),false);
    }

}
}