package as3bootstrap.common.model
{
	import as3bootstrap.common.progress.IProgress;
	import as3bootstrap.common.services.xml.IXmlService;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import org.osflash.signals.ISignalOwner;
	import org.osflash.signals.Signal;
	
	/**
	 * BootstrapModel
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange 
	 */
	public class BootstrapModel 
		extends EventDispatcher
	{
		private var _progress : IProgress;
		
		//----------------------------------
		//  Signals
		//----------------------------------
		
		private var _loaded : ISignalOwner;
		private var _errored : ISignalOwner;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 * 
		 * @param $progress <code>IProgress</code> instance
		 */
		public function BootstrapModel( $progress : IProgress )
		{
			_progress = $progress;
			super(null);
			init();
		}
		
		//----------------------------------
		//  Override
		//----------------------------------
		
		//---------------------------------------------------------------------
		//
		//  Protected methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * @private 
		 * Initialize the model
		 */		
		protected function init():void
		{
			_loaded = getLoadedSignal();
			_errored = getErroredSignal();
		}
		
		//----------------------------------
		//  Instantations
		//----------------------------------
		
		/**
		 * 
		 * @return <code>ISignalOwner</code> 
		 */		
		protected function getLoadedSignal():ISignalOwner
		{
			return new Signal();
		}
		
		/**
		 * 
		 * @return <code>ISignalOwner</code> 
		 */		
		protected function getErroredSignal():ISignalOwner
		{
			return new Signal();
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Signal which is dispatched when the model has loaded 
		 */
		public function get loaded():ISignalOwner
		{
			return _loaded;
		}
		
		/**
		 * Signal which is dispatched when the model has errored
		 */
		public function get errored():ISignalOwner
		{
			return _errored;
		}
		
		//----------------------------------
		//  ITrackableResource
		//----------------------------------
		
		/**
		 * Get the <code>IProgress</code> instance
		 * 
		 * @return <code>IProgress</code>
		 */
		public function get progress():IProgress
		{
			return _progress;
		}
		
		/**
		 * Set the <code>IProgress</code> instance
		 * 
		 * @param value <code>IProgress</code> instance to set
		 */	
		public function set progress($value:IProgress):void
		{
			_progress = $value;
		}
	}
}