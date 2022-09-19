/**
 * Created by hyunsoo.song@daeunextier.com on 2022-09-15.
 */

({
    fnInit : function(component, event, helper) {
            console.log('classes', component.get("v.classes"));
            helper.getInitData(component);
    },

    handleChange : function(component, event, helper) {
        helper.changeClass(component, event);
    }
});