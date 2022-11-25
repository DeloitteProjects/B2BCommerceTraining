/**
 * Created by aketa on 10/21/2021.
 */

public with sharing class querySelector {
    @AuraEnabled(Cacheable=true)
public static Integer getQuestionnares(Id webId){
        AggregateResult[] groupAggregate=  [
            SELECT count(id)CountId FROM Questionare__c WHERE Webinar__c = :webId
    ];
        return (Integer) groupAggregate[0].get('CountId');
}
    @AuraEnabled(Cacheable=true)
    public static Id getUserid(Id webId){
        Questionare__c questionare= [Select CreatedById from Questionare__c WHERE Webinar__c=: webId ORDER BY Score__c DESC limit 1];
        return questionare.CreatedById;
    }
    @AuraEnabled
    public static List<String> getPicklistTypeValue(){
       List <String> picklistType=new List<String>();
        Schema.DescribeFieldResult fieldResult=Webinar__c.Type__c.getDescribe();
        List<PicklistEntry> picklistEntries=fieldResult.getPicklistValues();
        for(PicklistEntry pick:picklistEntries){
            picklistType.add(pick.getLabel());
        }
     return picklistType;
    }
    @AuraEnabled
    public static List<String> getPicklistStatusValue(){
        List <String> picklistStatus=new List<String>();
        Schema.DescribeFieldResult fieldResult=Webinar__c.Status__c.getDescribe();
        List<PicklistEntry> picklistEntries=fieldResult.getPicklistValues();
        for(PicklistEntry pick:picklistEntries){
            picklistStatus.add(pick.getLabel());
        }
        return picklistStatus;
    }
    @AuraEnabled
    public static List<Webinar__c> getAllWebinar(){
        return [SELECT Name,Id,Cost__c,Status__c,Type__c FROM Webinar__c];
    }
    @AuraEnabled
    public static List<Webinar__c> getAllWebinars(List<String> labels, List<List<String>> attributes){
      String query='SELECT Name,Id,Cost__c';
        for(String key:labels){
            query+=','+key;
        }
System.debug(labels);
        System.debug(attributes);
        query+=' FROM Webinar__c WHERE ';
        for(String key: labels){
            if(!attributes.get(labels.indexOf((key))).isEmpty()){
                System.debug(attributes.get(labels.indexOf((key))));
                query+=key+' IN '+valueModifier(attributes.get(labels.indexOf(key)));
                query+=' AND ';
            }
        }
        query=query.substring(0,query.length()-5);
       System.debug(query);
       return (List<Webinar__c>) (Database.query(query));

        }

    private static List<String> valueModifier(List<String> attr){
        List<String> attrMod=new List<String>();
        for(String attrString:attr)
        {
            attrString=  '\''+ attrString + '\'';
            attrMod.add(attrString);
        }
       return attrMod;

    }


        /*if(!types.isEmpty() && !statuses.isEmpty()) {
            return [SELECT Name,Id,Cost__c,Status__c,Type__c from Webinar__c where Status__c in :statuses AND Type__c in :types];
        } else if(!statuses.isEmpty()){
            return [SELECT Name,Id,Cost__c,Status__c,Type__c from Webinar__c where  Status__c in: statuses];
        }else if(!types.isEmpty()){
            return [SELECT Name,Id,Cost__c,Status__c,Type__c from Webinar__c where Type__c in: types];

        }
        return [SELECT Name,Id,Cost__c,Status__c,Type__c FROM Webinar__c];*/

    }