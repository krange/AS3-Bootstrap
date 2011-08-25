package as3bootstrap.common.model
{
	import as3bootstrap.common.progress.ITrackableResource;
	
	import org.osflash.signals.ISignalOwner;

	/**
	 * IBootstrapModel
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange 
	 */
	public interface IBootstrapModel
		extends ITrackableResource
	{
		/**
		 * Destroy the model
		 */		
		function destroy():void;
			
		/**
		 * Signal which is dispatched when the model has loaded 
		 */
		function get loaded():ISignalOwner;
		
		/**
		 * Signal which is dispatched when the model has errored
		 */
		function get errored():ISignalOwner;
		
		/**
		 * The flashvars locale, if available, of the application
		 *  
		 * @return String
		 */		
		function get locale():String;
		function set locale( value:String ):void;
		
		/**
		 * The flashvars lang, if available, of the application
		 *  
		 * @return String
		 */	
		function get lang():String;
		function set lang( value:String ):void;
	}
}