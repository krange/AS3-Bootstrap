package as3bootstrap.common.events
{
	import flash.events.Event;
	
	/**
	 * Custom event class to communicate progress load. A custom class because 
	 * the Flash ProgressEvent dispatches values in uint format versus Progress 
	 * class dispatching in 0-1 format.
	 * 
	 * @see as3bootstrap.common.progress.Progress
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange
	 */
	public class ResourceProgressEvent 
		extends Event
	{
		/** 
		 * Progress event constant
		 */
		public static const PROGRESS : String = "progress";
		
		/**
		 * Force quit event constant 
		 */		
		public static const FORCE_QUIT : String = "forceQuit";
		
		/** 
		 * Progress amount loaded 
		 */
		private var _amountLoaded : Number = 0;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 * 
		 * @param $type Event type
		 * @param $amountLoaded Number between 0 and 1 specifying total progress
		 * 
		 * @see flash.events.Event
		 */
		public function ResourceProgressEvent( 
			$type : String, 
			$amountLoaded : Number, 
			$bubbles : Boolean = false, 
			$cancelable : Boolean = false )
		{
			_amountLoaded = $amountLoaded;
			
			super( $type, $bubbles, $cancelable );
		}
		
		//----------------------------------
		//  Override
		//----------------------------------
		
		/**
		 * Override the inherited clone() method. 
		 * 
		 * @see flash.events.Event
		 */ 
		override public function clone():Event
		{
			return new ResourceProgressEvent( type, amountLoaded );
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Get amountLoaded
		 * 
		 * @return Number Total amount loaded between 0-1
		 */
		public function get amountLoaded():Number
		{
			return _amountLoaded;
		}
	}
}