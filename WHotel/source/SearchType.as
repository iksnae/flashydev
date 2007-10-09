// Actionscript 2.0 implementation of Enumerations
class SearchType
{
   public static var None:SearchType = new SearchType();
   public static var ByPriceRange:SearchType = new SearchType();
   public static var ByFloor:SearchType = new SearchType();
   public static var ByUnitType:SearchType = new SearchType();
   public static var ByUnitID:SearchType = new SearchType();
   /**
     * Private Constructor cannot be instantiated
     */
   private function SearchType() {}
}