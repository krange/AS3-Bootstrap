package org.robotlegs.utilities.as3bootstrap.common
{
	import as3bootstrap.common.Bootstrap;
	import as3bootstrap.common.IBootstrap;
	import as3bootstrap.common.constants.BootstrapConstants;
	import as3bootstrap.common.progress.IProgress;
	import as3bootstrap.common.progress.Progress;
	
	import flash.display.DisplayObjectContainer;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import org.robotlegs.mvcs.Context;
	import org.robotlegs.utilities.as3bootstrap.common.model.BootstrapModel;
	import org.robotlegs.utilities.as3bootstrap.common.model.ConfigModel;
	import org.robotlegs.utilities.as3bootstrap.common.model.IBootstrapModel;
	import org.robotlegs.utilities.as3bootstrap.common.model.IConfigModel;
	import org.robotlegs.utilities.as3bootstrap.common.model.events.BootstrapStatusEvent;
	
	/**
	 * Abstract context for Robotlegs projects
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange
	 */
	public class BootstrapAbstractContext 
		extends Context
	{
		//----------------------------------
		//  Error constants
		//----------------------------------
		
		private static const ERROR_GET_APP_MEDIATOR				:String = "Mediator for this Application or Module was not set. The getApplicationMediator() method was not overriden."; 
		private static const ERROR_REGISTER_APP_MEDIATOR		:String = "The mediator provided did not initialize correctly. Please check that it implements IBootstrapMediator."; 
		private static const ERROR_REGISTER_BOOTSTRAP_MODEL		:String = "Instantation of the class specified in the getBootstrapModel() method failed.";
		private static const ERROR_REGISTER_CONFIG_MODEL		:String = "Instantation of the class specified in the getConfigModel() method failed.";
		private static const ERROR_INSTANTIATE_BOOTSTRAP		:String = "Instantation of the class specified in the getBootstrap() method failed.";
		
		//----------------------------------
		//  Boostrap variables
		//----------------------------------
		
		private var _bootstrap : IBootstrap;
		private var _appProgress : IProgress;
		
		//----------------------------------
		//  Robotlegs variables
		//----------------------------------
		
		private var _bootstrapModel : IBootstrapModel;
		private var _configModel : IConfigModel;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		public function BootstrapAbstractContext( contextView:DisplayObjectContainer )
		{
			super( contextView );
		}
		
		//----------------------------------
		//  Override
		//----------------------------------
		
		/**
		 * @inheritDoc 
		 */		
		override public function startup():void
		{
			registerBootstrap();
			registerModels();
			registerCommands();
			registerApplicationMediator();
			
			bootstrap.start( getFlashVarsParams() );
			
			super.startup();
		}
		
		//---------------------------------------------------------------------
		//
		//  Protected methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Inject the commands
		 */
		protected function registerCommands():void
		{
		}
		
		/**
		 * Inject the models
		 */
		protected function registerModels():void
		{
			registerBootstrapModel();
			registerConfigModel();
		}
		
		/**
		 * @private
		 * Instantiate the boostrap class 
		 */		
		protected function registerBootstrap():void
		{
			_appProgress = getAppProgress()
			var BootstrapClass : Object = getBootstrap();
			
			// Attempt to register bootstrap
			try
			{
				_bootstrap = new BootstrapClass( _appProgress );
			}
			catch( e : Error )
			{
				throw new Error( ERROR_INSTANTIATE_BOOTSTRAP );
			}
		}
		
		/**
		 * Returns the bootstrap class to use
		 *  
		 * @return <code>IBootstrap</code> class reference
		 */		
		protected function getBootstrap():Class
		{
			return Bootstrap;
		}
		
		/**
		 * Returns the application level <code>IProgress</code> instance that 
		 * will be used to track load
		 * 
		 * @return IProgress
		 */		
		protected function getAppProgress():IProgress
		{
			return new Progress();
		}
		
		/**
		 * Returns the Flash Vars parameters required for load. Must be 
		 * overriden by subclass to determine how to retrieve the parameters
		 * 
		 * @return Object FlashVars parameters
		 */ 
		protected function getFlashVarsParams():Object 
		{
			// Must be overriden
			throw new Error( BootstrapConstants.ERROR_RETRIEVE_FLASH_VARS );
		}
		
		//----------------------------------
		//  Mediator instantiations
		//----------------------------------
		
		/** 
		 * @private
		 * Registers the application mediator
		 */
		protected function registerApplicationMediator():void 
		{
			var ApplicationMediatorClass : Class;
			var MainViewClass : Class;
			
			try
			{
				ApplicationMediatorClass = getApplicationMediator() as Class;
				MainViewClass = getDefinitionByName( getQualifiedClassName( contextView ) ) as Class;
				mediatorMap.mapView( MainViewClass, ApplicationMediatorClass );
			}
			catch( error:Error )
			{
				throw new Error( ERROR_REGISTER_APP_MEDIATOR );
			}
			
			mediatorMap.createMediator( contextView );
		}
		
		/**
		 * Returns the application mediator class to be used
		 * 
		 * @return <code>IBoostrapMediator</code> class reference
		 */ 
		protected function getApplicationMediator():Class 
		{
			// Must be overriden
			throw new Error( ERROR_GET_APP_MEDIATOR );
		}
		
		//----------------------------------
		//  Command instantiations
		//----------------------------------
		
		/**
		 * @private
		 * Register the config load commands
		 */		
		protected function registerConfigLoadCommands():void
		{
			// Register the complete command
			var ConfigLoadCompleteClass : Class = getConfigLoadCompleteCommand();
			if( ConfigLoadCompleteClass )
			{
				commandMap.mapEvent( BootstrapStatusEvent.CONFIG_LOAD_COMPLETE, ConfigLoadCompleteClass );
			}
			
			// Register the fail command
			var ConfigLoadFailClass : Class = getConfigLoadFailCommand();
			if( ConfigLoadFailClass )
			{
				commandMap.mapEvent( BootstrapStatusEvent.CONFIG_LOAD_ERROR, ConfigLoadFailClass );
			}
		}
	
		/**
		 * Returns the class to use for when the config loading completes
		 * 
		 * @return Class 
		 */
		protected function getConfigLoadCompleteCommand():Class
		{
			return null;
		}
		
		/**
		 * Returns the class to use for when the config loading fails
		 * 
		 * @return Class 
		 */
		protected function getConfigLoadFailCommand():Class
		{
			return null;
		}
		
		//----------------------------------
		//  Model instantiations
		//----------------------------------
		
		/**
		 * Return the config model class to use
		 * 
		 * @return <code>IConfigModel</code> class reference
		 */		
		protected function getConfigModel():Class
		{
			return ConfigModel;
		}
		
		/**
		 * Return the bootstrap proxy class to use
		 * 
		 * @return <code>IBootstrapProxy</code> class reference
		 */
		protected function getBootstrapModel():Class
		{
			return BootstrapModel;
		}
		
		/** 
		 * @private
		 * Register the bootstrap proxy
		 */
		protected function registerBootstrapModel():void 
		{
			var BootstrapModelClass : Object = getBootstrapModel();
			try
			{
				_bootstrapModel = new BootstrapModelClass( bootstrap );
			}
			catch( e:Error )
			{
				throw new Error( ERROR_REGISTER_BOOTSTRAP_MODEL );	
			}
			
			injector.mapValue( IBootstrapModel, _bootstrapModel );
			injector.injectInto( _bootstrapModel );
		}
		
		/** 
		 * @private
		 * Register the config model
		 */
		protected function registerConfigModel():void 
		{
			var ConfigModelClass : Object = getConfigModel();
			try
			{
				_configModel = new ConfigModelClass( bootstrap.configModel );
			}
			catch( e : Error )
			{
				throw new Error( ERROR_REGISTER_CONFIG_MODEL );
			}
			
			injector.mapValue( IConfigModel, _configModel );
			injector.injectInto( _configModel );
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Returns the Bootstrap object
		 * 
		 * @return <code>IBootstrap</code> object
		 */		
		protected function get bootstrap():IBootstrap
		{
			return _bootstrap;
		}
		
		/**
		 * Returns the bootstrap model
		 * 
		 * @return IBootstrapRobotlegsModel 
		 */		
		protected function get bootstrapModel():IBootstrapModel
		{
			return _bootstrapModel;
		}
	}
}