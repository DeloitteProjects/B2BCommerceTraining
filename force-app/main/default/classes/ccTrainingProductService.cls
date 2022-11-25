/**
 * Created by aketa on 10/22/2022.
 */

global with sharing class ccTrainingProductService extends ccrz.ccServiceProduct {

    global virtual override Map<String, Object> getFieldsMap(Map<String, Object> inputData)
    {
        System.debug('-----ccServiceProduct:getFieldsMap------');
        inputData = super.getFieldsMap(inputData);
        String objectFields = (String)inputData.get(ccrz.ccService.OBJECTFIELDS);
        objectFields += ', Brand__c';
        return new Map<String, Object>{ccrz.ccService.OBJECTFIELDS => objectFields};
    }
}