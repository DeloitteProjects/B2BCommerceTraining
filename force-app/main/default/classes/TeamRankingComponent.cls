/**
 * Created by aketa on 10/29/2021.
 */
/**
 * This class is used a repository for our LWC component
 * Thanks to this class we can retrieve any information we need
 * for our component to work
 */
public with sharing class TeamRankingComponent {

    /**
     * @description Get all Teams' Name and total points in
     * a descending order
     * @return TeamDto: A wrapper class that makes it easier
     * to get and process information on teamRanking lwc component
     */
    @AuraEnabled(Cacheable=true)
    public static List<TeamDto> getTeams() {
        List<Team__c> teams = [
                SELECT Name,Total_Points__c
                FROM Team__c
                WHERE Type__c = 'Team'
                ORDER BY Total_Points__c DESC
        ];
        return setTeamDto(teams, new List<Team__c>());
    }

    /**
     * @description Get a Teams' Name and total points in
     * a descending order based on its name
     * @param name (String): the Name of a team
     *
     * @return TeamDto: A wrapper class that makes it easier
     * to get and process information on teamRanking lwc component
     */
    @AuraEnabled(Cacheable=true)
    public static List<TeamDto> getTeamsByName(String name) {
        List<Team__c> teams = new List<Team__c>();
        List<Team__c> ranking = new List<Team__c>();
        if (name == null) {
            teams = [
                    SELECT Name,Total_Points__c
                    FROM Team__c
                    WHERE Type__c = 'Team'
                    ORDER BY Total_Points__c DESC
            ];
            ranking = teams;
        } else {
            String key = '%' + name + '%';
            ranking = [
                    SELECT Name,Total_Points__c
                    FROM Team__c
                    WHERE Type__c = 'Team'
                    ORDER BY Total_Points__c DESC
            ];
            teams = [
                    SELECT Name,Total_Points__c
                    FROM Team__c
                    WHERE Type__c = 'Team' AND Name LIKE :key
                    ORDER BY Total_Points__c DESC
            ];
        }
        return setTeamDto(teams, ranking);
    }

    /**
     * @param teamId (List<Id>): List of employees Id
     *
     * @return EmployeeDto: A wrapper class that makes it easier
     * to get and process information on teamRanking lwc component
     */
    @AuraEnabled(Cacheable=true)
    public static List<EmployeeDto> getEmployees(List<Id> teamId) {
        List<Employee__c> employees = [SELECT Name,Total_Points__c, Team__r.Name FROM Employee__c WHERE Team__c IN :teamId ORDER BY Total_Points__c DESC];

        return setEmployeeDto(employees);
    }

    /**
     * @description this method provides us with a list of ranked TeamDto objects
     * @param teams (List<Team__c>): A list of teams to be shown
     * @param ranking (List<Team__c>): A list of teams that will help
     * us with the ranking of teams
     *
     * @return (List<TeamDto>): A list of TeamDto Wrapper classes
     */
    public static List<TeamDto> setTeamDto(List<Team__c> teams, List<Team__c> ranking) {
        List<TeamDto> teamDtos = new List<TeamDto>();
        Set<Id> teamIds = new Set<Id>();
        for (Team__c team : teams) {
            teamIds.add(team.Id);
        }
        Map<Id, Employee__c> emp = new Map<Id, Employee__c> ([SELECT Team__c FROM Employee__c WHERE Team__c In:teamIds]);
        Set<Id> empIds = emp.keySet();
        for (Team__c team : teams) {
            TeamDto teamDto = new TeamDto();
            teamDto.name = team.Name;
            teamDto.position = ranking.indexOf(team) + 1;
            Integer size = 0;
            for (Id empId : empIds) {
                if (emp.get(empId).Team__c == team.Id) {
                    size++;
                }
            }
            teamDto.numberOfEmployees = size;
            teamDto.totalPoints = (Integer) team.Total_Points__c;
            teamDto.id = team.Id;
            teamDtos.add(teamDto);
        }

        return teamDtos;
    }

    /**
     * @description this method is used to transform Employee_c objects to
     * EmployeeDto objects
     * @param employees (List<Employee__c>): a list of employees
     *
     * @return (List<EmployeeDto>): A list of wrapper classes
     */
    public static List<EmployeeDto> setEmployeeDto(List<Employee__c> employees) {
        List<EmployeeDto> employeesDtos = new List<EmployeeDto>();
        Set<Id> empIds = new Set<Id>();
        for (Employee__c emp : employees) {
            empIds.add(emp.Id);
        }
        Map<Id, EmployeeAction__c> emp = new Map<Id, EmployeeAction__c> ([SELECT Employee__c FROM EmployeeAction__c WHERE Employee__c In:empIds]);
        Set<Id> empActionIds = emp.keySet();
        for (Employee__c employee : employees) {
            EmployeeDto employeeDto = new EmployeeDto();
            employeeDto.empName = employee.Name;
            Integer size = 0;
            for (Id empId : empActionIds) {
                if (emp.get(empId).Employee__c == employee.Id) {
                    size++;
                }
            }
            employeeDto.amountOfParticipatedEvents = size;
            employeeDto.empTotalPoints = (Integer) employee.Total_Points__c;
            System.debug(employee.Team__r.Name);
            employeeDto.teamNames = employee.Team__r.Name;
            System.debug('Team Names: '+employeeDto.teamNames);
            employeesDtos.add(employeeDto);
        }
        return employeesDtos;
    }

    /**
     * @description wrapper class for Team__c objects
     * makes it easier to work with on the lwc component
     */
    public class TeamDto {
        @AuraEnabled public Integer position;
        @AuraEnabled public String name;
        @AuraEnabled public Integer numberOfEmployees;
        @AuraEnabled public Integer totalPoints;
        @AuraEnabled public String id;
    }

    /**
     * @description wrapper class for Employee__c objects
     * makes it easier to work with on the lwc component
     */
    public class EmployeeDto {
        @AuraEnabled public String empName;
        @AuraEnabled public Integer amountOfParticipatedEvents;
        @AuraEnabled public Integer empTotalPoints;
        @AuraEnabled public String teamNames;
    }
}