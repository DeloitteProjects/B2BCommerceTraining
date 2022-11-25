/**
 * Created by aketa on 11/3/2022.
 */

global with sharing class CardItemCreatorLogic extends ccrz.ccLogicCartAddTo{

    global override Map<String, Object> process(Map<String, Object> inputData){
        System.debug('Process: '+inputData.keySet());
        System.debug('values: '+inputData.values());
        return super.process(inputData);
    }

}