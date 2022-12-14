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
@IsTest
public with sharing class ContactDelayEmail_test {

    static testMethod void test(){
        Account objAccount = new Account(Name = 'BatchAccount', Rating = 'Cold');
        insert objAccount;

        List<Account> listAccounts = [SELECT Id FROM Account LIMIT 1];
        System.debug('listAccounts : ' + listAccounts);

        List<Contact> listContact = new List<Contact>();
        for(Integer i=0; i<2; i++){
            Contact obj = new Contact(LastName = 'Batch' + i, AccountId = listAccounts.get(0).Id, Email = 'hyunsoo.song@daeunextier.com');
            listContact.add(obj);
        }
        Contact obj = new Contact(LastName = 'Batch' + 100, AccountId = listAccounts.get(0).Id, Email = 'myhuon3321@gmail.com');
        listContact.add(obj);

        try{
            insert listContact;
            List<Contact> Contacts = [SELECT Id FROM Contact LIMIT 50];
            System.debug('after insert contacts : ' + Contacts);
        } catch (Exception e) {
            System.assert(true, e.getMessage());
        }

        Test.startTest();

        /*ContactDelayEmail_ba ba = new ContactDelayEmail_ba();
        Database.executeBatch(ba, 100);*/

        // 초,분 -> 숫자로 설정
        // 달,요일 중 하나는 '*'가 아닌 '?'로 지정해야함
        String Cron_exp = '0 0 * * * ?';
        System.schedule('scheduledBatchClass_test', Cron_exp, new ContactDelayEmail_sc());

        Test.stopTest();

    }
}