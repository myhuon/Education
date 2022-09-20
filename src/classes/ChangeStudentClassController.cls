/**
 * @description       : 
 *                      
 * @author            : hyunsoo.song@daeunextier.com
 * @group             :
 * @last modified on  : 2022-09-15
 * @last modified by  : hyunsoo.song@daeunextier.com
 * Modifications Log
 * Ver     Date             Author               Modification
 * 1.0   2022-09-15   hyunsoo.song@daeunextier.com   Initial Version
 */
public with sharing class ChangeStudentClassController {
    @AuraEnabled
    public static List<Map<String, String>> getInitData(){

        List<Class__c> listClass = [
                SELECT Name
                FROM Class__c
                ORDER BY Grade__c, ClassNumber__c
        ];

        List<Map<String, String>> listReturn = new List<Map<String, String>>();
        if(!listClass.isEmpty()){
            Map<String, String> mapValues = new Map<String, String>();
            /*Set<Class__c> setClass = new Set<Class__c>();
            setClass.addAll(listClass);*/

            for(Class__c obj : listClass){
                if(!mapValues.isEmpty()) mapValues = new Map<String, String>();
                mapValues.put('label', obj.Name);
                mapValues.put('value', obj.Name);
                listReturn.add(mapValues);  // 리스트의 map으로 변경해야함
            }
        }

        return listReturn;
    }

    @AuraEnabled
    public static Boolean changeClass(String className, String recordId){
        List<Contact> listContact = [
                SELECT Class__r.Grade__c
                FROM Contact
                WHERE Id =: recordId
                LIMIT 1
        ];

        List<Class__c> listClass = [
                SELECT Id, Grade__c
                FROM Class__c
                WHERE Name =: className
                LIMIT 1
        ];

        if(listClass[0].Grade__c != listContact[0].Class__r.Grade__c) {
            return false;
        }
        else {

        }

        Boolean isSame = true;
        if(!listContact.isEmpty()){
            List<Contact> listUpdate = new List<Contact>();
            for(Contact obj : listContact){
                if(!listClass.isEmpty()){
                    obj.Class__c = listClass.get(0).Id;
                    listUpdate.add(obj);
                }
            }

            if(!listUpdate.isEmpty()) {
                update listUpdate;
            }
        }

        return isSame;
    }
}