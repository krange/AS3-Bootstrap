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
		 * Signal which is dispatched when the model has loaded 
		 */
		function get loaded():ISignalOwner;
		
		/**
		 * Signal which is dispatched when the model has errored
		 */
		function get errored():ISignalOwner;
	}
}