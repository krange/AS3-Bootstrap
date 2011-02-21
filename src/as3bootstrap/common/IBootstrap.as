package as3bootstrap.common
{
	import as3bootstrap.common.model.IBootstrapConfigModel;
	import as3bootstrap.common.model.IBootstrapFontModel;
	import as3bootstrap.common.model.IBootstrapLocalizationModel;
	import as3bootstrap.common.model.IBootstrapStylesheetModel;
	import as3bootstrap.common.progress.IProgress;
	
	import org.osflash.signals.ISignalOwner;

	/**
	 * IBootstrap
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange 
	 */
	public interface IBootstrap
	{
		/**
		 * Startup bootstrap by loading the configuration XML url. Calling this 
		 * method will also disallow adding any custom external loads to 
		 * bootstrap. See the <code>addCustomLoadResource</code> method for 
		 * more information.
		 * 
		 * @param $parameters Root level LoaderInfo parameters object
		 */		
		function start( $parameters:Object ):void;
		
		/**
		 * A convienence method to add a load resource to our data load
		 * progress (dataProgress). This is helpful in the case that you want to 
		 * easily tie in additional custom load resources.
		 * 
		 * <p>Note: If adding a custom resource, the developer is responsible to 
		 * keeping of track of the provided reference and setting its progress 
		 * amounts.</p>
		 * 
		 * <p>This method can be called at any point before start() is called, 
		 * though afterwards a runtime Error will be thrown.</p>
		 * 
		 * @param $externalProgress IProgress instance
		 */		
		function addCustomLoadResource( $externalProgress:IProgress ):void;
		
		/** 
		 * Application load progress instance. This is the top level progress
		 * instance.
		 */
		function get progress():IProgress;
		
		/**
		 * <code>IProgress</code> instance for tracking the data portion of 
		 * loading. Must be a direct child of <code>_appProgress</code>
		 */		
		function get dataProgress():IProgress;
		
		/**
		 * <code>IProgress</code> instance for tracking the view portion of 
		 * loading. Must be a direct child of <code>_appProgress</code>
		 */		
		function get viewProgress():IProgress;
		
		/**
		 * <code>IBootstrapConfigModel</code> instance for loading and storing 
		 * the configuration model data
		 */
		function get configModel():IBootstrapConfigModel;
		
		/**
		 * <code>IBootstrapLocalizationModel</code> instance for loading and 
		 * storing the localization model data
		 */
		function get localizationModel():IBootstrapLocalizationModel;
		
		/**
		 * <code>IBootstrapStylesheetModel</code> instance for loading and 
		 * storing the stylesheet model data
		 */
		function get stylesheetModel():IBootstrapStylesheetModel;
		
		/**
		 * <code>IBootstrapFontModel</code> instance for loading and 
		 * storing the stylesheet model data
		 */
		function get fontModel():IBootstrapFontModel;
		
		/**
		 * Application loaded signal
		 * 
		 * @return <code>ISignalOwner</code> 
		 */		
		function get appLoaded():ISignalOwner;
		
		/**
		 * Data loaded signal
		 * 
		 * @return <code>ISignalOwner</code> 
		 */	
		function get dataLoaded():ISignalOwner;
		
		/**
		 * Bootstrap loaded signal
		 * 
		 * @return <code>ISignalOwner</code> 
		 */	
		function get bootstrapLoaded():ISignalOwner;
		
		/**
		 * Config XML loaded signal
		 * 
		 * @return <code>ISignalOwner</code> 
		 */	
		function get configLoaded():ISignalOwner;
		
		/**
		 * Config XML errored signal
		 * 
		 * @return <code>ISignalOwner</code> 
		 */	
		function get configErrored():ISignalOwner;
		
		/**
		 * Bootstrap resource errored signal
		 * 
		 * @return <code>ISignalOwner</code> 
		 */
		function get bootstrapResourceErrored():ISignalOwner;
	}
}