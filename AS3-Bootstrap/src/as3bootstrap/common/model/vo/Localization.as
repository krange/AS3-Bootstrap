package as3bootstrap.common.model.vo
{
	import mx.resources.IResourceBundle;
	import mx.resources.ResourceBundle;
	
	/**
	 * Localization value object. Provides lookup on an
	 * internal XML reference for localized content. The format 
	 * of this XML file should look like the following.
	 * 
	 * @author krisrange
	 * @author Ward Ruth
	 */ 
	public class Localization
		implements ILocalization
	{
		/** 
		 * Dictionary map type object for storing localized values by key
		 * for ease of lookup
		 */
		private var _dictionary : Object = new Object();
		private var _resourceBundles : Object = new Object();
		
		private var _lang : String;
		private var _locale : String;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/** 
		 * Constructor
		 * 
		 * @param data	an XML object containing the data nodes
		 */
		public function Localization( data:XML = null )
		{ 
			if( data )
			{
				addLocalizedValues( data );
			}
		}
		
		/**
		 * Add localized data values to the vo. If a previous value has been
		 * defined for a key value, it will be replaced.
		 * 
		 * @param data A XML object containing localized elements to add to 
		 * 			   the VO
		 */ 
		public function addLocalizedValues( data:XML ):void
		{
			var children : XMLList = data.*;
			for each( var child : XML in children )
			{
				_dictionary[ child.name().localName ] = child.toString();
			}
		}
		
		/**
		 * Lookup a value by its name
		 * 
		 * @param name 	a name or key to look up a localized value by
		 * @return 		String Value returned, null if nothing was found
		 */ 
		public function getLocalizedValue( name:String ):String
		{
			return _dictionary[ name ];			
		}
		
		/**
		 * Factory type method for creating named resource bundles on the fly
		 * from this LocalizationVO instance.
		 * 
		 * @param name	a name for the returned ResourceBundle, such as 
		 * 				"validators".
		 * @return		an <code>IResourceBundle</code>
		 * @throws		an Error if lang or locale is not defined
		 */
		public function getResourceBundle( name:String ):IResourceBundle
		{
			//
			//	:KLUDGE:
			//	this is a less than optimal workaround for a couple of reasons.
			//	For one, it would have been better to create lightweight proxy
			//	objects that would point back to this LocalizationVO's 
			//	dictionary. I had thought this would be possible by having these
			//	proxies implement IResourceBundle themselves. Sadly, deep inside
			//	Adobe's ResourceManaagerImpl class (line 534 in SDK 3.3.0), a
			//	reference to ResourceBundle is referenced, instead of the
			//	interface :-(. So I have to create real ResourceBundle objects
			//	here, which means copying the string values from the vo to the
			//	bundle object.
			//	Second, currently *all* the localization values on this VO are
			//	copied to the ResourceBundle. Ideally LocalizationVO and its
			//	underlying xml data source would provide some mechanism for
			//	a parallel segmentation of the locale values, maybe using nested
			//	elements in the xml. Then only the values corresponding to the
			//	requested name would be copied. Something that could be
			//	implemented in a future version of this class, perhaps.
			//	
			//	[wr 8.13.09]
			//
			
			if( ! lang || ! locale )
			{
				throw new Error( "lang and locale need to be assigned to LocalizationVO in order to create a resource bundle" );
			}
			
			if( _resourceBundles[ name ] )
			{
				return _resourceBundles[ name ] as IResourceBundle;
			} 
			else 
			{
				var resourceBundle : IResourceBundle = new ResourceBundle( lang + "_" + locale, name );
				var resourceBundleContent : Object = resourceBundle.content;
				
				for( var name : String in _dictionary )
				{
					resourceBundleContent[ name ] = _dictionary[ name ];
				}
				
				_resourceBundles[ name ] = resourceBundle;
				return resourceBundle;
			}
		}
		
		/**
		 * Destroy the service
		 */		
		public function destroy():void
		{
			_dictionary = null;
			_resourceBundles = null;
		}

		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		public function get lang():String
		{
			return _lang;
		}

		public function set lang( value:String ):void
		{
			_lang = value;
		}

		public function get locale():String
		{
			return _locale;
		}

		public function set locale( value:String ):void
		{
			_locale = value;
		}
	}
}