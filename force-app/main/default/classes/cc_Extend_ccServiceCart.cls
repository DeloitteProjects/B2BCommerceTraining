/**
 * Created by aketa on 10/28/2022.
 */

global with sharing class cc_Extend_ccServiceCart extends ccrz.ccServiceCart{

    public String CART_WRITABLE_FIELDS = ',ValidationStatus__c,AdjustmentAmount__c';

    global override Map<String, Object> getFilterMap(Map<String, Object> inputData) {
        Map<String, Object> localizedFilters = super.getFilterMap(inputData);
        localizedFilters.put('totalAmountSmallerThan', 'AND TotalAmount__c > 1000');
        System.debug(localizedFilters);
        return localizedFilters;
    }

    global override Map<String, Object> getWriteableFieldsMap(Map<String, Object> inputData) {
        Map<String, Object> writeableFieldsMap = super.getWriteableFieldsMap(inputData);

        String writableFields = (String)((Map<String,Object>) writeableFieldsMap.get('baseFieldsMap')).get('sz_s');
        writableFields += CART_WRITABLE_FIELDS;
        ((Map<String, Object>) writeableFieldsMap.get('baseFieldsMap')).put('sz_s', writableFields);
        System.debug(writeableFieldsMap);

        return writeableFieldsMap;
    }

}