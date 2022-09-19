/************************************************************************************
 * Description :
 *
 * Ver      Date           Author          Modification
 * ===================================================================================
   1.0      2022-09-06     yr.lee          Create
*************************************************************************************/

public with sharing class PrintStudentListController2 {
    public String recordId { get; set; }
    public List<List<Contact>>  doubleListContact { get; set; }

    public PrintStudentListController2() {
        //url속 파라미터를 가져오는 코드
        recordId = ApexPages.currentPage().GetParameters().get('recordId');
        //Contact 조회쿼리
        List<Contact> listContact = [
                SELECT LastName, Birthdate
                FROM Contact
                WHERE Class__c = :recordId
        ];

        doubleListContact = new List<List<Contact>>();
        List<Contact> listTmp = new List<Contact>();
        Integer i = 1;
        for(Contact obj : listContact) {
            listTmp.add(obj);
            if(Math.mod(i, 30) == 0) {
                doubleListContact.add(listTmp);
                listTmp = new List<Contact>();
            }
            i++;

        }

        if(Math.mod(i, 30) != 1) {
            doubleListContact.add(listTmp);
        }
    }
}