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
global class ContactDelayEmail_sc implements Schedulable{
    global void execute(SchedulableContext sc) {
        ContactDelayEmail_ba ba = new ContactDelayEmail_ba();
        Database.executeBatch(ba, 100);
    }
}