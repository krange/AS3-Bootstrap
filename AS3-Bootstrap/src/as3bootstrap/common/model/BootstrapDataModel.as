package as3bootstrap.common.model
{
	import as3bootstrap.common.progress.IProgress;
	import as3bootstrap.common.services.xml.IXmlService;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import org.osflash.signals.ISignalOwner;
	import org.osflash.signals.Signal;
	
	/**
	 * Main model for bootstrap
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange 
	 */
	public class BootstrapDataModel 
		extends EventDispatcher
		implements IBootstrapModel
	{
		private var _progress : IProgress;
		
		private var _locale : String;
		private var _lang : String;
		private var _resourceBaseUrl : String;
		
		//----------------------------------
		//  Signals
		//----------------------------------
		
		private var _loaded : ISignalOwner;
		private var _errored : ISignalOwner;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 * 
		 * @param progress <code>IProgress</code> instance
		 */
		public function BootstrapDataModel( progress:IProgress )
		{
			_progress = progress;
			super( null );
			init();
		}
		
		//----------------------------------
		//  Override
		//----------------------------------
		
		//---------------------------------------------------------------------
		//
		//  Protected methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * @private 
		 * Initialize the model
		 */		
		protected function init():void
		{
			_loaded = getLoadedSignal();
			_errored = getErroredSignal();
		}
		
		/**
		 * Sugar method to replace any set lang and locale values in a specified
		 * string value. Does not modify the original String parameter.
		 *  
		 * @param stringToChange A String to search through
		 * 
		 * @return A new modified String
		 */		
		protected function searchAndReplaceLangAndLocale( stringToChange:String ):String
		{
			var newString : String = stringToChange;
			
			// Search and replace the lang value if it exists
			if( lang &&
				lang.length > 0 )
			{
				newString = newString.replace( /{lang}/g, lang );
			}
			
			// Search and replace the locale value if it exists
			if( locale &&
				locale.length > 0 )
			{
				newString = newString.replace( /{locale}/g, locale );
			}
			
			return newString;
		}
		
		//----------------------------------
		//  Instantations
		//----------------------------------
		
		/**
		 * 
		 * @return <code>ISignalOwner</code> 
		 */		
		protected function getLoadedSignal():ISignalOwner
		{
			return new Signal();
		}
		
		/**
		 * 
		 * @return <code>ISignalOwner</code> 
		 */		
		protected function getErroredSignal():ISignalOwner
		{
			return new Signal();
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Signal which is dispatched when the model has loaded 
		 */
		public function get loaded():ISignalOwner
		{
			return _loaded;
		}
		
		/**
		 * Signal which is dispatched when the model has errored
		 */
		public function get errored():ISignalOwner
		{
			return _errored;
		}
		
		/**
		 * The flashvars locale, if available, of the application
		 *  
		 * @return String
		 */		
		public function get locale():String
		{
			return _locale;
		}
		public function set locale( value:String ):void
		{
			_locale = value;
		}
		
		/**
		 * The flashvars lang, if available, of the application
		 *  
		 * @return String
		 */	
		public function get lang():String
		{
			return _lang;
		}
		public function set lang( value:String ):void
		{
			_lang = value;
		}
		
		/**
		 * The resouce base URL, if available, of the application
		 *  
		 * @return String
		 */	
		public function get resourceBaseUrl():String
		{
			return _resourceBaseUrl;
		}
		public function set resourceBaseUrl( value:String ):void
		{
			_resourceBaseUrl = value;
		}
		
		//----------------------------------
		//  ITrackableResource
		//----------------------------------
		
		/**
		 * Get the <code>IProgress</code> instance
		 * 
		 * @return <code>IProgress</code>
		 */
		public function get progress():IProgress
		{
			return _progress;
		}
		
		/**
		 * Set the <code>IProgress</code> instance
		 * 
		 * @param value <code>IProgress</code> instance to set
		 */	
		public function set progress( value:IProgress ):void
		{
			_progress = value;
		}
	}
}