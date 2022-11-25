/**
 * Created by aketa on 10/29/2021.
 */

public with sharing class EmployeeActionTriggerHandler {
    public void formatNameEmployeeAction(List<EmployeeAction__c> employeeActions) {
        Set<Id> employeeActionIds = new Set<Id>();
        for (EmployeeAction__c employeeAction : employeeActions) {
            employeeActionIds.add(employeeAction.Id);
        }
        List<EmployeeAction__c> employeesActionsUpdate = [SELECT Name,Employee__r.First_Name__c,Employee__r.Last_Name__c,Action__r.Name FROM EmployeeAction__c where Id IN :employeeActionIds];
        for (EmployeeAction__c empUpdate : employeesActionsUpdate) {
            empUpdate.Name = empUpdate.Employee__r.First_Name__c + ' ' + empUpdate.Employee__r.Last_Name__c + ' | ' + empUpdate.Action__r.Name;
        }
        update employeesActionsUpdate;
    }
    public void  beforeUpdateEmployeeAction(List<EmployeeAction__c> employeeActions){
        Set<Id> empActIds=new Set<Id>();
        Set<Id> empIds=new Set<Id>();
        for(EmployeeAction__c employeeAction:employeeActions){
            empActIds.add(employeeAction.Id);
            empIds.add(employeeAction.Employee__c);
        }
        List<EmployeeAction__c> emps=[SELECT Calculated_Points__c,Action__r.Base_Points__c,Id FROM EmployeeAction__c WHERE Id IN : empActIds];
        for(EmployeeAction__c emp:emps){
            for(EmployeeAction__c employeeAction:employeeActions){
                if(employeeAction.Id==emp.Id) {
                    employeeAction.Calculated_Points__c = employeeAction.Success_Metric__c * emp.Action__r.Base_Points__c / 100;
                }
            }
        }

    }
    public void afterInsertEmployeeAction(List<EmployeeAction__c> employeeActions) {
        Set<Id> employeeActionIds = new Set<Id>();
        for (EmployeeAction__c employeeAction : employeeActions) {
            employeeActionIds.add(employeeAction.Id);
        }
        List<EmployeeAction__c> employeesActionsUpdate = [SELECT Employee__c,Success_Metric__c, Calculated_Points__c,Action__r.Base_Points__c FROM EmployeeAction__c where Id IN :employeeActionIds];
        Set<Id> empIds = new Set<Id>();
        for (EmployeeAction__c employeeAction : employeesActionsUpdate) {
            employeeAction.Calculated_Points__c =employeeAction.Success_Metric__c * employeeAction.Action__r.Base_Points__c / 100;
            empIds.add(employeeAction.Employee__c);
        }
        update employeesActionsUpdate;
    }
    public void addPointsAutomatically(List<EmployeeAction__c> employeeActions) {
        System.debug('I am here');
        System.debug(employeeActions);
        Set<Id> empIds=new Set<Id>();
        if(employeeActions!=null){
        for(EmployeeAction__c employeeAction: employeeActions){
            empIds.add(employeeAction.Employee__c);
        }
        }
        System.debug(empIds);
        Set<Id> teamIds = new Set<Id>();
        List<Employee__c> employees=new List<Employee__c>();
        if(employeeActions!=null) {
            employees = [SELECT Team__c,Total_Points__c,Id, (SELECT Calculated_Points__c FROM EmployeeActions__r) FROM Employee__c WHERE Id IN :empIds];
        }else{
            employees = [SELECT Team__c,Total_Points__c,Id, (SELECT Calculated_Points__c FROM EmployeeActions__r) FROM Employee__c];

        }
            for (Employee__c emp : employees) {
            Integer sum = 0;
            for (EmployeeAction__c empAct : emp.EmployeeActions__r) {
                sum += (Integer) empAct.Calculated_Points__c;
            }
            emp.Total_Points__c = sum;
            sum = 0;
            teamIds.add(emp.Team__c);
        }
        update employees;
        List<Team__c> teams = [SELECT Parent_Team__c,Total_Points__c,Id, (SELECT Total_Points__c FROM Employees__r) From Team__c WHERE Id IN:teamIds];

        teamIds = new Set<Id>();
        for (Team__c team : teams) {
            Integer size = 0;
            for (Employee__c emp : team.Employees__r) {
                if(emp.Total_Points__c!=null){
                size += (Integer) emp.Total_Points__c;
                }
            }
            team.Total_Points__c = size;
            size = 0;
            if (team.Parent_Team__c != null) {
                teamIds.add(team.Parent_Team__c);
            }

        }
        update teams;
        List<Team__c> parentTeams = [SELECT Parent_Team__c,Total_Points__c, (SELECT Total_Points__c FROM Teams__r) FROM Team__c WHERE Id IN :teamIds];
        Integer sum = 0;
        teamIds = new Set<Id>();
        for (Team__c team : parentTeams) {
            for (Team__c teamful : team.Teams__r) {
                sum += (Integer) teamful.Total_Points__c;
            }
            if (team.Parent_Team__c != null) {
                teamIds.add(team.Parent_Team__c);
            }
            team.Total_Points__c = sum;
            sum = 0;
        }
        update parentTeams;
        parentTeams = [SELECT Total_Points__c, (SELECT Total_Points__c FROM Teams__r) FROM Team__c WHERE Id IN :teamIds];
        sum = 0;
        teamIds = new Set<Id>();
        for (Team__c team : parentTeams) {
            for (Team__c teamful : team.Teams__r) {
                sum += (Integer) teamful.Total_Points__c;
            }

            team.Total_Points__c = sum;
            sum = 0;
        }
        update parentTeams;
    }
    public void sendErrorIfActionNotOpen(List<EmployeeAction__c> employeeActions) {
        System.debug('I am here');
        Set<Id> actionId = new Set<Id>();
        for (EmployeeAction__c emp : employeeActions) {
            actionId.add(emp.Action__c);
        }
        List<Action__c> actions = [SELECT Status__c,Id FROM Action__c WHERE Id IN :actionId];
        for (EmployeeAction__c employeeAction : employeeActions) {
            System.debug(employeeAction.Action__c);
            for (Action__c action : actions) {
                if (employeeAction.Action__c == action.Id && action.Status__c != 'Open Registration') {
                    employeeAction.addError('Holly Guacamole! <br>Looks like your Action is not open for registration there');
                    break;
                }
            }
        }
    }
}