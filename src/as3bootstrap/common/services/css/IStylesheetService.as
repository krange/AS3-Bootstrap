package as3bootstrap.common.services.css
{
	import as3bootstrap.common.services.IService;
	
	import flash.text.StyleSheet;

	/**
	 * IStylesheetService
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange 
	 */
	public interface IStylesheetService
		extends IService
	{
		/**
		 * The loaded stylesheet data from the service
		 * 
		 * @return StyleSheet 
		 */		
		function get data():StyleSheet;
	}
}