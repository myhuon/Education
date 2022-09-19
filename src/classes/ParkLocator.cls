public class ParkLocator {
    public static String[] country(String arg0) {
        ParkService.ParksImplPort park = new ParkService.ParksImplPort();
        return park.byCountry(arg0);
    }
}