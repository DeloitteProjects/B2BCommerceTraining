/**
 * Created by aketa on 11/3/2022.
 */

global with sharing class ccEXTLogicCartSave extends ccrz.ccLogicCartSave {

    global override Map<String, Object> updateBeforeSave(Map<String, Object> inputData) {
        System.debug(inputData);
        System.debug('I AM HERE!');
        return super.updateBeforeSave(inputData);
    }


}