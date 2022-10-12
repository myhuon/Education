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
        query += 'WHERE CreatedDate < ' + Datetime.now().addDays(-3);

        DateTime createdDate = Datetime.now(); //.addDays(-3)
        return Database.getQueryLocator([
                SELECT Id, Name, Email
                FROM Contact
                WHERE CreatedDate <: createdDate AND Email IN ('hyunsoo.song@daeunextier.com', 'myhuon3321@gmail.com')
                LIMIT 15
        ]);
    }

    public void execute(Database.BatchableContext bc, List<Contact> listContact) {
        List<Messaging.SingleEmailMessage> listMails = new List<Messaging.SingleEmailMessage>();

        // 1) 같은 이메일 일괄 전송
        /*List<String> listAddress = new List<String>();
        for(Contact obj : listContact) {
            if(obj.Email != null) {
                listAddress.add(obj.Email);
                system.debug('Email Address : ' + obj.Email);
            }
        }*/

        if(!listContact.isEmpty()){
            List<String> listAddress;
            for(Contact obj : listContact) {
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                // 2) 개인의 특성에 맞는 이메일 각각 전송
                listAddress = new List<String>();
                listAddress.add(obj.Email);
                mail.setToAddresses(listAddress);
                mail.setSubject('[SFDC] ' + obj.Name + '님 안녕하세요.');
                mail.setHtmlBody('<p>배치 클래스 테스트입니다.<p></br><h1>TEST</h1>');
                listMails.add(mail);
            }

            if(!listMails.isEmpty()){
                System.debug('email list : ' + listMails);
                Messaging.sendEmail(listMails);
            }
        }

    }

    public void finish(Database.BatchableContext bc) {
    }

}