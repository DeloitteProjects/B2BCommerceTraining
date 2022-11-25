/**
 * Created by aketa on 10/23/2022.
 */

global with sharing class RemoteActionClass {

    @RemoteAction
    global static ccrz.cc_RemoteActionResult getAllEquipment(
            final ccrz.cc_RemoteActionContext ctx
    ) {
        ccrz.cc_CallContext.initRemoteContext(ctx);
        ccrz.cc_RemoteActionResult res = new ccrz.cc_RemoteActionResult();
        res.success = false;
        res.inputContext = ctx;

        try {
            res.data = SEL_Equipment.getAllEquipments();
            res.success = true;
        } catch (Exception e) {
            ccrz.ccLog.log(e.getMessage() + ' ' + e.getStackTraceString());
            res.data = e.getMessage() + ' ' + e.getStackTraceString();

        } finally {

            ccrz.ccLog.log(System.LoggingLevel.INFO, 'M:X', 'getAllEquipment');
            ccrz.ccLog.close(res);
        }

        return res;
    }

    @RemoteAction
    global static ccrz.cc_RemoteActionResult getEquipment(
            final ccrz.cc_RemoteActionContext ctx, String equipmentId
    ) {
        ccrz.cc_CallContext.initRemoteContext(ctx);
        ccrz.cc_RemoteActionResult res = new ccrz.cc_RemoteActionResult();
        res.success = false;
        res.inputContext = ctx;

        try {
            res.data = SEL_Equipment.getEquipment(equipmentId);
            res.success = true;
        } catch (Exception e) {
            ccrz.ccLog.log(e.getMessage() + ' ' + e.getStackTraceString());
            res.data = e.getMessage() + ' ' + e.getStackTraceString();

        } finally {

            ccrz.ccLog.log(System.LoggingLevel.INFO, 'M:X', 'getEquipment');
            ccrz.ccLog.close(res);
        }

        return res;
    }

}