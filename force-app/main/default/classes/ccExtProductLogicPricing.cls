/**
 * Created by aketa on 11/4/2022.
 */

global with sharing class ccExtProductLogicPricing extends ccrz.ccLogicProductPricing{

    global override Map<String, Object> process(Map<String, Object> inputData) {
        Map<String, Object> localizedInputData = super.process(inputData);
        System.debug('---------Process-----------');
        List<Map<String, Object>> data = (List<Map<String, Object>>) localizedInputData.get(ccrz.ccAPIProduct.PRODUCTLIST);
        System.debug(data[0].get('brand'));
        System.debug(data[0].get('shortDesc'));
        data[0].put('brand', 'New Brand');
        localizedInputData.put(ccrz.ccAPIProduct.PRODUCTLIST, data);
        return localizedInputData;
    }

    global override Map<String, Object> processInputData(Map<String, Object> inputData){
        Map<String, Object> localizedInputData = super.processInputData(inputData);
        System.debug('-------Process Input Data-------');
        return localizedInputData;
    }

    global override Map<String, Object> prepReturnData(Map<String, Object> inputData) {
        System.debug('--------Prep Return Data---------');
        System.debug(inputData);
        Map<String, Object> localizedInputData = super.prepReturnData(inputData);
        List<Map<String, Object>> data = (List<Map<String, Object>>) localizedInputData.get(ccrz.ccAPIProduct.PRODUCTLIST);
        System.debug(data[0].get('brand'));
        System.debug(data[0].get('shortDesc'));

        return localizedInputData;
    }
}