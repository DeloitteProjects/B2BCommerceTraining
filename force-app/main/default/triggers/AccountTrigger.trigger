/**
 * Created by aketa on 10/17/2021.
 */

trigger AccountTrigger on Account (after update) {
    AccountTriggerHandler accountTriggerHandler=new AccountTriggerHandler();


 accountTriggerHandler.addProfileFieldToContacts(Trigger.new);

}