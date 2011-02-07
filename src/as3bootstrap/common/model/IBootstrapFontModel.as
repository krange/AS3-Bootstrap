package as3bootstrap.common.model
{

	/**
	 * IBootstrapFontModel
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange 
	 */
	public interface IBootstrapFontModel
		extends IBootstrapModel
	{
		/**
		 * Load the config data
		 * 
		 * @param url URL request
		 */		
		function load( $data : XMLList ):void;
	}
}