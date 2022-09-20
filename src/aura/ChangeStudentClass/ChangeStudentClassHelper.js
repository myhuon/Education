/**
 * Created by hyunsoo.song@daeunextier.com on 2022-09-15.
 */

({
    getInitData : function(component) {
            // apexController.함수명 으로 데이터 가져옴
            var action = component.get("c.getInitData");

            action.setParams({
                // component에서 name이 classes인 aura:attribute 값을 가져와서 apexController로 넘겨줌
                classes : component.get("v.classes")
            });
            action.setCallback(this, function(response) {
                var state = response.getState();
                if(state === "SUCCESS") {
                    var returnValue = response.getReturnValue();
                    console.log(returnValue);
                    // 이거는 Controller를 통해 Component로 넘겨주려고 셋팅
                    component.set("v.classes", returnValue);
                } else if(state === "ERROR") {
                    var errors = response.getError();
                    if(errors) {
                        //에러가 났을경우는 주로 ShowToast 함수를 이용하여 토스트 메시지를 띄움
                    } else {

                    }
                }
            });
            $A.enqueueAction(action);
    },

    selectItem : function(component, event) {
        component.set("v.selectClassCB", event.getParam("value"));
    },

    changeClass : function(component, event) {
             // apexController.함수명 으로 데이터 가져옴
             var action = component.get("c.changeClass");

             action.setParams({
                // component에서 name이 classes인 aura:attribute 값을 가져와서 apexController로 넘겨줌
                className : component.get("v.selectClassCB"),
                recordId : component.get("v.recordId")
             });
             action.setCallback(this, function(response) {
                var state = response.getState();
                 if(state === "SUCCESS") {
                     var returnValue = response.getReturnValue();
                     console.log(returnValue);

                     if(returnValue == false){
                         this.showToast("Error", "현재 학년과 같은 학년을 선택해주세요.");
                     }
                     else{
                         this.showToast("Success", "이동 성공.");
                     }
                     var toastEvent = $A.get("e.force:showToast");
                     toastEvent.setParams({
                        title : 'Success',
                        message: '학급 이동 성공',
                        type: 'success'
                     });
                     toastEvent.fire();
                 } else if(state === "ERROR") {
                      var errors = response.getError();
                      console.log(errors);
                       if(errors) {
                           //에러가 났을경우는 주로 ShowToast 함수를 이용하여 토스트 메시지를 띄움
                           /*var toastEvent = $A.get("e.force:showToast");
                           toastEvent.setParams({
                                title : 'Error',
                                message: '현재 학년과 같은 학년을 선택해주세요.',
                                type: 'error'
                           });
                           toastEvent.fire();*/
                           this.showToast("Error", "현재 학년과 같은 학년을 선택해주세요.");
                       } else {

                       }
                 }
             });
             $A.enqueueAction(action);
    },

    showToast : function(type, message) {
        var evt = $A.get("e.force:showToast");
        evt.setParams({
            key : "info_alt"
            , type : type
            , message : message
        });
        evt.fire();
    }
});