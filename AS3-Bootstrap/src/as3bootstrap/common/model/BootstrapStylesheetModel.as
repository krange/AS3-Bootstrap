package as3bootstrap.common.model
{
	import as3bootstrap.common.progress.IProgress;
	import as3bootstrap.common.progress.Progress;
	import as3bootstrap.common.services.IService;
	import as3bootstrap.common.services.css.IStylesheetService;
	import as3bootstrap.common.services.css.StylesheetService;
	import as3bootstrap.common.utils.Dependency;
	
	import flash.events.Event;
	import flash.text.StyleSheet;
	
	/**
	 * StylesheetModel
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange 
	 */
	public class BootstrapStylesheetModel 
		extends BootstrapDataModel
		implements IBootstrapStylesheetModel
	{	
		private var _services : Array;
		private var _dependency : Dependency;
		
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
		public function BootstrapStylesheetModel( progress:IProgress )
		{
			super( progress );
		}
		
		/**
		 * Load the config data
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
					var service : IStylesheetService = new StylesheetService( service_progress );
					
					services[services.length] = service;
					progress.addChildLoadable( service_progress );
					_dependency.addDependancy( service );
					service.loaded.add( onServiceLoaded );
					service.errored.add( onServiceErrored );
					
					var url:String = "";
					if( resourceBaseUrl ) {
						url += resourceBaseUrl;
					}
					
					url += data[i].@url;
					
					service.loadWithUrl( searchAndReplaceLangAndLocale( url ) );
				}
			}
		}
		
		/**
		 * Retrieves a singular stylesheet from the specified stylesheet 
		 * service. Returns null if no data is found.
		 *  
		 * @param id ID of the XML service node
		 * @return Stylesheet
		 */		
		public function getStylesheetById( id:String ):StyleSheet
		{
			var serLen : int = services.length;
			while( serLen-- )
			{
				var service : IStylesheetService = services[serLen] as IStylesheetService;
				/*
				if( service == id )
				{
					return service.data;
				}
				*/
			}
			return null;
		}
		
		//---------------------------------------------------------------------
		//
		//  Protected methods
		//
		//---------------------------------------------------------------------
		
		//----------------------------------
		//  Override
		//----------------------------------
		
		/**
		 * @private 
		 * @see as3bootstrap.common.model.BootstrapModel
		 */		
		override protected function init():void
		{
			super.init();
			services = new Array();
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
		 * All stylehseet service data merged into a signular value object.
		 * 
		 * @return StyleSheet 
		 */		
		public function get stylesheets():StyleSheet
		{
			var serLen : int = services.length;
			var serviceData : StyleSheet = new StyleSheet();
			while( serLen-- )
			{
				var service : IStylesheetService = services[serLen] as IStylesheetService;
				serviceData.parseCSS( service.css );
			}
			
			return serviceData;
		}
		
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