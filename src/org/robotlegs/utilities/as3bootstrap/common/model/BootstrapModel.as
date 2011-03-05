package org.robotlegs.utilities.as3bootstrap.common.model
{
	import as3bootstrap.common.IBootstrap;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Actor;
	import org.robotlegs.utilities.as3bootstrap.common.model.events.BootstrapStatusEvent;
	
	/**
	 * Robotlegs model for interfacing with the bootstrap object
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange
	 */
	public class BootstrapModel 
		extends Actor
		implements IBootstrapModel
	{
		private var _bootstrap : IBootstrap;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 * 
		 * @param $bootstrap <code>IBootstrap</code> object
		 */
		public function BootstrapModel( $bootstrap:IBootstrap )
		{
			super();
			_bootstrap = $bootstrap;
			init();
		}
		
		//---------------------------------------------------------------------
		//
		//  Protected methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Initialize 
		 */		
		protected function init():void
		{
			// Add signal listeners
			bootstrap.appLoaded.add( onAppLoaded );
			bootstrap.dataLoaded.add( onDataLoaded );
			bootstrap.bootstrapLoaded.add( onBootstrapLoaded );
			bootstrap.bootstrapResourceErrored.add( onBootstrapResourceErrored );
			bootstrap.configErrored.add( onConfigErrored );
			bootstrap.configLoaded.add( onConfigLoaded );
		}
		
		//----------------------------------
		//  Handlers
		//----------------------------------
		
		/**
		 * Signal callback for when the entire application load is completed
		 */		
		protected function onAppLoaded():void
		{
			dispatch( new BootstrapStatusEvent( BootstrapStatusEvent.APPLICATION_LOAD_COMPLETE ) );
		}
		
		/**
		 * Signal callback for when the data portion of load is completed 
		 */		
		protected function onDataLoaded():void
		{
			dispatch( new BootstrapStatusEvent( BootstrapStatusEvent.DATA_LOAD_COMPLETE ) );
		}
		
		/**
		 * Signal callback for when the bootstrap portion of load is completed 
		 */		
		protected function onBootstrapLoaded():void
		{
			dispatch( new BootstrapStatusEvent( BootstrapStatusEvent.BOOTSTRAP_LOAD_COMPLETE ) );
		}
		
		/**
		 * Signal callback when the bootstrap config load has completed 
		 * 
		 */		
		protected function onConfigLoaded():void
		{
			dispatch( new BootstrapStatusEvent( BootstrapStatusEvent.CONFIG_LOAD_COMPLETE ) );
		}
		
		/**
		 * Callback for when the bootstrap config load has errored
		 * 
		 * @param $event <code>Event</code> 
		 */		
		protected function onConfigErrored( $event:Event ):void
		{
			dispatch( new BootstrapStatusEvent( BootstrapStatusEvent.CONFIG_LOAD_ERROR ) );
		}
		
		/**
		 * Callback for when a bootstrap load resource has errored
		 *  
		 * @param $event <code>Event</code>
		 */		
		protected function onBootstrapResourceErrored( $event:Event ):void
		{
			dispatch( new BootstrapStatusEvent( BootstrapStatusEvent.BOOTSTRAP_RESOURCE_ERROR ) );
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Returns the <code>IBootstrap</code> object
		 * 
		 * @return IBootstrap
		 */		
		public function get bootstrap():IBootstrap
		{
			return _bootstrap;
		}
	}
}