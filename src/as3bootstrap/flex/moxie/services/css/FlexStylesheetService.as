/**
 * ------------------------------------------------------------
 * Copyright (c) 2010 Dareville.
 * This software is the proprietary information of Dareville.
 * All Right Reserved.
 * ------------------------------------------------------------
 *
 * SVN revision information:
 * @version $Revision: $:
 * @author  $Author: $:
 * @date    $Date: $:
 */
package as3bootstrap.flex.moxie.services.css
{
	import as3bootstrap.common.progress.IProgress;
	import as3bootstrap.common.services.AbstractService;
	
	import flash.events.IEventDispatcher;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	
	import mx.events.StyleEvent;
	import mx.styles.StyleManager;
	
	/**
	 * FlexStylesheetService
	 * 
	 * @author krisrange
	 */
	public class FlexStylesheetService 
		extends AbstractService
		implements IFlexStylesheetService
	{
		private var _loader : IEventDispatcher;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function FlexStylesheetService($progress:IProgress=null)
		{
			super($progress);
		}
		
		//----------------------------------
		//  Override
		//----------------------------------
		
		/**
		 * 
		 * @param request 
		 */		
		override public function loadWithUrlRequest(request:URLRequest):void
		{
			loader = StyleManager.loadStyleDeclarations( request.url, true, false, ApplicationDomain.currentDomain );
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
		protected function handleCSSLoadProgress( event : StyleEvent ) : void
		{
			progress.setAmountLoaded( event.bytesLoaded / event.bytesTotal );
		}
		
		/**
		 * Called when the external css file has loaded
		 * 
		 * @param event Event.COMPLETE
		 */
		protected function handleCSSLoadComplete( event : StyleEvent ) : void
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
		protected function handleCSSLoadError( event : StyleEvent ) : void
		{
			loader.removeEventListener( StyleEvent.ERROR, handleCSSLoadError );
			loader.removeEventListener( StyleEvent.PROGRESS, handleCSSLoadProgress );
			loader.removeEventListener( StyleEvent.COMPLETE, handleCSSLoadComplete );
			
			errored.dispatch( event );
		}
		
		//---------------------------------------------------------------------
		//
		//  Private methods
		//
		//---------------------------------------------------------------------
		
		//----------------------------------
		//  Handlers
		//----------------------------------
		
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
		protected function set loader($value:IEventDispatcher):void
		{
			_loader = $value;
		}
	}
}