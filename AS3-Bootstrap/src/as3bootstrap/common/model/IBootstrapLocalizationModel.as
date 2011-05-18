package as3bootstrap.common.model
{
	import as3bootstrap.common.model.vo.ILocalization;

	/**
	 * ILocalizationModel
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange 
	 */
	public interface IBootstrapLocalizationModel
		extends IBootstrapModel
	{
		/**
		 * Load the config data
		 * 
		 * @param url URL request
		 */		
		function load( data:XMLList ):void;
		
		/**
		 * Retrieves a singular localization value object from the specified
		 * localization service. Returns null if no data is found.
		 *  
		 * @param id ID of the XML service node
		 * @return LocalizationVO
		 */		
		function getLocalizationById( id:String ):ILocalization;
		
		/**
		 * All localization services data merged into a signular value object.
		 * 
		 * @return LocalizationVO 
		 */		
		function get localizations():ILocalization
	}
}