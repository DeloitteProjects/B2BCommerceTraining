/**
 * Created by aketa on 10/22/2022.
 */

global with sharing class ccTrainingContactService extends ccrz.ccServiceContact{

    global virtual override Map<String, Object> getFieldsMap(Map<String, Object> inputData){
        inputData = super.getFieldsMap(inputData);

        String objectFields = (String)inputData.get(ccrz.ccService.OBJECTFIELDS);
        System.debug(objectFields);
        ccrz.ccLog.log(LoggingLevel.INFO, 'Pre objectfields', objectFields);
        objectFields += ', Quota__c';
        System.debug(objectFields);
        ccrz.ccLog.log(LoggingLevel.INFO, 'Post objectfields', objectFields);
        return new Map<String, Object>{ccrz.ccService.OBJECTFIELDS => objectFields};
    }
}