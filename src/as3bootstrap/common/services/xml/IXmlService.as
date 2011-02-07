package as3bootstrap.common.services.xml
{
	import as3bootstrap.common.services.IService;
	
	/**
	 * Interface for XML services
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 *
	 * @author krisrange
	 */
	public interface IXmlService 
		extends IService
	{
		/**
		 * The loaded XML data from the service
		 * 
		 * @return XML 
		 */		
		function get data():XML;
	}
}