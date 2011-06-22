package as3bootstrap.common.progress
{	
	import flash.utils.Dictionary;
	
	/**
	 * Singleton progress manager providing access to current load easily to 
	 * during all points of load. This is required in some cases because being 
	 * able to track load may not available at all points throughout loading 
	 * processes. For example, during the Flex Application SWF load.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange
	 */ 
	public class ProgressManager 
		extends Progress
		implements IProgress
	{
		/**
		 * ERROR CONSTANTS
		 */ 
		private static const ERROR_INCORRECT_INITIALIZATION : String = "ProgressManager must be initialized through the static method getInstance()";
		
		/**
		 * Singleton instance 
		 */
		private static var instance : ProgressManager;
		
		/**
		 * Singleton enforcer 
		 */
		private static var initialize : Boolean;
		
		/**
		 * Dictionary reference to all progress items being tracked 
		 */
		private var dict : Dictionary;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/** 
		 * Returns the current instance of the LoadManager. If
		 * the LoadManager has not be initialized yet, then we
		 * initialize the class and return it
		 * 
		 * @return LoadManager instance 
		 */
		public static function getInstance():ProgressManager 
		{
			if( !instance ) 
			{
				initialize = true;
				instance = new ProgressManager();
				initialize = false;
			} 
			return instance;
		}
		
		/** 
		 * Constructor. Only called once while the initialize 
		 * property is set to true 
		 */
		public function ProgressManager() 
		{
			if( initialize ) 
			{
				super();
				dict = new Dictionary( true );
			} else {
				throw new Error( ERROR_INCORRECT_INITIALIZATION );
			} 	
		}
		
		/** 
		 * Disposes all progress items 
		 */
		public function dispose():void 
		{
		}
		
		//----------------------------------
		//  Override
		//----------------------------------
		
		/** 
		 * Override of Progress class add child loadable method. Any object
		 * we add as a child in this case, also gets added to the dictionary
		 * 
		 * @param progress IProgress instance to add
		 */ 
		override public function addChildLoadable( progress:IProgress ):void 
		{
			super.addChildLoadable( progress );
			addToDictionary( progress );
		}
		
		/**
		 * Retrieves a loadable child from the dictionary
		 * 
		 * @param id String ID used to retrieve
		 * 
		 * @return IProgress IProgress instance retrieved
		 */ 
		override public function retrieveChildLoadable( id:String ):IProgress 
		{
			return dict[id] as IProgress;
		}
		
		//---------------------------------------------------------------------
		//
		//  Private methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * @private
		 * Adds a progress item to the dictionary 
		 * 
		 * @param progress IProgress instance to add 
		 */ 
		private function addToDictionary( progress:IProgress ):void 
		{
			dict[progress.getId()] = progress;
		}
	}
}