@isTest
public class ParkLocatorTest {
	@isTest static void testCallout() {              
        // This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        // Call the method that invokes a callout
        String arg0 = 'arg0';
        String[] result = ParkLocator.country(arg0);    
    }
}