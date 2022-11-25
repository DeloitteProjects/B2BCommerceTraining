/**
 * Created by aketa on 11/9/2022.
 */

global with sharing class ccEXT_hk_UserInterface extends ccrz.cc_hk_UserInterface.v004{

    global override Map<String, Object> headContent(Map<String, Object> inpData) {
        System.debug('Input Data: ');
        System.debug(inpData);
        String headContent = String.valueOf(inpData.get(ccrz.cc_hk_UserInterface.HEAD_CONTENT));
        System.debug(headContent);
        Map<String,Object> localizedHeadContent = super.headContent(inpData);
        ccrz.ccLog.log(System.LoggingLevel.DEBUG, '[DEVELOPER BE]', 'ccEXT_hk_UserInterface BEFORE>> ' + localizedHeadContent);

        System.debug(localizedHeadContent);
        return localizedHeadContent;
    }

    global override String canonicalUrlInclude() {
        String localizedCanonicalUrlInclude =  super.canonicalUrlInclude();
        ccrz.ccLog.log(System.LoggingLevel.DEBUG, '[DEVELOPER BE]', 'localizedCanonicalurlInclude BEFORE>> ' + localizedCanonicalUrlInclude);
        localizedCanonicalUrlInclude += 'something';
        ccrz.ccLog.log(System.LoggingLevel.DEBUG, '[DEVELOPER BE]', 'localizedCanonicalurlInclude AFTER>> ' + localizedCanonicalUrlInclude);

        return localizedCanonicalUrlInclude;
    }
}