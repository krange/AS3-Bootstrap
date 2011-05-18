package as3bootstrap.common.services.font
{
	import as3bootstrap.common.progress.IProgress;
	import as3bootstrap.common.services.AbstractService;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.text.Font;
	import flash.utils.getQualifiedClassName;
	
	import org.osflash.signals.ISignalOwner;
	import org.osflash.signals.Signal;
	
	/**
	 * FontService
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange 
	 */
	public class FontService 
		extends AbstractService
		implements IFontService
	{
		private var _loader : Loader;
		
		private var _fontName : String;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 * 
		 * @param progress <code>IProgress</code> instance 
		 * @param fontName Name of the font. This value is optional. If
		 * 					provided, after the font is loaded, it will attempt
		 * 					to register the font. If not, the service assumes 
		 * 					that font registration will be handled by the SWF
		 */		
		public function FontService( progress:IProgress = null, fontName:String = null )
		{
			_fontName = fontName;
			super( progress );
		}
		
		//----------------------------------
		//  Override
		//----------------------------------
		
		/**
		 * @inheritDoc
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
		
		//---------------------------------------------------------------------
		//
		//  Protected methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * @private
		 * Attempt to register the font if a fontName has been provided 
		 */		
		protected function registerFont():void
		{
			// Only register the font if a fontName has been provided
			if( fontName &&
				fontName.length > 0 )
			{
				var appDomain : ApplicationDomain = loader.contentLoaderInfo.applicationDomain;
				
				// Try to grab the class by the name provided. If this method 
				// fails, dispatch an error event
				try
				{
					var FontLibrary : Class = appDomain.getDefinition( fontName ) as Class;
					var className : String = getQualifiedClassName( FontLibrary );
					if( className.indexOf( "::" ) != -1 )
					{
						className = className.substring( className.lastIndexOf( ":" ) + 1, className.length );
					}
					Font.registerFont( FontLibrary[ className ] );
				}
				catch( error:Error )
				{
					trace( "Font class could not be found! Check that a fully qualified class path was provided." );
					// TODO: Dispatch errored signal
				}
			}
		}
		
		/**
		 * Add any listeners for this service 
		 */		
		protected function addListeners():void
		{
			_loader.contentLoaderInfo.addEventListener( Event.COMPLETE, onLoadComplete, false, 0, true );
			_loader.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, onLoadProgress, false, 0, true );
			_loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, onLoadIOError, false, 0, true );
			_loader.contentLoaderInfo.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onLoadSecurityError, false, 0, true );
		}
		
		/**
		 * Remove any listeners for this service 
		 */		
		protected function removeListeners():void
		{	
			_loader.contentLoaderInfo.removeEventListener( Event.COMPLETE, onLoadComplete );
			_loader.contentLoaderInfo.removeEventListener( ProgressEvent.PROGRESS, onLoadProgress );
			_loader.contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, onLoadIOError );
			_loader.contentLoaderInfo.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, onLoadSecurityError );
		}
		
		//----------------------------------
		//  Override
		//----------------------------------
		
		/**
		 * @inheritDoc
		 */
		override protected function init():void
		{
			_loader = new Loader();
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
			
			// Attempt to register the font
			registerFont();
			
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
			// Update our progress amount
			progress.setAmountLoaded( event.bytesLoaded / event.bytesTotal );
		}
		
		/**
		 * @private 
		 * @param event <code>IOErrorEvent.IO_ERROR</code>
		 */		
		protected function onLoadIOError( event:IOErrorEvent ):void
		{
			// Remove listeners
			removeListeners();
			
			errored.dispatch( event );
		}
		
		/**
		 * @private 
		 * @param event <code>SecurityErrorEvent.SECURITY_ERROR</code>
		 */
		protected function onLoadSecurityError( event:SecurityErrorEvent ):void
		{
			// Remove listeners
			removeListeners();
			
			errored.dispatch( event );
		}
		
		//----------------------------------
		//  Override
		//----------------------------------
		
		/**
		 * 
		 * @return <code>ISignalOwner</code> 
		 */		
		override protected function getLoadedSignal():ISignalOwner
		{
			return new Signal( IFontService );
		}
		
		/**
		 * 
		 * @return <code>ISignalOwner</code> 
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
		 * The font name being used by the service to register the font once
		 * loaded. If this value is set in the constructor, the service will 
		 * attempt to register the font. If it is not set, the service will 
		 * ignore and assume that the font SWF will register itself.
		 * 
		 * @return String
		 */		
		public function get fontName():String
		{
			return _fontName;
		}
		
		/**
		 * Loader which loads the resource
		 *
		 * @return URLLoader Loader instance
		 */
		protected function get loader():Loader
		{
			return _loader;
		}
		
		/**
		 * @private
		 * Set the loader
		 * 
		 * @param value URLLoader instance to set
		 */
		protected function set loader( value:Loader ):void
		{
			_loader = value;
		}
	}
}