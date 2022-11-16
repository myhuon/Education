/**
 * @description       : 
 *                      
 * @author            : hyunsoo.song@daeunextier.com
 * @group             :
 * @last modified on  : 2022-11-16
 * @last modified by  : hyunsoo.song@daeunextier.com
 * Modifications Log
 * Ver     Date             Author               Modification
 * 1.0   2022-11-16   hyunsoo.song@daeunextier.com   Initial Version
 */
public with sharing class CountryCodeHelper {
    public static String getCountryCode(String country) {
        /*Country_Code__mdt countryCode = [
                SELECT Id, MasterLabel, Country_Code__c
                FROM Country_Code__mdt
                WHERE MasterLabel = :country
                LIMIT 1
        ];

        return countryCode.Country_Code__c;*/

        return Country_Code__mdt.getInstance('Canada').Country_Code__c;
    }
}