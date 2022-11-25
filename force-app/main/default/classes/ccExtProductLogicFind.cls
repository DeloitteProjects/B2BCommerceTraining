/**
 * Created by aketa on 11/4/2022.
 */

global with sharing class ccExtProductLogicFind extends ccrz.ccLogicProductFind{

    global override Map<String, Object> process(Map<String, Object> inputData){
        System.debug('Process called!');
        System.debug(inputData);
        return super.process(inputData);
    }

    global override Map<String, Object> processProducts(Map<String, Object> inputData) {
        System.debug('Process Products called!');
        System.debug(inputData);
        return super.processProducts(inputData);
    }
}