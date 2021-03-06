package as3bootstrap.flex.spark.model
{
	import as3bootstrap.common.model.BootstrapDataModel;
	import as3bootstrap.common.model.IBootstrapStylesheetModel;
	import as3bootstrap.common.progress.IProgress;
	import as3bootstrap.common.progress.Progress;
	import as3bootstrap.common.services.IService;
	import as3bootstrap.common.utils.Dependency;
	import as3bootstrap.flex.spark.services.css.FlexSparkStylesheetService;
	import as3bootstrap.flex.spark.services.css.IFlexSparkStylesheetService;
	
	import flash.events.Event;
	import flash.text.StyleSheet;
	
	/**
	 * Flex4 stylesheet model
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 10.0.0
	 * 
	 * @author krisrange
	 */
	public class BootstrapFlexSparkStylesheetModel 
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
		 * @inheritDoc
		 */
		public function BootstrapFlexSparkStylesheetModel( progress:IProgress )
		{
			super( progress );
		}
		
		/**
		 * Load the config data
		 * 
		 * @param data XMLList of data to load
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
					var service : IFlexSparkStylesheetService = new FlexSparkStylesheetService( service_progress );
					
					services[services.length] = service;
					progress.addChildLoadable( service_progress );
					_dependency.addDependancy( service );
					service.loaded.add( onServiceLoaded );
					service.errored.add( onServiceErrored );
					service.loadWithUrl( data[i].@url );
				}
			}
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
		 * @param event Event
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
		 * Since in Flex3 all data is stored in the StyleManager
		 * 
		 * @return StyleSheet 
		 */		
		public function get stylesheets():StyleSheet
		{
			return null;
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