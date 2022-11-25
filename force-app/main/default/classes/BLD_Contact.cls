/**
 * Created by aketa on 4/22/2022.
 */

public with sharing class BLD_Contact {
 private Contact contact= new Contact();

    public Contact getRecord(){
        return this.contact;
    }

    public BLD_Contact withRelatedAccount(BLD_Account accountBuilder){
        this.contact.Account = accountBuilder.getRecord();
        return this;
    }
}