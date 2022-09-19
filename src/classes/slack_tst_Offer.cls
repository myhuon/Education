@isTest
public class slack_tst_Offer {
	@isTest 
	static void testTrigger() {
		Property__c obj1 = new Property__c(
			Street_Address__c = 's'
		);
		insert obj1;

		Offer__c obj0 = new Offer__c(
			Property__c = obj1.Id
		);
		insert obj0;
	}
}