/**
 * Created by aketa on 10/29/2021.
 */

public with sharing class ActionTriggerHandler {
    public void changeEmployeeActions(List<Action__c> actions) {
        Set<Id> actionIds = new Set<Id>();
        for (Action__c action : actions) {
            if (action.Status__c == 'Finished') {
                actionIds.add(action.Id);
            }
        }
        List<Action__c> changeActions = [SELECT Id, (SELECT Status__c,Success_Metric__c,Calculated_Points__c FROM EmployeeActions__r) FROM Action__c WHERE Id IN :actionIds];
        List<EmployeeAction__c> employeeActionsToUpdate = new List<EmployeeAction__c>();
        for (Action__c action : changeActions) {
            for (EmployeeAction__c employeeAction : action.EmployeeActions__r) {
                if (employeeAction.Status__c != 'Completed') {
                    employeeAction.Status__c = 'Failed';
                    employeeAction.Success_Metric__c=0;
                    employeeAction.Calculated_Points__c=0;
                    employeeActionsToUpdate.add(employeeAction);
                }
            }
        }
        update employeeActionsToUpdate;
    }
}