/**
 * Created by aketa on 10/29/2021.
 */

trigger EmployeeActionTrigger on EmployeeAction__c (after insert, before insert,before update,after update,after delete) {
    EmployeeActionTriggerHandler employeeActionTriggerHandler = new EmployeeActionTriggerHandler();

    if (Trigger.isAfter && Trigger.isInsert) {
        employeeActionTriggerHandler.formatNameEmployeeAction(Trigger.new);
        employeeActionTriggerHandler.afterInsertEmployeeAction(Trigger.new);
    }
    if(Trigger.isUpdate && Trigger.isBefore){
        employeeActionTriggerHandler.beforeUpdateEmployeeAction(Trigger.new);
    }
    if(Trigger.isUpdate && Trigger.isAfter){
       employeeActionTriggerHandler.addPointsAutomatically(Trigger.new);
    }
    if(Trigger.isAfter && Trigger.isDelete){
        employeeActionTriggerHandler.addPointsAutomatically(Trigger.new);
    }
    if (Trigger.isBefore && Trigger.isInsert) {
        employeeActionTriggerHandler.sendErrorIfActionNotOpen(Trigger.new);
    }
}