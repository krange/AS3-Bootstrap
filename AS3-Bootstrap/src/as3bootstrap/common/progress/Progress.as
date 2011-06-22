package as3bootstrap.common.progress
{
	import as3bootstrap.common.events.ResourceProgressEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * Class which tracks load progress. Based on a progress class in 
	 * ActionScript 2.0 written by Ward Ruth. Provides the ability to add weight 
	 * to a progress instance as well as add any number of child loading items 
	 * to any progress instance.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author Ward Ruth
	 * @author Kris Range
	 */ 
	public class Progress 
		extends EventDispatcher 
		implements IProgress, IEventDispatcher
	{
		/**
		 * ID 
		 */
		protected var id : String;
		
		/**
		 * Weight of the item 
		 */
		protected var weight : Number = 1;
		
		/**
		 * Weight of all child items 
		 */
		protected var totalChildWeight : Number = 0;
		
		/**
		 * Amount of item loaded - Value between 0-1 
		 */
		protected var amountLoaded : Number = 0;
		
		/**
		 * Child progress reference 
		 */
		protected var childLoadableArray : Array = new Array();
		
		/** 
		 * Flag for optimizing rolled up child Progress 
		 */
		private var _progressInvalidated : Boolean = false;
		
		/** 
		 * Timer used to wait to collect rolled up child Progress. 40 ms
		 * delay means about a 1 frame delay at 24 fps.
		 */
		private var _invalidationTimer : Timer = new Timer( 40, 1 );
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/** 
		 * Constructor
		 * 
		 * @param weight Initial weight to set
		 * @param id An identifier for the progress instance
		 */
		public function Progress( weight:uint = 1, id:String = null )
		{
			setWeight( weight );
			this.id = id;
			
			_invalidationTimer.addEventListener( TimerEvent.TIMER_COMPLETE, handleTimerComplete, false, 0, true );
		}
		
		/**
		 * Factory method. Create and add a child IProgress in one operation.
		 * 
		 * @param weight Initial weight to set
		 * @param id An identifier for the progress instance
		 * 
		 * @return An initialized IProgress instance
		 */
		public function createChildLoadable( weight:Number = 1, id:String = null ):IProgress
		{
			var progress : Progress = new Progress( weight, id );
			addChildLoadable( progress );
			
			return progress;
		}
		
		/**
		 * Add a child IProgress instance to a child list of this item
		 * 
		 * @param progres IProgress to add
		 */ 
		public function addChildLoadable( progress:IProgress ):void
		{
			childLoadableArray[childLoadableArray.length] = progress;
			progress.addEventListener( ResourceProgressEvent.PROGRESS, handleProgressUpdate, false, 0, true );
			totalChildWeight += progress.getWeight();
		}
		
		/**
		 * Retrieve a child progress instance by it's ID
		 * 
		 * @param id ID to search for
		 */ 
		public function retrieveChildLoadable( id:String ):IProgress
		{
			var selectedProgress : IProgress;
			var i : int = childLoadableArray.length;
			var curProgress : IProgress;
			
			while( i-- )
			{
				curProgress = childLoadableArray[i] as IProgress;
				
				if( curProgress.getId() == id ) 
				{
					selectedProgress = curProgress;
					break;
				}
			}
			
			return selectedProgress;
		}
		
		/**
		 * Check to see if the provided <code>IProgress</code> instance is a
		 * direct child or not.
		 * 
		 * @param instance IProgress to search
		 * 
		 * @return Boolean
		 */ 
		public function isChildLoadable( instance:IProgress ):Boolean
		{
			var selectedProgress : IProgress;
			var i : int = childLoadableArray.length;
			var curProgress : IProgress;
			
			while( i-- )
			{
				curProgress = childLoadableArray[i] as IProgress;
				
				if( curProgress == instance ) 
				{
					return true;
				}
			}
			
			return false;
		}
		
		/**
		 * Checks to see if this current <code>IProgress</code> instance has 
		 * any child <code>IProgress</code> instances.
		 * 
		 * @return Boolean
		 */ 
		public function hasChildLoadables():Boolean
		{
			return ( childLoadableArray.length > 0 ) ? true : false;
		}
		
		/**
		 * Remove a child progress instance by it's ID
		 * 
		 * @param id ID to search for
		 * 
		 * @return <code>true</code> if a child was removed, 
		 * 		   <code>false</code> otherwise
		 */ 
		public function removeChildLoadableById( id:String ):Boolean 
		{
			var i : int = childLoadableArray.length;
			var curProgress : IProgress;
			
			while( i-- )
			{
				curProgress = childLoadableArray[i] as IProgress;
				if( curProgress.getId() == id ) 
				{
					childLoadableArray.splice( i, 1 );
					return true;
				}
			}
			return false;
		}
		
		/**
		 * Remove a child progress instance
		 * 
		 * @param progress IProgress to search for
		 * @return Boolean <code>true</code> if removed successfully
		 */ 
		public function removeChildLoadable( progress:IProgress ):Boolean 
		{
			var i : int = childLoadableArray.length;
			var curProgress : IProgress;
			
			while( i-- )
			{
				curProgress = childLoadableArray[i] as IProgress;
				if( curProgress == progress ) 
				{
					childLoadableArray.splice( i, 1 );
					return true;
				}
			}
			return false;
		}
		
		/**
		 * Forces progress to quit itself. This is useful, for example,
		 * if an error with high enough severity has occured.
		 */
		public function forceQuit():void 
		{
			// Clear out all the references to any child progress
			childLoadableArray = new Array();
			
			// Dispatch an event that a force quit has happened
			dispatchEvent( new ResourceProgressEvent( ResourceProgressEvent.FORCE_QUIT, 0 ) );
		}
		
		/**
		 * Set the item loaded amount, value from 0-1. If there are child
		 * progress instances attached this to this item, this method is ignored.
		 * 
		 * @param amount Amount to set
		 */ 
		public function setAmountLoaded( amount:Number ):void
		{
			if( childLoadableArray.length == 0 )
			{
				if( amount < 0 ) 
				{
					amount = 0;
				}
				
				if( amount > 1 ) 
				{
					amount = 1;
				}
				
				// Set amount loaded
				amountLoaded = amount;
				
				// Dispatch ResourceProgressEvent
				dispatchEvent( new ResourceProgressEvent( ResourceProgressEvent.PROGRESS, amountLoaded, false, false ) );
			}	
		}
		
		/** 
		 * Returns the total amount loaded of either this item or all child 
		 * instances attached
		 * 
		 * @return Number Total amount loaded 
		 */
		public function getAmountLoaded():Number
		{
			if( childLoadableArray.length == 0 )
			{
				return amountLoaded;
			}
			
			return getChildLoaded();
		}
		
		/**
		 * Set the unique ID for the progress item
		 * 
		 * @param id ID to set
		 */ 
		public function setId( id:String ):void
		{
			this.id = id;
		}
		
		/** 
		 * @return String ID of the progress item
		 */
		public function getId():String
		{
			return id;	
		}
		
		/** 
		 * @return Number weight of item 
		 */
		public function getWeight():Number
		{
			return weight;
		}
		
		//---------------------------------------------------------------------
		//
		//  Protected methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Validate that the weight being set. It should be a value greater 
		 * than zero. If value is less than or equal to zero, set the value to
		 * the default 1.
		 *  
		 * @param value Number
		 */		
		protected function setWeight( weight:Number ):void
		{
			if( weight <= 0 )
			{
				weight = 1;
			}
			
			this.weight = weight;
		}
		
		/** 
		 * Returns the total progress of all children associated with this 
		 * progress instance. The returned value also uses the default AS3 
		 * <code>toPrecision</code> to account for rounding issues with 
		 * repeating values
		 * 
		 * @return Number total amount loaded of all child instances 
		 */ 
		protected function getChildLoaded():Number
		{
			var totalAmountLoaded : Number = 0;
			var i : int = childLoadableArray.length;
			var progress : IProgress;
			
			while( i-- )
			{
				progress = childLoadableArray[i] as IProgress;
				totalAmountLoaded += progress.getAmountLoaded() * ( progress.getWeight() / totalChildWeight );
			}
			
			return Number( totalAmountLoaded.toPrecision( 3 ) );
		}
		
		//----------------------------------
		//  Handlers
		//----------------------------------
		
		/**
		 * Callback for when the progress of a child updates
		 * 
		 * @param event <code>ResourceProgressEvent.PROGRESS</code>
		 */ 
		protected function handleProgressUpdate( event:ResourceProgressEvent ):void
		{
			if( ! _progressInvalidated )
			{
				_progressInvalidated = true;
				_invalidationTimer.start();
			}
		}
		
		//---------------------------------------------------------------------
		//
		//  Private methods
		//
		//---------------------------------------------------------------------
		
		//----------------------------------
		//  Handlers
		//----------------------------------
		
		/**
		 * @private
		 * Callback for update invalidation Timer. Reset invalidation flag and
		 * dispatch a rolled up ResourceProgressEvent.
		 * 
		 * @param event	<code>TimerEvent.TIMER_COMPLETE</code>
		 */
		private function handleTimerComplete( event:TimerEvent ):void
		{
			_progressInvalidated = false;
			
			var progressEvent : ResourceProgressEvent = new ResourceProgressEvent( ResourceProgressEvent.PROGRESS, getChildLoaded(), false, false );
			dispatchEvent( progressEvent );
		}
	}
}