package as3bootstrap.common.model
{
	/**
	 * IConfigModel
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange 
	 */
	public interface IBootstrapConfigModel
		extends IBootstrapModel
	{
		/**
		 * Load the config data
		 * 
		 * @param url URL request
		 */		
		function load( url:String ):void;
		
		/**
		 * The loaded XML data from the service
		 * 
		 * @return XML 
		 */
		function get data():XML;
		
		/**
		 * Retrieve all stylesheets associated to bootstrap
		 * 
		 * @return XMLList 
		 */		
		function get stylesheets():XMLList;
		
		/**
		 * Retrieve all localizations associated to bootstrap
		 * 
		 * @return XMLList 
		 */		
		function get localizations():XMLList;
		
		/**
		 * Retrieve all localizations associated to bootstrap
		 * 
		 * @return XMLList 
		 */		
		function get fonts():XMLList;
	}
}