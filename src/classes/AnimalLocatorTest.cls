@isTest
public class AnimalLocatorTest {
	@isTest static  void testGetCallout() {
        // Create the mock response based on a static resource
        AnimalLocatorMock mock = new AnimalLocatorMock();
        Test.setMock(HttpCalloutMock.class, mock);
        
        String result = AnimalLocator.getAnimalNameById(1);
        System.assertNotEquals(null,result, 'The callout returned a null response.');
    }   
}