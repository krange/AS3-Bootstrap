package as3bootstrap.common.services
{
	import as3bootstrap.common.progress.ITrackableResource;
	
	import flash.net.URLRequest;
	
	import org.osflash.signals.ISignalOwner;
	
	/**
	 * IService
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange 
	 */
	public interface IService 
		extends ITrackableResource
	{
		/**
		 * Load an XML resource from a <code>String</code> URL
		 * 
		 * @param $url String representation of the URL
		 */
		function loadWithUrl( $url:String ):void;
		
		/**
		 * Load an XML resource from an <code>URLRequest</code>
		 * 
		 * @param $request URLRequest to load 
		 */		
		function loadWithUrlRequest( $request:URLRequest ):void;
		
		/**
		 * Signal which is dispatched when the service has loaded 
		 */
		function get loaded():ISignalOwner;
		
		/**
		 * Signal which is dispatched when the service has errored
		 */
		function get errored():ISignalOwner;
	}
}