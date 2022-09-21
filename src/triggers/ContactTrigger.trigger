/**
 * @description       : 
 *                      
 * @author            : hyunsoo.song@daeunextier.com
 * @group             :
 * @last modified on  : 2022-09-16
 * @last modified by  : hyunsoo.song@daeunextier.com
 * Modifications Log
 * Ver     Date             Author               Modification
 * 1.0   2022-09-16   hyunsoo.song@daeunextier.com   Initial Version
 */
trigger ContactTrigger on Contact (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    /*if(Trigger.isBefore) {
        if (Trigger.isUpdate) {
            //Before Update Trigger Start..
            Map<Contact, Id> mapContact = new Map<Contact, Id>();
            Set<Id> setId = new Set<Id>();
            for(Contact obj : Trigger.new){
                if(obj.Class__c != null && Trigger.oldMap.get(obj.Id).Class__c != obj.Class__c){
                    setId.add(obj.Class__c);
                    mapContact.put(obj, Trigger.oldMap.get(obj.Id).Class__c);
                }
            }

            if(!mapContact.isEmpty()){
                Map<Id, Class__c> mapClass = new Map<Id, Class__c> ([
                        SELECT Id, Grade__c
                        FROM Class__c
                        WHERE Id =: mapContact.values() OR Id =: setId
                ]);

                for(Contact obj : mapContact.keySet()){
                    if(mapClass.get(obj.Class__c).Grade__c != mapClass.get(mapContact.get(obj)).Grade__c) {
                        // 에러를 ChangeStudentClassController에 전달 -> Helper에 전달해서 Error를 표출함
                        // 근데 에러메세지는 Helper에 있는 Toast로 UI에 display되고 아래의 addError 메세지는 console에 뜸
                        obj.addError('같은 학년을 선택해주세요.');
                    }
                }
            }
        }
    }*/
}