package as3bootstrap.common.model
{
	import as3bootstrap.common.progress.IProgress;
	import as3bootstrap.common.services.xml.IXmlService;
	import as3bootstrap.common.services.xml.XmlService;
	
	import flash.events.Event;
	
	/**
	 * Configuration model for bootstrap load setup. This class stores the 
	 * XML data that is loaded.
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange 
	 */
	public class BootstrapConfigModel 
		extends BootstrapDataModel
		implements IBootstrapConfigModel
	{
		private var _service : IXmlService;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */		
		public function BootstrapConfigModel( progress:IProgress )
		{
			super( progress );
		}
		
		/**
		 * Load the config data
		 * 
		 * @param url URL string
		 */		
		public function load( url:String ):void
		{
			if( url && 
				url.length > 0 )
			{
				_service.loadWithUrl( searchAndReplaceLangAndLocale( url ) );
			}
			else
			{
				progress.setAmountLoaded( 1 );
				loaded.dispatch();
			}
		}
		
		//----------------------------------
		//  Override
		//----------------------------------
		
		/**
		 * @inheritDocs
		 */		
		override public function destroy():void
		{
			super.destroy();
			
			service.destroy();
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
			
			_service = getService();
			service.progress = progress;
			service.errored.add( onServiceErrored );
			service.loaded.add( onServiceLoaded );
		}
		
		//----------------------------------
		//  Handlers
		//----------------------------------
		
		/**
		 * @private
		 * Signal callback for when the service has errored 
		 */		
		protected function onServiceErrored( event:Event ):void
		{
			service.loaded.removeAll();
			service.errored.removeAll();
			
			errored.dispatch( event );
		}
		
		/**
		 * @private 
		 * Signal callback for when the service has loaded
		 */		
		protected function onServiceLoaded( service:IXmlService ):void
		{
			service.loaded.removeAll();
			service.errored.removeAll();
			
			loaded.dispatch();
		}
		
		//----------------------------------
		//  Instantations
		//----------------------------------
		
		/**
		 * @private
		 * 
		 * @return <code>IXmlService</code> 
		 */		
		protected function getService():IXmlService
		{
			return new XmlService();
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * The loaded XML data from the service
		 * 
		 * @return XML 
		 */
		public function get data():XML
		{
			return service.data;	
		}
		
		/**
		 * Retrieve all stylesheets associated to bootstrap
		 * 
		 * @return XMLList 
		 */		
		public function get stylesheets():XMLList
		{
			if( service.data )
			{
				return service.data.stylesheet;
			}
			return new XMLList();
		}
		
		/**
		 * Retrieve all localizations associated to bootstrap
		 * 
		 * @return XMLList 
		 */		
		public function get localizations():XMLList
		{
			if( service.data )
			{
				return service.data.localization;
			}
			return new XMLList();
		}
		
		/**
		 * Retrieve all fonts associated to bootstrap
		 * 
		 * @return XMLList 
		 */		
		public function get fonts():XMLList
		{
			if( service.data )
			{
				return service.data.font;
			}
			return new XMLList();
		}
		
		/**
		 * Get the service for the config model
		 * 
		 * @return <code.IXmlService</code> 
		 */		
		protected function get service():IXmlService
		{
			return _service;
		}
		
		/**
		 * Set the service for the config model
		 * 
		 * @param value <code>IXmlService</code> to set 
		 */		
		protected function set service( value:IXmlService ):void
		{
			_service = value;
		}
	}
}