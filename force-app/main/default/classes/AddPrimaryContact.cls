/**
 * Created by aketa on 10/25/2021.
 */

public with sharing class AddPrimaryContact implements Queueable{
    Contact contact;
    String state;
public AddPrimaryContact(Contact contact,String state){
    this.contact=contact;
    this.state=state;
}
    public void execute(QueueableContext param1) {
        List<Account> accounts=[SELECT id,(SELECT Id,FirstName,LastName from Contacts) from Account where BillingState=:state LIMIT 200];
       List<Contact> contacts=new List<Contact>();
        for(Account account: accounts){
            Contact cont=contact.clone(false,false,false,false);
            cont.AccountId=account.Id;
            contacts.add(cont);
        }
        if(contacts.size()>0){
            insert contacts;
        }
    }
}