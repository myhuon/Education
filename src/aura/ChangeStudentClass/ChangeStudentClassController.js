/**
 * Created by hyunsoo.song@daeunextier.com on 2022-09-15.
 */

({
    fnInit : function(component, event, helper) {
            console.log('classes', component.get("v.classes"));
            helper.getInitData(component);
    },

/*    selectItem : function(component, event, helper) {
        helper.selectItem(component, event);
    },*/

    handleChange : function(component, event, helper) {
        var result = confirm('학급을 정말 이동하시겠습니까?');
        if(result){
            helper.changeClass(component, event);
        }
    },

    fnCancel : function(component, event, helper){
            //취소(창닫기)
            $A.get("e.force:closeQuickAction").fire();
    }
});