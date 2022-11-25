/**
 * Created by aketa on 11/10/2022.
 */

global with sharing class ccEXT_cc_hk_Menu extends ccrz.cc_hk_Menu{

    global override Map<String, Object> fetch(Map<String, Object> inputData) {
        System.debug(inputData);

        Map<String, Object> localizedFetch = super.fetch(inputData);
        ccrz.ccLog.log(System.LoggingLevel.DEBUG, '[DEVELOPER BE]', 'ccEXT_cc_hk_Menu.fetch BEFORE>> ' +localizedFetch.keySet());

        List<ccrz.cc_bean_MenuItem> menuItems = (List<ccrz.cc_bean_MenuItem>) localizedFetch.get(ccrz.cc_hk_Menu.PARAM_MENU);
//
        for (ccrz.cc_bean_MenuItem menuItem: menuItems){
            if(menuItem.displayName != null){
                menuItem.displayName += 'New';
            }
        }
        localizedFetch.put(ccrz.cc_hk_Menu.PARAM_MENU, menuItems);
//        ccrz.ccLog.log(((Map<String, Object>)localizedFetch.get('MENU')).keySet());
//        ccrz.ccLog.log(System.LoggingLevel.DEBUG, '[DEVELOPER BE]', 'ccEXT_cc_hk_Menu.fetch BEFORE>> ' + localizedFetch);
//        ((Map<String,Object>) localizedFetch.get('MENU')).put('cc_bean_MenuItem', '[\n' +
//                '      children=null,\n' +
//                '       displayName=NewEquipments,\n' +
//                '       friendlyUrl=null,\n' +
//                '       linkURL=/b2b/ccrz__ccPage?pagekey=practice,\n' +
//                '       mType=URL,\n' +
//                '       menuId=null,\n' +
//                '       openInNewWindow=false,\n' +
//                '       sequence=500,\n' +
//                '       sfid=a0n7Q000000Q9DSQA0,\n' +
//                '       showInMyAccountMenu=false]');
        ccrz.ccLog.log(System.LoggingLevel.DEBUG, '[DEVELOPER BE]', 'ccEXT_cc_hk_Menu.fetch After>> ' + localizedFetch);

        return localizedFetch;
    }
}