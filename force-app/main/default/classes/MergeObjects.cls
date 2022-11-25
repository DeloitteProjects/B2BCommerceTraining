/**
 * Created by aketa on 10/13/2021.
 */

public with sharing class MergeObjects{

public Account mergeObjects(){
    Account acc1=[SELECT id,name,Description,NumberOfEmployees from Account Where name='Ajet' LIMIT 1];
    Account acc2=[SELECT id,name,Description,NumberOfEmployees,AccountNumber from Account WHERE name='Deloitte' LIMIT 1];
    Map<String,Object> acc1Map= acc1.getPopulatedFieldsAsMap();
    Map<String,Object> acc2Map=acc2.getPopulatedFieldsAsMap();

    for(String key: acc2Map.keySet()){
          if(!acc1Map.containsKey(key)){
              acc1.put(key,acc2Map.get(key));
          }


    }
    System.debug('something is fucking here stop here:' +acc1.Id +' '+acc1.Name );
    Database.insert(acc1,false);
    return acc1;
}


}