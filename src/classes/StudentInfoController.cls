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
public with sharing class StudentInfoController {

    @AuraEnabled
    public static Map<String, String> getInitData(String recordId){

        List<Awards__c> listContact = new List<Awards__c>();
        listContact = [
                SELECT Id, Contact__r.LastName, Contact__r.Class__r.Name
                FROM Awards__c
                WHERE Id = :recordId
        ];

        Map<String, String> mapReturn = new Map<String, String>();
        if(!listContact.isEmpty()){
            mapReturn.put('LastName', listContact[0].Contact__r.LastName);
            mapReturn.put('ClassName', listContact[0].Contact__r.Class__r.Name);
        }

        return mapReturn;

    }
}