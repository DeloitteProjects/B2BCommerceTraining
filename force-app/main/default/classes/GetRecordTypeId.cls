/**
 * Created by aketa on 4/22/2022.
 */

public class GetRecordTypeId {
    private Map<String,Id> recordIdByName {get; private set;}
    private static GetRecordTypeId instance=null;

    private GetRecordTypeId(){
        recordIdByName = new Map<String,Id>();
     for(RecordTypeInfo recordTypeInfo: Schema.SObjecttype.Account.recordTypeInfos){
        recordIdByName.put(recordTypeInfo.name, recordTypeInfo.recordTypeId);
     }
     }

    public static GetRecordTypeId GetInstance(){
        if(instance == null) {
            instance = new GetRecordTypeId();

        }
        return instance;
    }
    /**
     * @param name
     *
     * @return
     */
    public Id getRecordTypeId(String name)
    {
        return recordIdByName.get(name);
    }

}