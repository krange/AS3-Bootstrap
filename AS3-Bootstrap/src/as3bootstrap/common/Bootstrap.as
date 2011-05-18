package as3bootstrap.common
{
	import as3bootstrap.common.constants.BootstrapConstants;
	import as3bootstrap.common.events.ResourceProgressEvent;
	import as3bootstrap.common.model.BootstrapConfigModel;
	import as3bootstrap.common.model.BootstrapFontModel;
	import as3bootstrap.common.model.BootstrapLocalizationModel;
	import as3bootstrap.common.model.BootstrapStylesheetModel;
	import as3bootstrap.common.model.IBootstrapConfigModel;
	import as3bootstrap.common.model.IBootstrapFontModel;
	import as3bootstrap.common.model.IBootstrapLocalizationModel;
	import as3bootstrap.common.model.IBootstrapStylesheetModel;
	import as3bootstrap.common.progress.IProgress;
	import as3bootstrap.common.progress.Progress;
	
	import flash.events.Event;
	
	import org.osflash.signals.ISignalOwner;
	import org.osflash.signals.Signal;
	
	/**
	 * Bootstrap
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange 
	 */
	public class Bootstrap
		implements IBootstrap
	{
		/**
		 * @private
		 * Boolean to determine if adding external load resources is allowed at 
		 * this point in the application or not. The structure is strict in 
		 * order to enforce proper progress instance tracking. Currently, there 
		 * are 2 points where this is currently allowed:
		 * 
		 * <p>The first is right after instance construction but before the
		 * <code>start</code> method is called.</p>
		 * 
		 * <p>The second is right after the configuration XML file is loaded but
		 * before any of the subseqent bootstrap resources are started.</p>
		 */		
		private var _customExternalLoadAllowed : Boolean = true;
		
		/**
		 * @private
		 * Boolean to determine if this boostrap instance has already started 
		 * its load. Since starting it a second time would interfere with the 
		 * loading process, currently the <code>start</code> method is only 
		 * allowed to be called once.
		 */		
		private var _started : Boolean;
		
		/**
		 * Base URL for which all resource will load from, excluding the 
		 * configuration XML. This is helpful for resource files that may exist
		 * in a seperate URL than the SWF or even the configuration XML. 
		 * 
		 * <p>The default value is an empty string so that it will not affect 
		 * any static URLs that may be sent into Bootstrap.</p> 
		 */		
		private var _resourceBaseUrl : String = "";
		
		//----------------------------------
		//  Model declarations
		//----------------------------------
		
		private var _configModel : IBootstrapConfigModel;
		private var _localizationModel : IBootstrapLocalizationModel;
		private var _stylesheetModel : IBootstrapStylesheetModel;
		private var _fontModel : IBootstrapFontModel;
		
		//----------------------------------
		//  IProgress declarations
		//----------------------------------
		
		private var _progress : IProgress;
		private var _dataProgress : IProgress;
		private var _viewProgress : IProgress;
		private var _bootstrapProgress : IProgress;
		private var _bootstrapUnknownProgress : IProgress;
		private var _configProgress : IProgress;
		private var _localizationProgress : IProgress;
		private var _stylesheetProgress : IProgress;
		private var _fontProgress : IProgress;
		private var _customDataProgress : IProgress;
		
		//----------------------------------
		//  Signals
		//----------------------------------
		
		private var _appLoaded : ISignalOwner = new Signal();
		private var _dataLoaded : ISignalOwner = new Signal();
		private var _bootstrapLoaded : ISignalOwner = new Signal();
		private var _configLoaded : ISignalOwner = new Signal();
		private var _configErrored : ISignalOwner = new Signal( Event );
		private var _bootstrapResourceErrored : ISignalOwner = new Signal( Event );
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 * 
		 * @param progress  	Top level app <code>IProgress</code> instance.
		 * 						Optional but required if specifying data or
		 * 						view <code>IProgress</code> instances. 
		 * @param dataProgress Child <code>IProgress</code> instance of 
		 * 						<code>appProgress</code> which tracks data
		 * 					   	loading. Optional.
		 * @param viewProgress Child <code>IProgress</code> instance of 
		 * 						<code>appProgress</code> which tracks view
		 * 						loading. Optional.
		 */		
		public function Bootstrap(
			progress:IProgress = null, 
			dataProgress:IProgress = null, 
			viewProgress:IProgress = null )
		{
			// Set our progress instances
			_progress = progress;
			_dataProgress = dataProgress;
			_viewProgress = viewProgress;
			
			init();
		}
		
		/**
		 * Startup bootstrap by loading the configuration XML url. Calling this 
		 * method will also disallow adding any custom external loads to 
		 * bootstrap. See the <code>addCustomLoadResource</code> method for 
		 * more information.
		 * 
		 * @param parameters Root level LoaderInfo parameters object
		 */		
		public function start( parameters:Object ):void
		{
			if( !_started )
			{
				_started = true;
				_customExternalLoadAllowed = false;
				var configUrl : String;
				
				// Add event listeners
				bootstrapProgress.addEventListener( ResourceProgressEvent.PROGRESS, onBootstrapProgressUpdate, false, 0, true );
				
				if( parameters )
				{
					_resourceBaseUrl = parameters.baseUrl;
					// Load the config
					configUrl = parameters.configXmlUrl;
				}
				
				loadConfig( configUrl );
			}
			// TODO: Throw an error here that start has already been run
		}
		
		/**
		 * A convienence method to add a load resource to our data load
		 * progress (dataProgress). This is helpful in the case that you want to 
		 * easily tie in additional custom load resources.
		 * 
		 * <p>Note: If adding a custom resource, the developer is responsible to 
		 * keeping of track of the provided reference and setting its progress 
		 * amounts.</p>
		 * 
		 * <p>This method can be called at any point before start() is called or
		 * directly after the <code>configLoaded</code> 
		 * <code>ISignalOwner</code> is dispatched. Anytime afterwards,.</p>
		 * 
		 * @param externalProgress IProgress instance
		 * 
		 * @return Boolean Return true if load resource was added. Return
		 * 				   false if load resource was not added.
		 */		
		public function addCustomLoadResource( externalProgress:IProgress ):Boolean
		{
			// Make sure we can add a custom external load
			if( _customExternalLoadAllowed )
			{
				if( progress && dataProgress && customDataProgress )
				{
					// Add the new external resource to our total load
					customDataProgress.addChildLoadable( externalProgress );
					
					// If the custom data load progress isnt a child progress 
					// of the data progress, then add it
					if( !dataProgress.isChildLoadable( customDataProgress ) )
					{
						dataProgress.addChildLoadable( customDataProgress );
						return true;
					}
				}
			}
			
			// Custom load resource is not allowed at this point
			return false;
		}
		
		//---------------------------------------------------------------------
		//
		//  Protcected methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * @private
		 * Initialize the bootstrap processes.
		 */		
		protected function init():void
		{
			setupLoadProgress();
			setupModels();
		}
		
		/**
		 * @private
		 * Set up the initial load progress structure.
		 */		
		protected function setupLoadProgress():void 
		{
			// If we do not have an appProgress instance, we will create our own
			// progress structure. If a view or data instance is provided in 
			// the constructor, we will override them and create our own so that
			// progress loading is connected correctly
			if( !_progress )
			{
				// Add app level specific progress
				_progress = getProgress();
				_dataProgress = getDataProgress();
				_viewProgress = getViewProgress();
				progress.addChildLoadable( dataProgress );
				progress.addChildLoadable( viewProgress );
			}
			else 
			{
				// Either the data progress does not exist or it is not a direct
				// child IProgress instance of the application progress, so we
				// should create a new instance
				if( !progress.isChildLoadable( dataProgress ) )
				{
					_dataProgress = getDataProgress();
					progress.addChildLoadable( dataProgress );
					// TODO: Dispatch warning to developer that this is the case
				}
				 
				// Either the view progress does not exist or it is not a direct
				// child IProgress instance of the application progress, so we
				// should create a new instance
				if( !progress.isChildLoadable( viewProgress ) )
				{
					_viewProgress = getViewProgress();
					progress.addChildLoadable( viewProgress );
					// TODO: Dispatch warning to developer that this is the case
				}	
			}
			
			// Create data level specific progress
			_bootstrapProgress = getBootstrapProgress();
			_customDataProgress = getCustomDataProgress();
			
			// Create bootstrap level specific progress
			_configProgress = getConfigProgress();
			_bootstrapUnknownProgress = getBootstrapUnknownProgress();
			_localizationProgress = getLocalizationProgress();
			_stylesheetProgress = getStylesheetProgress();
			_fontProgress = getFontProgress();
			
			// Only add the config and unknown progress for bootstrap because 
			// at this point these are the only resources we know we need to 
			// load. We will add the other progresses after the config file has 
			// loaded if needed
			dataProgress.addChildLoadable( bootstrapProgress );
			bootstrapProgress.addChildLoadable( configProgress );
			bootstrapProgress.addChildLoadable( bootstrapUnknownProgress );
		}
		
		/**
		 * @private
		 * Set up the data models for bootstrap. This includes the
		 * configuration, stylesheet, font and localization classes.
		 */		
		protected function setupModels():void
		{
			// Setup the config model
			var ConfigModelClass : Object = getConfigModel();
			_configModel = new ConfigModelClass( configProgress );
			if( !_configModel ) 
			{
				throw new Error( BootstrapConstants.ERROR_REGISTER_CONFIG_MODEL );	
			}
			
			// Setup the localization model
			var LocalizationModelClass : Object = getLocalizationModel();
			_localizationModel = new LocalizationModelClass( localizationProgress );
			if( !_localizationModel ) 
			{
				throw new Error( BootstrapConstants.ERROR_REGISTER_LOCALIZATION_MODEL );	
			}
			
			// Setup the stylesheet model
			var StylesheetModelClass : Object = getStylesheetModel();
			_stylesheetModel = new StylesheetModelClass( stylesheetProgress );
			if( !_stylesheetModel ) 
			{
				throw new Error( BootstrapConstants.ERROR_REGISTER_STYLESHEET_MODEL );	
			}
			
			// Setup the font model
			var FontModelClass : Object = getFontModel();
			_fontModel = new FontModelClass( fontProgress );
			if( !_fontModel ) 
			{
				throw new Error( BootstrapConstants.ERROR_REGISTER_FONT_MODEL );	
			}
		}
		
		/**
		 * @private
		 * Add the localizations to the bootstrap load. This method is called 
		 * after the config file has loaded
		 */		
		protected function addLocalizations():Boolean 
		{
			var locXml : XMLList = configModel.localizations;
			if( locXml && 
				locXml.length() > 0 )
			{
				bootstrapUnknownProgress.addChildLoadable( localizationProgress );
				return true;
			}
			return false;
		}
		
		/**
		 * @private
		 * Add the stylesheets to the bootstrap load. This method is called 
		 * after the config file has loaded
		 */		
		protected function addStylesheets():Boolean 
		{
			var ssXml : XMLList = configModel.stylesheets;
			if( ssXml && 
				ssXml.length() > 0 )
			{
				bootstrapUnknownProgress.addChildLoadable( stylesheetProgress );
				return true;
			}
			return false;
		}
		
		/**
		 * @private
		 * Add fonts to the progress load structure, if available 
		 */		
		protected function addFonts():void
		{
			// Add fonts to the bootstrap load if any exist
			if( configModel.fonts && 
				configModel.fonts.length() > 0 )
			{
				bootstrapUnknownProgress.addChildLoadable( fontProgress );
			}
		}
		
		/**
		 * @private
		 * Load the config file
		 * 
		 * @param url String
		 */		
		protected function loadConfig( url:String ):void
		{
			configModel.errored.add( onConfigErrored );
			configModel.loaded.add( onConfigLoaded );
			configModel.load( url );
		}
		
		/**
		 * @private 
		 * Load the localization data
		 */		
		protected function loadLocalizations():void
		{
			var locXml : XMLList = configModel.localizations;
			if( locXml && 
				locXml.length() > 0 )
			{
				localizationModel.loaded.add( onLocalizationLoaded );
				localizationModel.errored.add( onLocalizationErrored );
				localizationModel.load( locXml );
			}
		}
		
		/**
		 * @private 
		 * Load the stylesheet data
		 */		
		protected function loadStylesheets():void
		{
			var ssXml : XMLList = configModel.stylesheets;
			if( ssXml && 
				ssXml.length() > 0 )
			{
				stylesheetModel.loaded.add( onStylesheetLoaded );
				stylesheetModel.errored.add( onStylesheetErrored );
				stylesheetModel.load( ssXml );
			}
		}
		
		/**
		 * @private
		 * Load the fonts, if available
		 */		
		protected function loadFonts():void
		{
			// Add fonts to the bootstrap load if any exist
			if( configModel.fonts && 
				configModel.fonts.length() > 0 )
			{
				fontModel.errored.add( onFontsErrored );
				fontModel.loaded.add( onFontsLoaded );
				fontModel.load( configModel.fonts );
			}
		}
		
		//----------------------------------
		//  Handlers
		//----------------------------------
		
		/**
		 * @private
		 * Signal callback for when the config file errors
		 * 
		 * @param event Event
		 */		
		protected function onConfigErrored( event:Event ):void
		{
			configErrored.dispatch( event );
		}
		
		/**
		 * @private
		 * Signal callback for when the config file has loaded 
		 */		
		protected function onConfigLoaded():void
		{	
			_customExternalLoadAllowed = true;
			
			// Dispatch that the config file has loaded
			configLoaded.dispatch();
			
			// Disallow external loads
			_customExternalLoadAllowed = false;
			
			// Add any additional loads
			// TODO: Add functionality to allow the user to pause the bootstrap
			// load process after these add steps
			if( addStylesheets() || 
				addLocalizations() || 
				addFonts() )
			{
				loadStylesheets();
				loadLocalizations();
				loadFonts();
			}
			// We aren't loading anything else in our configuration XML file
			// so complete the load process for any bootstrap loads
			else
			{
				bootstrapUnknownProgress.setAmountLoaded( 1 );
			}
		}
		
		/**
		 * @private
		 * Signal callback for when the localization model load errors
		 * 
		 * @param event Event
		 */		
		protected function onLocalizationErrored( event:Event ):void
		{
			localizationModel.errored.removeAll();
			localizationModel.loaded.removeAll();
			
			// Forward the event
			bootstrapResourceErrored.dispatch( event );
		}
		
		/**
		 * @private
		 * Signal callback for when the localization model has loaded 
		 */		
		protected function onLocalizationLoaded():void
		{
			localizationModel.errored.removeAll();
			localizationModel.loaded.removeAll();
		}
		
		/**
		 * @private
		 * Signal callback for when the stylesheet model load errors
		 * 
		 * @param event Event
		 */		
		protected function onStylesheetErrored( event:Event ):void
		{
			stylesheetModel.errored.removeAll();
			stylesheetModel.loaded.removeAll();
			
			// Forward the event
			bootstrapResourceErrored.dispatch( event );
		}
		
		/**
		 * @private
		 * Signal callback for when the stylesheet model has loaded 
		 */		
		protected function onStylesheetLoaded():void
		{
			stylesheetModel.errored.removeAll();
			stylesheetModel.loaded.removeAll();
		}
		
		/**
		 * @private
		 * Signal callback for when the fonts model load errors
		 * 
		 * @param event Event
		 */		
		protected function onFontsErrored( event:Event ):void
		{
			fontModel.errored.removeAll();
			fontModel.loaded.removeAll();
			
			// Forward the event
			bootstrapResourceErrored.dispatch( event );
		}
		
		/**
		 * @private
		 * Signal callback for when the fonts model has loaded 
		 */		
		protected function onFontsLoaded():void
		{
			fontModel.errored.removeAll();
			fontModel.loaded.removeAll();
		}
		
		/**
		 * @private 
		 * @param event <code>ResourceProgressEvent.PROGRESS</code>
		 */		
		protected function onBootstrapProgressUpdate( event:ResourceProgressEvent ):void
		{
			if( event.amountLoaded == 1 )
			{
				bootstrapProgress.removeEventListener( ResourceProgressEvent.PROGRESS, onBootstrapProgressUpdate );
				bootstrapLoaded.dispatch();
				
				// Add an event listener for when the bootstrap load completed
				dataProgress.addEventListener( ResourceProgressEvent.PROGRESS, onDataProgressUpdate, false, 0, true );
			}
		}
		
		/**
		 * @private 
		 * @param event <code>ResourceProgressEvent.PROGRESS</code>
		 */		
		protected function onDataProgressUpdate( event:ResourceProgressEvent ):void
		{
			if( event.amountLoaded == 1 )
			{
				dataProgress.removeEventListener( ResourceProgressEvent.PROGRESS, onDataProgressUpdate );
				dataLoaded.dispatch();
				
				// Add event listener for when application load completed
				progress.addEventListener( ResourceProgressEvent.PROGRESS, onProgressUpdate, false, 0, true );
			}
		}
		
		/**
		 * @private 
		 * @param event <code>ResourceProgressEvent.PROGRESS</code>
		 */		
		protected function onProgressUpdate( event:ResourceProgressEvent ):void
		{
			if( event.amountLoaded == 1 )
			{
				progress.removeEventListener( ResourceProgressEvent.PROGRESS, onProgressUpdate );
				appLoaded.dispatch();
			}
		}
		
		//----------------------------------
		//  IProgress instantiations
		//----------------------------------
		
		/**
		 * @private 
		 * Returns an initialized version of the application 
		 * <code>IProgress</code>.
		 * 
		 * @return <code>IProgress</code> instance
		 */
		protected function getProgress():IProgress
		{
			return new Progress();
		}
		
		/**
		 * @private 
		 * Returns an initialized version of the data <code>IProgress</code>.
		 * 
		 * @return <code>IProgress</code> instance
		 */
		protected function getDataProgress():IProgress
		{
			return new Progress();
		}
		
		/**
		 * @private 
		 * Returns an initialized version of the view <code>IProgress</code>.
		 * 
		 * @return <code>IProgress</code> instance
		 */
		protected function getViewProgress():IProgress
		{
			return new Progress();
		}
		
		/**
		 * @private 
		 * Returns an initialized version of the bootstrap data
		 * <code>IProgress</code>.
		 * 
		 * @return <code>IProgress</code> instance
		 */
		protected function getBootstrapProgress():IProgress
		{
			return new Progress();
		}
		
		/**
		 * @private 
		 * Returns an initialized version of the bootstrap unknown data
		 * <code>IProgress</code>. This is all localization, stylesheet, etc
		 * data that might need to be added after the config file has loaded
		 * 
		 * @return <code>IProgress</code> instance
		 */
		protected function getBootstrapUnknownProgress():IProgress
		{
			return new Progress();
		}
		
		/**
		 * @private 
		 * Returns an initialized version of the config data
		 * <code>IProgress</code>.
		 * 
		 * @return <code>IProgress</code> instance
		 */
		protected function getConfigProgress():IProgress
		{
			return new Progress();
		}
		
		/**
		 * @private 
		 * Returns an initialized version of the localization data
		 * <code>IProgress</code>.
		 * 
		 * @return <code>IProgress</code> instance
		 */
		protected function getLocalizationProgress():IProgress
		{
			return new Progress();
		}
		
		/**
		 * @private 
		 * Returns an initialized version of the stylesheet data
		 * <code>IProgress</code>.
		 * 
		 * @return <code>IProgress</code> instance
		 */
		protected function getStylesheetProgress():IProgress
		{
			return new Progress();
		}
		
		/**
		 * @private 
		 * Returns an initialized version of the font data 
		 * <code>IProgress</code>.
		 * 
		 * @return <code>IProgress</code> instance
		 */
		protected function getFontProgress():IProgress
		{
			return new Progress();
		}
		
		/**
		 * @private 
		 * Returns an initialized version of the custom data load
		 * <code>IProgress</code>.
		 * 
		 * @return <code>IProgress</code> instance
		 */
		protected function getCustomDataProgress():IProgress
		{
			return new Progress();
		}
		
		//----------------------------------
		//  Model instantiations
		//----------------------------------
		
		/**
		 * @private 
		 * Returns an initialized version of the config model which must 
		 * conform to the <code>IBootstrapConfigModel</code> interface
		 * 
		 * @return <code>IBootstrapConfigModel</code> class
		 */
		protected function getConfigModel():Class
		{
			return BootstrapConfigModel;
		}
		
		/**
		 * @private 
		 * Returns an initialized version of the config model which must 
		 * conform to the <code>IBootstrapLocalizationModel</code> interface
		 * 
		 * @return <code>IBootstrapLocalizationModel</code> class
		 */
		protected function getLocalizationModel():Class
		{
			return BootstrapLocalizationModel;
		}
		
		/**
		 * @private 
		 * Returns an initialized version of the stylesheet model which must 
		 * conform to the <code>IBootstrapStylesheetModel</code> interface
		 * 
		 * @return <code>IBootstrapStylesheetModel</code> class
		 */
		protected function getStylesheetModel():Class
		{
			return BootstrapStylesheetModel;
		}
		
		/**
		 * @private 
		 * Returns an initialized version of the font model which must 
		 * conform to the <code>IBootstrapFontModel</code> interface
		 * 
		 * @return <code>IBootstrapFontModel</code> class
		 */
		protected function getFontModel():Class
		{
			return BootstrapFontModel;
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		//----------------------------------
		//  Public
		//----------------------------------
		
		/** 
		 * Application load progress instance. This is the top level progress
		 * instance.
		 */
		public function get progress():IProgress
		{
			return _progress;
		}
		
		/**
		 * <code>IProgress</code> instance for tracking the data portion of 
		 * loading. Must be a direct child of <code>_appProgress</code>
		 */		
		public function get dataProgress():IProgress
		{
			return _dataProgress;
		}
		
		/**
		 * <code>IProgress</code> instance for tracking the view portion of 
		 * loading. Must be a direct child of <code>_appProgress</code>
		 */		
		public function get viewProgress():IProgress
		{
			return _viewProgress;
		}
		
		/**
		 * <code>IBootstrapConfigModel</code> instance for loading and storing 
		 * the configuration model data
		 */
		public function get configModel():IBootstrapConfigModel
		{
			return _configModel;
		}
		
		/**
		 * <code>IBootstrapLocalizationModel</code> instance for loading and 
		 * storing the localization model data
		 */
		public function get localizationModel():IBootstrapLocalizationModel
		{
			return _localizationModel;
		}
		
		/**
		 * <code>IBootstrapStylesheetModel</code> instance for loading and 
		 * storing the stylesheet model data
		 */
		public function get stylesheetModel():IBootstrapStylesheetModel
		{
			return _stylesheetModel;
		}
		
		/**
		 * <code>IBootstrapFontModel</code> instance for loading and 
		 * storing the stylesheet model data
		 */
		public function get fontModel():IBootstrapFontModel
		{
			return _fontModel;
		}
		
		/**
		 * Application loaded signal
		 * 
		 * @return <code>ISignalOwner</code> 
		 */		
		public function get appLoaded():ISignalOwner
		{
			return _appLoaded;
		}
		
		/**
		 * Data loaded signal
		 * 
		 * @return <code>ISignalOwner</code> 
		 */	
		public function get dataLoaded():ISignalOwner
		{
			return _dataLoaded;
		}
		
		/**
		 * Bootstrap loaded signal
		 * 
		 * @return <code>ISignalOwner</code> 
		 */	
		public function get bootstrapLoaded():ISignalOwner
		{
			return _bootstrapLoaded;
		}
		
		/**
		 * Config XML loaded signal
		 * 
		 * @return <code>ISignalOwner</code> 
		 */	
		public function get configLoaded():ISignalOwner
		{
			return _configLoaded;
		}
		
		/**
		 * Config XML errored signal
		 * 
		 * @return <code>ISignalOwner</code> 
		 */	
		public function get configErrored():ISignalOwner
		{
			return _configErrored;
		}
		
		/**
		 * Bootstrap resource errored signal
		 * 
		 * @return <code>ISignalOwner</code> 
		 */
		public function get bootstrapResourceErrored():ISignalOwner
		{
			return _bootstrapResourceErrored;
		}
		
		//----------------------------------
		//  Protected
		//----------------------------------
		
		/**
		 * @private
		 * <code>IProgress</code> instance for tracking the bootstrap portion of 
		 * loading. Must be a direct child of <code>_dataProgress</code>
		 */
		protected function get bootstrapProgress():IProgress
		{
			return _bootstrapProgress;
		}
		
		/**
		 * @private
		 * <code>IProgress</code> instance for tracking the bootstrap unknown
		 * portion of loading. Must be a direct child of 
		 * <code>_dataProgress</code>
		 */
		protected function get bootstrapUnknownProgress():IProgress
		{
			return _bootstrapUnknownProgress;
		}
		
		/**
		 * @private
		 * <code>IProgress</code> instance for tracking the config data portion 
		 * of loading. Must be a direct child of <code>bootstrapProgress</code>
		 */
		protected function get configProgress():IProgress
		{
			return _configProgress;
		}
		
		/**
		 * @private
		 * <code>IProgress</code> instance for tracking the localization portion 
		 * of loading. Must be a direct child of <code>bootstrapProgress</code>
		 */
		protected function get localizationProgress():IProgress
		{
			return _localizationProgress;
		}
		
		/**
		 * @private
		 * <code>IProgress</code> instance for tracking the stylesheet portion 
		 * of loading. Must be a direct child of <code>bootstrapProgress</code>
		 */
		protected function get stylesheetProgress():IProgress
		{
			return _stylesheetProgress;
		}
		
		/**
		 * @private
		 * <code>IProgress</code> instance for tracking the font portion 
		 * of loading. Must be a direct child of <code>bootstrapProgress</code>
		 */
		protected function get fontProgress():IProgress
		{
			return _fontProgress;
		}
		
		/**
		 * @private
		 * <code>IProgress</code> instance for tracking any custom data load
		 * portion of loading. Must be a direct child of 
		 * <code>_dataProgress</code>
		 */
		protected function get customDataProgress():IProgress
		{
			return _customDataProgress;
		}
	}
}