package as3bootstrap.common.services
{
	import as3bootstrap.common.progress.IProgress;
	import as3bootstrap.common.progress.Progress;
	
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	
	import org.osflash.signals.ISignalOwner;
	import org.osflash.signals.Signal;
	
	/**
	 * Abstract class for all services. Provides trackable 
	 * progress functionality.
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange 
	 */
	public class AbstractService 
		extends EventDispatcher
		implements IService
	{
		/**
		 * Progress tracker 
		 */		
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
		 * @param progress <code>IProgress</code> instance 
		 */		
		public function AbstractService( progress:IProgress = null )
		{
			// If no instance was passed in, initialize a new one
			_progress = progress || new Progress();
			super(null);
			init();
		}
		
		/**
		 * Load an XML resource from a <code>String</code> URL
		 * 
		 * @param url String representation of the URL
		 */
		public function loadWithUrl( url:String ):void
		{
			// Create our request and load it!
			var request : URLRequest = new URLRequest( url );
			loadWithUrlRequest( request );
		}
		
		/**
		 * Load an XML resource from an <code>URLRequest</code>
		 * 
		 * @param request URLRequest to load 
		 */		
		public function loadWithUrlRequest( request:URLRequest ):void
		{
			// Override
		}
		
		/**
		 * Destroy the service
		 */
		public function destroy():void
		{
			// Remove progress
			progress.destroy();
			progress = null;
			
			// Remove signals
			loaded.removeAll();
			errored.removeAll();
		}
		
		//---------------------------------------------------------------------
		//
		//  Protected methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Initialize the service
		 */		
		protected function init():void
		{
			_loaded = getLoadedSignal();
			_errored = getErroredSignal();
		}
		
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
		
		//----------------------------------
		//  Interface
		//----------------------------------
		
		/**
		 * Signal which is dispatched when the service has loaded 
		 */
		public function get loaded():ISignalOwner
		{
			return _loaded;
		}
		
		/**
		 * Signal which is dispatched when the service has errored.
		 */
		public function get errored():ISignalOwner
		{
			return _errored;
		}
		
		/**
		 * Set the <code>IProgress</code> instance
		 * 
		 * @param value <code>IProgress</code> instance to set
		 */
		public function set progress( value:IProgress ):void
		{
			_progress = value;
		}
		
		/**
		 * 
		 * @return IProgress 
		 */
		public function get progress():IProgress
		{
			return _progress;
		}
	}
}