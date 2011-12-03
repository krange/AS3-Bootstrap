package as3bootstrap.common.services.xml
{
	import as3bootstrap.common.progress.IProgress;
	import as3bootstrap.common.services.AbstractService;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.osflash.signals.ISignalOwner;
	import org.osflash.signals.Signal;

	/**
	 * Service for loading XML files.
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 *
	 * @author krisrange
	 */
	public class XmlService 
		extends AbstractService
		implements IXmlService
	{
		private var _loader : URLLoader;
		private var _data : XML;
		
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
        public function XmlService( progress:IProgress = null )
        {
            super( progress );
            init();
        }

		//----------------------------------
		//  Override
		//----------------------------------
		
		/**
		 * Load an XML resource from an <code>URLRequest</code>
		 * 
		 * @param request URLRequest to load 
		 */		
		override public function loadWithUrlRequest( request:URLRequest ):void
		{
			// Since we are starting a new load request, remove any
			// previous listeners
			removeListeners();
			
			// Reset the progress
			if( progress )
			{
				progress.setAmountLoaded( 0 );
			}
			
			// Add our listeners
			addListeners();
			
			// Load it!
			_loader.load( request );
		}
		
		/**
		 * @inheritDocs
		 */		
		override public function destroy():void
		{
			super.destroy();
			
			removeListeners();
			if( _loader )
			{
				_loader.close();
				_loader = null;
			}
			
			_data = null;
		}
		
        //---------------------------------------------------------------------
        //
        //  Protected methods
        //
        //---------------------------------------------------------------------

		/**
		 * Parse the data result
		 * 
		 * @param xml XML result
		 */
		protected function parse( xml:XML ):void 
		{
			// Set the data object
			_data = xml;
		}
		
		/**
		 * Add any listeners for this service 
		 */		
		protected function addListeners():void
		{
			_loader.addEventListener( Event.COMPLETE, onLoadXmlComplete, false, 0, true );
			_loader.addEventListener( ProgressEvent.PROGRESS, onLoadXmlProgress, false, 0, true );
			_loader.addEventListener( IOErrorEvent.IO_ERROR, onLoadXmlIOError, false, 0, true );
			_loader.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onLoadXmlSecurityError, false, 0, true );
		}
		
		/**
		 * Remove any listeners for this service 
		 */		
		protected function removeListeners():void
		{	
			_loader.removeEventListener( Event.COMPLETE, onLoadXmlComplete );
			_loader.removeEventListener( ProgressEvent.PROGRESS, onLoadXmlProgress );
			_loader.removeEventListener( IOErrorEvent.IO_ERROR, onLoadXmlIOError );
			_loader.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, onLoadXmlSecurityError );
		}
		
		//----------------------------------
		//  Override
		//----------------------------------
		
		/**
		 * @inheritDoc
		 */
		override protected function init():void
		{
			_loader = new URLLoader();
			super.init();
		}

		//----------------------------------
		//  Handlers
		//----------------------------------
		
		/**
		 * @private 
		 * @param event <code>Event.COMPLETE</code>
		 */		
		protected function onLoadXmlComplete( event:Event ):void
		{	
			// Remove listeners
			removeListeners();
			
			// Parse the data
			parse( new XML( loader.data ) );
			
			// Set the progress to be completed
			if( progress )
			{
				progress.setAmountLoaded( 1 );
			}
			
			// Dispatch that the xml has loaded
			loaded.dispatch( this );
		}
		
		/**
		 * @private
		 * @param event <code>ProgressEvent.PROGRESS</code> 
		 */		
		protected function onLoadXmlProgress( event:ProgressEvent ):void
		{
			if( progress )
			{
				progress.setAmountLoaded( event.bytesLoaded / event.bytesTotal );
			}
		}
		
		/**
		 * @private 
		 * @param event <code>IOErrorEvent.IO_ERROR</code>
		 */		
		protected function onLoadXmlIOError( event:IOErrorEvent ):void
		{
			// Remove listeners
			removeListeners();
			
			if( progress )
			{
				progress.setAmountLoaded( 0 );
			}
			
			errored.dispatch( event );
		}
		
		/**
		 * @private 
		 * @param event <code>SecurityErrorEvent.SECURITY_ERROR</code>
		 */
		protected function onLoadXmlSecurityError( event:SecurityErrorEvent ):void
		{
			// Remove listeners
			removeListeners();
			
			if( progress )
			{
				progress.setAmountLoaded( 0 );
			}
			
			errored.dispatch( event );
		}
		
		//----------------------------------
		//  Override
		//----------------------------------
		
		/**
		 * Returns the instance of the signal to use for when the service has
		 * loaded. For this this service, the <code>ISignalOwner</code> 
		 * disptaches with an <code>IXmlService</code> parameter
		 * 
		 * @inheritDoc 
		 */		
		override protected function getLoadedSignal():ISignalOwner
		{
			return new Signal( IXmlService );
		}
		
		/**
		 * Returns the instance of the signal to use for when the service has
		 * errored. For this this service, the <code>ISignalOwner</code> 
		 * disptaches with an <code>Event</code> parameter
		 * 
		 * @inheritDoc
		 */		
		override protected function getErroredSignal():ISignalOwner
		{
			return new Signal( Event );
		}
		
		//---------------------------------------------------------------------
        //
        //  Getter/Setter methods
        //
        //---------------------------------------------------------------------

        /**
         * Loader which loads the resource
         *
         * @return URLLoader Loader instance
         */
        protected function get loader():URLLoader
        {
            return _loader;
        }

        /**
         * @private
         * Set the loader
		 * 
		 * @param value URLLoader instance to set
         */
        protected function set loader( value:URLLoader ):void
        {
            _loader = value;
		}
		
		/**
		 * The loaded XML data from the loaded service
		 * 
		 * @return XML 
		 */		
		public function get data():XML
		{
			return _data;
		}
    }
}