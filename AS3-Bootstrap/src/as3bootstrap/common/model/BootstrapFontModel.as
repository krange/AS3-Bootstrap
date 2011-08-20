package as3bootstrap.common.model
{
	import as3bootstrap.common.progress.IProgress;
	import as3bootstrap.common.progress.Progress;
	import as3bootstrap.common.services.IService;
	import as3bootstrap.common.services.font.FontService;
	import as3bootstrap.common.services.font.IFontService;
	import as3bootstrap.common.utils.Dependency;
	
	import flash.events.Event;
	import flash.text.Font;
	
	/**
	 * BootstrapFontModel
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange 
	 */
	public class BootstrapFontModel 
		extends BootstrapDataModel
		implements IBootstrapFontModel
	{
		private var _services : Array;
		private var _dependency : Dependency;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */		
		public function BootstrapFontModel( progress:IProgress )
		{
			super( progress );
		}
		
		/**
		 * Load the localization data
		 * 
		 * @param url URL request
		 */		
		public function load( data:XMLList ):void
		{
			if( data && 
				data.length() > 0 )
			{
				services = new Array();
				_dependency = new Dependency();
				_dependency.addEventListener( Event.COMPLETE, onAllServicesLoaded, false, 0, true );
				
				var xml_len : int = data.length();
				for( var i : int = 0; i < xml_len; i++ )
				{
					var service_progress : IProgress = new Progress();
					var service : IFontService;
					
					var fontName : String = data[i].@id;
					if( !checkFont( fontName ) )
					{
						if( fontName.length > 0 )
						{
							service = new FontService( service_progress, fontName );
						}
						else
						{
							service = new FontService( service_progress );
						}
						
						services[services.length] = service;
						progress.addChildLoadable( service_progress );
						_dependency.addDependancy( service );
						service.loaded.add( onServiceLoaded );
						service.errored.add( onServiceErrored );
						service.loadWithUrl( searchAndReplaceLangAndLocale( data[i].@url ) );
					}
				}
			}
		}
		
		//---------------------------------------------------------------------
		//
		//  Protected methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Checks to make sure the font has not already 
		 * been loaded.
		 * 
		 * @param name Name of font
		 * @return Boolean False if not already loaded, true if yes
		 */ 
		protected function checkFont( name:String ):Boolean
		{
			// Get all embedded fonts
			var fonts : Array = Font.enumerateFonts();
			for( var i : Number = 0; i < fonts.length; i++ )
			{
				// Check to see if the Font name matches the one
				// that is trying to be loaded, if so return true
				if( fonts[i].fontName == name ) 
				{
					return true;
				}
			}
			
			// No font was found, so return false
			return false;	
		}
		
		//----------------------------------
		//  Handlers
		//----------------------------------
		
		/**
		 * @private
		 * Callback when all services have loaded 
		 *  
		 * @param event <code>Event.COMPLETE</code>
		 */		
		protected function onAllServicesLoaded( event:Event ):void
		{
			// Remove the event listener
			_dependency.removeEventListener( Event.COMPLETE, onAllServicesLoaded );
			_dependency = null;
			
			// Dispatch that now all localizations have been loaded
			loaded.dispatch();
		}
		
		/**
		 * @private
		 * Callback when a service has loaded
		 *  
		 * @param service <code>IService</code>
		 */		
		protected function onServiceLoaded( service:IService ):void
		{
			_dependency.setLoadDependencyMet( service );
		}
		
		/**
		 * @private
		 * Callback when a service has errored 
		 *  
		 * @param event <code>Event</code>
		 */		
		protected function onServiceErrored( event:Event ):void
		{
			errored.dispatch( event );
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Get the services holder
		 * 
		 * @return Array 
		 */		
		protected function get services():Array
		{
			return _services;
		}
		
		/**
		 * Set the services holder
		 * 
		 * @param value Array 
		 */		
		protected function set services( value:Array ):void
		{
			_services = value;
		}
	}
}