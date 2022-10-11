/**
 * @description       : 
 *                      
 * @author            : hyunsoo.song@daeunextier.com
 * @group             :
 * @last modified on  : 2022-10-11
 * @last modified by  : hyunsoo.song@daeunextier.com
 * Modifications Log
 * Ver     Date             Author               Modification
 * 1.0   2022-10-11   hyunsoo.song@daeunextier.com   Initial Version
 */

// Datebase.Stateful -> 인스턴스 멤버 변수 트랜잭션 간 값 유지
// Database.AllowsCallouts -> Http / WebService 허용
public with sharing class ContactDelayEmail_ba implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful {

    public Database.QueryLocator start(Database.BatchableContext bc) {

        String query;
        query = 'SELECT Id, Name, Email';
        query += 'FROM Contact';
        query += 'WHERE CreatedDate < ' + Datetime.now().addDays(-3);   // 이거 안됨

        DateTime createdDate = Datetime.now().addDays(-3);
        List<Contact> listContact = [
                SELECT Id, Name, Email
                FROM Contact
                WHERE CreatedDate <: createdDate
        ];
        System.debug('listContact : ' + listContact);

        return Database.getQueryLocator([
                SELECT Id, Name, Email
                FROM Contact
                WHERE CreatedDate <: createdDate
        ]);
    }

    public void execute(Database.BatchableContext bc, List<Contact> listContact) {
        List<Messaging.SingleEmailMessage> listMails = new List<Messaging.SingleEmailMessage>();
        List<String> listAddress = new List<String>();
        for(Contact obj : listContact) {
            listAddress.add(obj.Email);
        }

        if(!listAddress.isEmpty()){
            List<Contact> listUpdate = new List<Contact>();
            for(Contact obj : listContact) {
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(listAddress);
                mail.setSubject('[SFDC] ' + obj.Name + '님 안녕하세요.');
                mail.setHtmlBody('<p>배치 클래스 테스트입니다.<p></br><h1>TEST</h1>');
                listMails.add(mail);

                obj.isSendEmail__c = true;
                listUpdate.add(obj);
            }

            if(!listMails.isEmpty()){
                Messaging.sendEmail(listMails);
                update listUpdate;
            }
        }

    }

    public void finish(Database.BatchableContext bc) {
    }

}