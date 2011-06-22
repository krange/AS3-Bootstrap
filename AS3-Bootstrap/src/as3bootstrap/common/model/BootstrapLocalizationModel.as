package as3bootstrap.common.model
{
	import as3bootstrap.common.model.vo.ILocalization;
	import as3bootstrap.common.model.vo.Localization;
	import as3bootstrap.common.progress.IProgress;
	import as3bootstrap.common.progress.Progress;
	import as3bootstrap.common.services.xml.IXmlService;
	import as3bootstrap.common.services.xml.XmlService;
	import as3bootstrap.common.utils.Dependency;
	
	import flash.events.Event;
	
	/**
	 * Localization model for bootstrap load setup. This class stores the 
	 * all of the XML data that is loaded.
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange 
	 */
	public class BootstrapLocalizationModel 
		extends BootstrapDataModel
		implements IBootstrapLocalizationModel
	{
		private var _services : Array;
		private var _dependency : Dependency;
		private var _localizations : Localization;
		
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
		public function BootstrapLocalizationModel( progress:IProgress )
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
					var service : IXmlService = new XmlService( service_progress );
					
					services[services.length] = service;
					progress.addChildLoadable( service_progress );
					_dependency.addDependancy( service );
					service.loaded.add( onServiceLoaded );
					service.errored.add( onServiceErrored );
					service.loadWithUrl( data[i].@url );
				}
			}
		}
		
		/**
		 * Retrieves a singular localization value object from the specified
		 * localization service. Returns null if no data is found.
		 *  
		 * @param id ID of the XML service node
		 * @return ILocalization
		 */		
		public function getLocalizationById( id:String ):ILocalization
		{
			var locLen : int = services.length;
			while( locLen-- )
			{
				var service : IXmlService = services[locLen] as IXmlService;
				if( service.data.@id == id )
				{
					return new Localization( service.data );
				}
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
		 * @inheritDoc
		 */		
		override protected function init():void
		{
			super.init();
			services = new Array();
			_localizations = new Localization();
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
		 * @param service <code>IXmlService</code>
		 */		
		protected function onServiceLoaded( service:IXmlService ):void
		{
			_localizations.addLocalizedValues( service.data );
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
		 * All localization service data merged into a signular value object.
		 * 
		 * @return ILocalization 
		 */		
		public function get localizations():ILocalization
		{
			return _localizations;
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