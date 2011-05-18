package as3bootstrap.flex.moxie.service.css
{
	import as3bootstrap.common.progress.IProgress;
	import as3bootstrap.common.services.AbstractService;
	
	import flash.events.IEventDispatcher;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	
	import mx.events.StyleEvent;
	import mx.styles.IStyleManager;
	import mx.styles.StyleManager;
	
	/**
	 * Flex3 stylesheet service
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange
	 */
	public class FlexMoxieStylesheetService 
		extends AbstractService
		implements IFlexMoxieStylesheetService
	{
		private var _loader : IEventDispatcher;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		public function FlexMoxieStylesheetService( progress:IProgress = null )
		{
			super(progress);
		}
		
		//----------------------------------
		//  Override
		//----------------------------------
		
		/**
		 * @inheritDoc
		 */		
		override public function loadWithUrlRequest( request:URLRequest ):void
		{
			loader = StyleManager.loadStyleDeclarations( request.url, true, true, ApplicationDomain.currentDomain );
			loader.addEventListener( StyleEvent.ERROR, handleCSSLoadError );
			loader.addEventListener( StyleEvent.PROGRESS, handleCSSLoadProgress );
			loader.addEventListener( StyleEvent.COMPLETE, handleCSSLoadComplete );
		}
		
		//---------------------------------------------------------------------
		//
		//  Protected methods
		//
		//---------------------------------------------------------------------
		
		//----------------------------------
		//  Handlers
		//----------------------------------
		
		/**
		 * Called when the external css file has loaded
		 * 
		 * @param event StyleEvent.PROGRESS
		 */
		protected function handleCSSLoadProgress( event:StyleEvent ):void
		{
			progress.setAmountLoaded( event.bytesLoaded / event.bytesTotal );
		}
		
		/**
		 * Called when the external css file has loaded
		 * 
		 * @param event Event.COMPLETE
		 */
		protected function handleCSSLoadComplete( event:StyleEvent ):void
		{
			loader.removeEventListener( StyleEvent.ERROR, handleCSSLoadError );
			loader.removeEventListener( StyleEvent.PROGRESS, handleCSSLoadProgress );
			loader.removeEventListener( StyleEvent.COMPLETE, handleCSSLoadComplete );
			
			progress.setAmountLoaded( 1 );
			
			loaded.dispatch( this );
		}
		
		/**
		 * Called when the external css file has errored during load
		 * 
		 * @param event Event.ERROR
		 */
		protected function handleCSSLoadError( event:StyleEvent ) : void
		{
			loader.removeEventListener( StyleEvent.ERROR, handleCSSLoadError );
			loader.removeEventListener( StyleEvent.PROGRESS, handleCSSLoadProgress );
			loader.removeEventListener( StyleEvent.COMPLETE, handleCSSLoadComplete );
			
			errored.dispatch( event );
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Loader which loads the resource
		 *
		 * @return IEventDispatcher Loader instance
		 */
		protected function get loader():IEventDispatcher
		{
			return _loader;
		}
		
		/**
		 * @private
		 * Set the loader
		 * 
		 * @param value IEventDispatcher instance to set
		 */
		protected function set loader( value:IEventDispatcher ):void
		{
			_loader = value;
		}
	}
}