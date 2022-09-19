@isTest
public class slack_tst_Property {
	@isTest 
	static void testTrigger() {
		Property__c obj0 = new Property__c(
			Street_Address__c = 's'
		);
		insert obj0;
	}
}