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
        List<Contact> listContact = new List<Contact>();
        for(Integer i=0; i<200; i++){
            Contact obj = new Contact(LastName = 'Batch' + i);
            listContact.add(obj);
        }

        insert listContact;

        Test.startTest();
        /*ContactDelayEmail_ba ba = new ContactDelayEmail_ba();
        Database.executeBatch(ba, 100);*/

        String Cron_exp = '* * * * * *';
        System.schedule('scheduledBatchClass_test', Cron_exp, new ContactDelayEmail_sc());

        Test.stopTest();

    }
}