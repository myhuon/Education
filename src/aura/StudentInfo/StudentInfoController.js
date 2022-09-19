/**
 * Created by hyunsoo.song@daeunextier.com on 2022-09-14.
 */

({
    fnInit : function(component, event, helper) {
            console.log('recordId', component.get("v.recordId"));
            helper.getInitData(component);
        }
});