package as3bootstrap.common.services.css
{
	import as3bootstrap.common.progress.IProgress;
	import as3bootstrap.common.services.AbstractService;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.StyleSheet;
	
	import org.osflash.signals.ISignalOwner;
	import org.osflash.signals.Signal;
	
	/**
	 * StylesheetService
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange 
	 */
	public class StylesheetService 
		extends AbstractService
		implements IStylesheetService
	{
		private var _loader : URLLoader;
		private var _data : StyleSheet;
		
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
		public function StylesheetService( progress:IProgress=null )
		{
			super( progress );
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
			progress.setAmountLoaded( 0 );
			
			// Add our listeners
			addListeners();
			
			// Load it!
			_loader.load( request );
		}
		
		/**
		 * Add any listeners for this service 
		 */		
		protected function addListeners():void
		{
			_loader.addEventListener( Event.COMPLETE, onLoadComplete, false, 0, true );
			_loader.addEventListener( ProgressEvent.PROGRESS, onLoadProgress, false, 0, true );
			_loader.addEventListener( IOErrorEvent.IO_ERROR, onLoadIOError, false, 0, true );
			_loader.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onLoadSecurityError, false, 0, true );
		}
		
		/**
		 * Remove any listeners for this service 
		 */		
		protected function removeListeners():void
		{	
			_loader.removeEventListener( Event.COMPLETE, onLoadComplete );
			_loader.removeEventListener( ProgressEvent.PROGRESS, onLoadProgress );
			_loader.removeEventListener( IOErrorEvent.IO_ERROR, onLoadIOError );
			_loader.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, onLoadSecurityError );
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
			_data = new StyleSheet();
			super.init();
		}
		
		//----------------------------------
		//  Handlers
		//----------------------------------
		
		/**
		 * @private 
		 * @param event <code>Event.COMPLETE</code>
		 */		
		protected function onLoadComplete( event:Event ):void
		{	
			// Remove listeners
			removeListeners();
			
			// Parse the CSS
			data.parseCSS( loader.data );
			
			// Set the progress to be completed
			progress.setAmountLoaded( 1 );
			
			// Dispatch that the service has loaded
			loaded.dispatch( this );
		}
		
		/**
		 * @private
		 * @param event <code>ProgressEvent.PROGRESS</code> 
		 */		
		protected function onLoadProgress( event:ProgressEvent ):void
		{	
			progress.setAmountLoaded( event.bytesLoaded / event.bytesTotal );
		}
		
		/**
		 * @private 
		 * @param event <code>IOErrorEvent.IO_ERROR</code>
		 */		
		protected function onLoadIOError( event:IOErrorEvent ):void
		{
			removeListeners();
			errored.dispatch( event );
		}
		
		/**
		 * @private 
		 * @param event <code>SecurityErrorEvent.SECURITY_ERROR</code>
		 */
		protected function onLoadSecurityError( event:SecurityErrorEvent ):void
		{
			removeListeners();
			errored.dispatch( event );
		}
		
		//----------------------------------
		//  Override
		//----------------------------------
		
		/**
		 * @inheritDoc
		 */		
		override protected function getLoadedSignal():ISignalOwner
		{
			return new Signal( IStylesheetService );
		}
		
		/**
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
		 * The loaded Stylesheet data from the loaded service
		 * 
		 * @return Stylesheet 
		 */		
		public function get data():StyleSheet
		{
			return _data;
		}
		
		/**
		 * The loaded CSS styles in the raw string format
		 * 
		 * @return String 
		 */		
		public function get css():String
		{
			return loader.data as String;
		}
	}
}