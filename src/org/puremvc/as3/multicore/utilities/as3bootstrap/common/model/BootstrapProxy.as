package org.puremvc.as3.multicore.utilities.as3bootstrap.common.model
{
	import as3bootstrap.common.IBootstrap;
	
	import flash.events.Event;
	
	import org.puremvc.as3.multicore.utilities.as3bootstrap.common.constants.BootstrapPureMVCConstants;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.proxy.FabricationProxy;
	
	/**
	 * BootstrapProxy
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange 
	 */
	public class BootstrapProxy 
		extends FabricationProxy
		implements IBootstrapProxy
	{
		public static const NAME : String = "BootstrapProxy";
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 * 
		 * @param $proxyName Name of the proxy
		 * @param $bootstrap <code>IBootstrap</code> object
		 */		
		public function BootstrapProxy( $proxyName:String=null, $bootstrap:IBootstrap=null )
		{
			super( $proxyName, $bootstrap );
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
		 */
		override protected function initializeProxyNameCache():void
		{
			super.initializeProxyNameCache();
			
			// Add signal listeners
			bootstrap.appLoaded.add( onAppLoaded );
			bootstrap.bootstrapLoaded.add( onBootstrapLoaded );
			bootstrap.bootstrapResourceErrored.add( onBootstrapResourceErrored );
			bootstrap.configErrored.add( onConfigErrored );
			bootstrap.configLoaded.add( onConfigLoaded );
			bootstrap.dataLoaded.add( onDataLoaded );
		}
		
		//----------------------------------
		//  Handlers
		//----------------------------------
		
		/**
		 * Signal callback for when the entire application load is completed
		 */		
		protected function onAppLoaded():void
		{
			sendNotification( BootstrapPureMVCConstants.APPLICATION_LOAD_COMPLETE );
		}
		
		/**
		 * Signal callback for when the data portion of load is completed 
		 */		
		protected function onDataLoaded():void
		{
			sendNotification( BootstrapPureMVCConstants.DATA_LOAD_COMPLETE );
		}
		
		/**
		 * Signal callback for when the bootstrap portion of load is completed 
		 */		
		protected function onBootstrapLoaded():void
		{
			sendNotification( BootstrapPureMVCConstants.BOOTSTRAP_LOAD_COMPLETE );
		}
		
		/**
		 * Signal callback when the bootstrap config load has completed 
		 * 
		 */		
		protected function onConfigLoaded():void
		{
			sendNotification( BootstrapPureMVCConstants.BOOTSTRAP_CONFIG_LOAD_COMPLETE );
		}
		
		/**
		 * Callback for when the bootstrap config load has errored
		 * 
		 * @param event <code>Event</code> 
		 */		
		protected function onConfigErrored( event : Event ):void
		{
			sendNotification( BootstrapPureMVCConstants.BOOTSTRAP_CONFIG_LOAD_FAIL, event );
		}
		
		/**
		 * Callback for when a bootstrap load resource has errored
		 *  
		 * @param event <code>Event</code>
		 */		
		protected function onBootstrapResourceErrored( event : Event ):void
		{
			sendNotification( BootstrapPureMVCConstants.BOOTSTRAP_LOAD_ERROR, event );
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Returns the <code>IBootstrap</code> object
		 * 
		 * @return <code>IBootstrap</code> object 
		 */		
		public function get bootstrap():IBootstrap
		{
			return data as IBootstrap;
		}
	}
}