package as3bootstrap.common.utils
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
 	 * Provides the ability to keep track of external resources that are 
	 * loading. Dependencies can be added, retrieved and removed and once all 
	 * dependencies are met, an Event.COMPLETE is dipatched.
 	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange
	 */ 
	public class Dependency 
		extends EventDispatcher
	{
		/** 
		 * Holds current dependencies being tracked 
		 */
		private var _dependencies : Array;
		
		/** 
		 * Reference to class this dependency is tracking 
		 */
		private var _cName : String;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/** 
		 * Constructor
		 * 
		 * @param $name Name of the dependency tracker
		 */ 
		public function Dependency( $name:String = null )
		{
			_cName = $name;
			_dependencies = new Array();
		}
		
		/**
		 * Add a dependency
		 * 
		 * @param $key Dependency to be added
		 */ 
		public function addDependancy( $key:Object ):void
		{
			_dependencies.push( $key );
		}
		
		/**
		 * Retrieves a dependency
		 * 
		 * @param $key Dependency to be retrieved
		 */ 
		public function retrieveDependency( $key:Object ):Object
		{
			var count : Number = _dependencies.length;
			while( count-- ) 
			{
				if ( _dependencies[count] == $key ) 
				{
					return _dependencies[count];
					break;
				}
			}
			return null;
		}
		
		/**
		 * @return Contents of dependencies array
		 */ 
		public function retrieveAllDependencies():Array
		{
			return _dependencies;
		}
		
		/**
		 * Sets a dependency as loaded and calls checkDependenciesLoaded()
		 * to check if other dependencies are still loading
		 * 
		 * @param $key Dependency to be removed
		 */ 
		public function setLoadDependencyMet( $key:Object ):void
		{
			var count : Number = _dependencies.length;
			while( count-- ) 
			{
				if ( _dependencies[count] == $key ) 
				{
					_dependencies.splice( count, 1 );
					break;
				}
			}
			checkDependenciesLoaded();
		}
		
		/**
		 * Checks a dependency to see if it has loaded
		 * 
		 * @param $key Dependency tracked item to check
		 * 
		 * @return Boolean value on whether value exists or not
		 */ 
		public function checkDependency( $key:Object ):Boolean
		{
			var count : Number = _dependencies.length;
			while( count-- ) 
			{
				if ( _dependencies[count] == $key ) 
				{
					return true;
				}
			}
			return false;
		}
		
		//---------------------------------------------------------------------
		//
		//  Protected methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Checks if all dependencies have been loaded. If so,
		 * dispatch a COMPLETE Event. 
		 */ 
		protected function checkDependenciesLoaded():void
		{
			if( _dependencies.length == 0 ) 
			{
				dispatchEvent( new Event( Event.COMPLETE ) );
			}
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Get current dependencies
		 * 
		 * @return Array Dependencies array
		 */		
		public function get dependencies():Array
		{
			return _dependencies;
		}
	}
}