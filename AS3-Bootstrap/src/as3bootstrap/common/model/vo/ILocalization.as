package as3bootstrap.common.model.vo
{
	import mx.resources.IResourceBundle;

	/**
	 * Interface for the localization value object
	 *  
	 * @author krisrange
	 */	
	public interface ILocalization
	{
		/**
		 * Add localized data values to the vo. If a previous value has been
		 * defined for a key value, it will be replaced.
		 * 
		 * @param data A XML object containing localized elements to add to 
		 * 			   the VO
		 */ 
		function addLocalizedValues( $data:XML ):void;
		
		/**
		 * Lookup a value by its name
		 * 
		 * @param name 	a name or key to look up a localized value by
		 * @return 		String Value returned, null if nothing was found
		 */ 
		function getLocalizedValue( $name:String ):String;
		
		/**
		 * Factory type method for creating named resource bundles on the fly
		 * from this LocalizationVO instance.
		 * 
		 * @param name	a name for the returned ResourceBundle, such as 
		 * 				"validators".
		 * @return		an <code>IResourceBundle</code>
		 * @throws		an Error if lang or locale is not defined
		 */
		function getResourceBundle( $name:String ):IResourceBundle;
		
		function get lang():String;
		function set lang( value:String ):void;
		
		function get locale():String;
		function set locale( value:String ):void;
	}
}