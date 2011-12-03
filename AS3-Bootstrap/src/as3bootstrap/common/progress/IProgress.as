package as3bootstrap.common.progress
{
	import flash.events.IEventDispatcher;
	
	/** 
	 * Interface for Progress classes
	 * 
	 * @see as3bootstrap.common.progress.Progress
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange
	 */ 
	public interface IProgress 
		extends IEventDispatcher
	{
		/**
		 * Factory method. Create and add a child IProgress in one operation.
		 * 
		 * @param weight Initial weight to set
		 * @param id An identifier for the progress instance
		 * @return An initialized IProgress instance
		 */
		function createChildLoadable( weight:Number = 1, id:String = null ):IProgress;
		
		/**
		 * Add a child IProgress instance to a child list of this item
		 * 
		 * @param progress IProgress to add
		 */ 
		function addChildLoadable( progress:IProgress ):void;
		
		/**
		 * Retrieve a child progress instance by it's ID
		 * 
		 * @param id ID to search for
		 * @return IProgress instance retrieved. undefined if not a valid child 
		 * 					 instance
		 */ 
		function retrieveChildLoadable( id:String ):IProgress;
			
		/**
		 * Check to see if the provided <code>IProgress</code> instance is a
		 * direct child or not.
		 * 
		 * @param id ID to search for
		 * @return Boolean
		 */ 
		function isChildLoadable( instance:IProgress ):Boolean;
		
		/**
		 * Checks to see if this current <code>IProgress</code> instance has 
		 * any child <code>IProgress</code> instances.
		 * 
		 * @return Boolean
		 */ 
		function hasChildLoadables():Boolean;
		
		/**
		 * Remove a child progress instance by it's ID
		 * 
		 * @param id ID to search for
		 * @return Boolean <code>true</code> if removed successfully
		 */ 
		function removeChildLoadableById( id:String ):Boolean;
		
		/**
		 * Remove a child progress instance
		 * 
		 * @param progress IProgress to search for
		 * @return Boolean <code>true</code> if removed successfully
		 */ 
		function removeChildLoadable( progress:IProgress ):Boolean;
		
		/**
		 * Destroy the progress instance
		 */		
		function destroy():void;
		
		/**
		 * Forces progress to complete itself. This is useful, for example,
		 * if an error with high enough severity has occured.
		 */
		function forceQuit():void;
		
		/**
		 * Set the item loaded amount, value from 0-1. If there are child 
		 * progress instances attached this to this item, this 
		 * method is ignored. 
		 * 
		 * @param amount Amount to set
		 */ 
		function setAmountLoaded( amount:Number ):void;
		
		/** 
		 * Returns the total amount loaded of either this item
		 * or all child instances attached
		 * 
		 * @return Number Total amount loaded 
		 */
		function getAmountLoaded():Number;
		
		/** 
		 * @return Number Weight of item 
		 */
		function getWeight():Number;
		
		/**
		 * Set the unique ID for the progress item
		 * 
		 * @param id ID to set
		 */ 
		function setId( id:String ):void;
		
		/** 
		 * @return String ID of the progress item 
		 */
		function getId():String;
	}
}