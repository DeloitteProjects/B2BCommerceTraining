/**
 * Created by aketa on 11/2/2021.
 */

trigger EmployeeTrigger on Employee__c (before delete,before insert) {
EmployeeTriggerHandler employeeTriggerHandler=new EmployeeTriggerHandler();
    if(Trigger.isBefore && Trigger.isDelete){
        employeeTriggerHandler.deleteEmployee(Trigger.old);
    }
    if (Trigger.isBefore && Trigger.isInsert){
        employeeTriggerHandler.zero(Trigger.new);
    }
}