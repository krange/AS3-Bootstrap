package as3bootstrap.common.constants
{
	/**
	 * Constants for Bootstrap PureMVC based applications.
	 * 
	 * @author krisrange
	 */ 
	public class BootstrapConstants
	{
		//---------------------------------------------------------------------
		//
		//  FLASH VARS PARAMS
		//
		//---------------------------------------------------------------------
		
		/** 
		 * Base URL parameter. This is used to load all assets within an 
		 * application so that you move all data to different development 
		 * environments without having to modify individual URLs. This also 
		 * helps facilitate with CDN loading as assets.
		 */
		public static const FLASH_VARS_BASE_URL					:String = "baseUrl";
		
		/** 
		 * Config XML Base URL parameter. Similiar to base URL except for that 
		 * it applies to the config XML file. This is so that you can specify a 
		 * different URL for this file, or none at all
		 */
		public static const FLASH_VARS_CONFIG_XML_BASE_URL		:String = "configXmlBaseUrl";
		
		/**
		 * Config XML parameter. URL parameter for where to load the 
		 * configuration XML file.
		 */
		public static const FLASH_VARS_CONFIG_XML_URL			:String = "configXmlUrl";
		
		/**
		 * Locale and Lang parameters. This helps with localizations of 
		 * different regions and languages		
		 */ 
		public static const FLASH_VARS_LOCALE					:String = "locale";
		public static const FLASH_VARS_LANG						:String = "lang";
		
		//---------------------------------------------------------------------
		//
		//  Error constants
		//
		//---------------------------------------------------------------------
		
		/**
		 * Error retrieving the application mediator 
		 */		
		public static const ERROR_GET_APP_MEDIATOR				:String = "Mediator for this Application or Module was not set. The getApplicationMediator() method was not overriden."; 
		
		/**
		 * Error registering the application mediator 
		 */		
		public static const ERROR_REGISTER_APP_MEDIATOR			:String = "The mediator provided either did not implement IBootstrapMediator or the Constructor did not take the 2 correct arguments."; 
		
		/**
		 * Error registering the config model 
		 */		
		public static const ERROR_REGISTER_CONFIG_MODEL			:String = "The class specified in the getConfigModel() method doesn't implement IBootstrapConfigModel.";
		
		/**
		 * Error registering the localization model 
		 */		
		public static const ERROR_REGISTER_LOCALIZATION_MODEL	:String = "The class specified in the getLocalizationModel() method doesn't implement IBootstrapLocalizationModel.";
		
		/**
		 * Error registering the stylesheet model 
		 */		
		public static const ERROR_REGISTER_STYLESHEET_MODEL		:String = "The class specified in the getStylesheetModel() method doesn't implement IBootstrapStylesheetModel";
		
		/**
		 * Error registering the font model 
		 */		
		public static const ERROR_REGISTER_FONT_MODEL			:String = "The class specified in the getFontModel() method doesn't implement IBootstrapFontModel";
		
		/**
		 * Error retrieving the flash vars 
		 */		
		public static const ERROR_RETRIEVE_FLASH_VARS			:String = "The getFlashVarsParams method must be override with a parameter value.";
		
		/**
		 * Error adding a custom external resource 
		 */
		public static const ERROR_ADD_CUSTOM_EXTERNAL_RESOURCE	:String = "Adding external resources at this point is not allowed.";
	}
}