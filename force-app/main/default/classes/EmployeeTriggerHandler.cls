/**
 * Created by aketa on 11/2/2021.
 */

public with sharing class EmployeeTriggerHandler {
public void deleteEmployee(List<Employee__c> employees){
    System.debug(employees);
    Set<Id> employeeIds=new Set<Id>();
    for(Employee__c employee:employees){
        employeeIds.add(employee.Id);
    }
    List<EmployeeAction__c> employeeActions=[SELECT Id FROM EmployeeAction__c WHERE Employee__c IN :employeeIds];
    if(!employeeActions.isEmpty()){
        delete employeeActions;
    }
}
    public void zero(List<Employee__c> employees){
        for(Employee__c emp:employees){
            emp.Total_Points__c=0;
        }
    }
}