/**
 * @description       : 
 *                      
 * @author            : hyunsoo.song@daeunextier.com
 * @group             :
 * @last modified on  : 2022-09-16
 * @last modified by  : hyunsoo.song@daeunextier.com
 * Modifications Log
 * Ver     Date             Author               Modification
 * 1.0   2022-09-16   hyunsoo.song@daeunextier.com   Initial Version
 */
trigger AwardsTrigger on Awards__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    new AwardsTrigger_tr().run();
}