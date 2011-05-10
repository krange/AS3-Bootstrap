package org.robotlegs.utilities.as3bootstrap.common.model.events
{
	import flash.events.Event;
	
	/**
	 * BootstrapEvent.as
	 * 
	 * @author krisrange
	 */
	public class BootstrapStatusEvent 
		extends Event
	{
		public static const BOOTSTRAP_LOAD_COMPLETE : String = "bootstrapLoadComplete";
		public static const DATA_LOAD_COMPLETE : String = "dataLoadComplete";
		public static const APPLICATION_LOAD_COMPLETE : String = "applicationLoadComplete";
		public static const CONFIG_LOAD_COMPLETE : String = "configLoadComplete";
		public static const CONFIG_LOAD_ERROR : String = "configLoadError";
		public static const BOOTSTRAP_RESOURCE_ERROR : String = "bootstrapResourceError";
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * @inheritDoc 
		 */
		public function BootstrapStatusEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		//----------------------------------
		//  Override
		//----------------------------------
		
		/**
		 * @inheritDoc 
		 */
		override public function clone():Event
		{
			return new BootstrapStatusEvent( type, bubbles, cancelable );
		}
	}
}