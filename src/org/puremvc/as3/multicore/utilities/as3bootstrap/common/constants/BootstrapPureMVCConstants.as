package org.puremvc.as3.multicore.utilities.as3bootstrap.common.constants
{
	/**
	 * BootstrapPureMVCConstants
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange 
	 */
	public class BootstrapPureMVCConstants
	{
		//---------------------------------------------------------------------
		//
		//  STARTUP LOAD PARAMS
		//
		//---------------------------------------------------------------------
		
		/**
		 * Notification sent out when the application load has completed. This 
		 * complete does not include any view loading, only the startup 
		 * processes of xml, fonts, css and localization
		 */ 
		public static const APPLICATION_LOAD_COMPLETE 					:String = "applicationLoadComplete";
		
		/**
		 * Notification sent out when the data load of the progress has 
		 * completed. This complete does not include any view loading, only 
		 * the startup processes of xml, fonts, css and localization and any
		 * custom data that has been added seperate from the bootstrap loading.
		 */ 
		public static const DATA_LOAD_COMPLETE		 					:String = "dataLoadComplete";
		
		/**
		 * Notification sent out when the startup load has completed. This 
		 * complete does not include any view loading, only the startup 
		 * processes of xml, fonts, css and localization
		 */ 
		public static const BOOTSTRAP_LOAD_COMPLETE 					:String = "bootstrapLoadComplete";
		
		/**
		 * Notification sent out when the any of the loading assets during the
		 * bootstrap load has errored. This includes xml, fonts, css and
		 * localization.
		 */ 
		public static const BOOTSTRAP_LOAD_ERROR						:String = "bootstrapLoadError";
		
		/** 
		 * Configuration load complete/fail constants 
		 */
		public static const BOOTSTRAP_CONFIG_LOAD_COMPLETE				:String = "bootstrapConfigLoadComplete";
		public static const BOOTSTRAP_CONFIG_LOAD_FAIL					:String = "bootstrapConfigLoadFail";
	}
}