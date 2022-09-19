/**
 * @description       : 
 *                      
 * @author            : hyunsoo.song@daeunextier.com
 * @group             :
 * @last modified on  : 2022-09-14
 * @last modified by  : hyunsoo.song@daeunextier.com
 * Modifications Log
 * Ver     Date             Author               Modification
 * 1.0   2022-09-14   hyunsoo.song@daeunextier.com   Initial Version
 */
trigger ClassTrigger on Class__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    if(Trigger.isBefore) {
        if(Trigger.isInsert) {
            for(Class__c obj : Trigger.new){
                if(obj.Grade__c != null && obj.ClassNumber__c != null){
                    obj.Name = Date.today().year() + '_' + obj.Grade__c + '_' + obj.ClassNumber__c;
                }
            }
        }
    }
}