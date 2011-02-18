package as3bootstrap.common.model
{
	import flash.text.StyleSheet;

	/**
	 * IStylesheetModel
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange 
	 */
	public interface IBootstrapStylesheetModel
		extends IBootstrapModel
	{
		/**
		 * Load the config data
		 * 
		 * @param url URL request
		 */		
		function load( $data : XMLList ):void;
		
		/**
		 * All stylehseet service data merged into a signular value object.
		 * 
		 * @return StyleSheet 
		 */		
		function get stylesheets():StyleSheet;
	}
}