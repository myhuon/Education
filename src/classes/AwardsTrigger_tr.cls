/**
 * @description       : 수상경력 Record가 추가되거나, 수상경력의 수상일자(AwardDate__c) 가 변경될 때, 관계된 학생의 최근수상일자와 비교하여 최근수상일자를 업데이트 해준다.
 *                      
 * @author            : hyunsoo.song@daeunextier.com
 * @group             :
 * @last modified on  : 2022-09-16
 * @last modified by  : hyunsoo.song@daeunextier.com
 * Modifications Log
 * Ver     Date             Author               Modification
 * 1.0   2022-09-16   hyunsoo.song@daeunextier.com   Initial Version
 */
public with sharing class AwardsTrigger_tr extends TriggerHandler{
    private List<Awards__c> listNew {get; set;}
    private List<Awards__c> listOld {get; set;}
    private Map<Id, Awards__c> mapNew {get; set;}
    private Map<Id, Awards__c> mapOld {get; set;}

    public AwardsTrigger_tr(){
        listNew = (List<Awards__c>)Trigger.new;
        listOld = (List<Awards__c>)Trigger.old;
        mapNew = (Map<Id,Awards__c>)Trigger.newMap;
        mapOld = (Map<Id,Awards__c>)Trigger.oldMap;
    }

    public override void afterInsert(){
        ChangeAwardDateAfterInsert();
    }

    public override void afterUpdate(){
        ChangeAwardDateAfterUpdate();
    }

    public override void afterDelete(){
        ChangeAwardDateAfterDelete();
    }

    private void ChangeAwardDateAfterInsert() {
        Map<Id, Date> mapRecentDate = new Map<Id, Date>();
        List<Contact> listUpdate = new List<Contact>();

        for(Awards__c obj : listNew) {
            if(obj.AwardDate__c != null && (mapRecentDate.isEmpty() || mapRecentDate.get(obj.contact__c) < obj.AwardDate__c)) {
                mapRecentDate.put(obj.contact__c, obj.AwardDate__c);
            }
        }

        if(!mapRecentDate.isEmpty()) {
            for(Contact objContact : [SELECT RecentAwardDate__c FROM Contact WHERE Id =: mapRecentDate.keySet()]){
                // 학생의 수상 경력이 없거나 기존의 학생의 '최근수상경력(RecentAwardDate)'보다 최신일 경우 update
                if(objContact.RecentAwardDate__c == null || objContact.RecentAwardDate__c < mapRecentDate.get(objContact.Id)) {
                    objContact.RecentAwardDate__c = mapRecentDate.get(objContact.Id);
                    listUpdate.add(objContact);
                }
            }

            if (!listUpdate.isEmpty()) {
                update listUpdate;
            }
        }
    }

    private void ChangeAwardDateAfterUpdate() {
        Map<Id, Date> mapRecentDate = new Map<Id, Date>();
        List<Contact> listUpdate = new List<Contact>();

        for(Awards__c obj : listNew) {
            // 수상 경력이 변경되었을 때만 비교
            if(mapOld.get(obj.Id).AwardDate__c != obj.AwardDate__c && obj.AwardDate__c != null
                    && (mapRecentDate.isEmpty() || mapRecentDate.get(obj.contact__c) < obj.AwardDate__c)) {
                mapRecentDate.put(obj.contact__c, obj.AwardDate__c);
            }
        }

        if(!mapRecentDate.isEmpty()) {
            for(Contact objContact : [SELECT RecentAwardDate__c FROM Contact WHERE Id =: mapRecentDate.keySet()]){
                // 관련 학생의 '최근수상경력(RecentAwardDate)'보다 최신일 경우 update
                if(objContact.RecentAwardDate__c < mapRecentDate.get(objContact.Id)) {
                    objContact.RecentAwardDate__c = mapRecentDate.get(objContact.Id);
                    listUpdate.add(objContact);
                }
            }

            if (!listUpdate.isEmpty()) {
                update listUpdate;
            }
        }
    }

    private void ChangeAwardDateAfterDelete() {
        Map<Id, Id> mapIds = new Map<Id, Id>();
        Map<Id, Date> mapDate = new Map<Id, Date>();
        List<Contact> listUpdate = new List<Contact>();

        for(Awards__c obj : listOld) {
            // 수상 경력이 변경되었을 때만 비교 && 삭제 된 레코드들 중 같은 학생인 경우 가장 최신의 수상경력인 객체를 저장
            if(obj.AwardDate__c != null && obj.AwardDate__c != null
                    && (mapIds.isEmpty() || mapDate.get(obj.contact__c) < obj.AwardDate__c)) {
                mapDate.put(obj.contact__c, obj.AwardDate__c);
                mapIds.put(obj.contact__c, obj.Id);
            }
        }

        if(!mapIds.isEmpty()) {
            Map<Id, Date> mapRecentDate = new Map<Id, Date>();
            for(Awards__c obj : [SELECT AwardDate__c, contact__c, contact__r.RecentAwardDate__c FROM Awards__c WHERE contact__c =: mapIds.keySet()]){
                // 관련 학생의 '최근수상경력(RecentAwardDate)'이였던 수상경력이 삭제된거면 가장 최신의 수상경력으로 학생의 '최근수상경력(RecentAwardDate)' update
                if(obj.contact__r.RecentAwardDate__c == mapOld.get(mapIds.get(obj.contact__c)).AwardDate__c
                        && (mapRecentDate.get(obj.contact__c) == null || mapRecentDate.get(obj.contact__c) < obj.AwardDate__c)){
                    mapRecentDate.put(obj.contact__c, obj.AwardDate__c);
                }
            }

            for(Contact objContact : [SELECT RecentAwardDate__c FROM Contact WHERE Id =: mapRecentDate.keySet()]){
                objContact.RecentAwardDate__c = mapRecentDate.get(objContact.Id);
                listUpdate.add(objContact);
            }

            if (!listUpdate.isEmpty()) {
                update listUpdate;
            }
        }
    }
}