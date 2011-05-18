package org.puremvc.as3.multicore.utilities.as3bootstrap.common.controller
{
	import as3bootstrap.common.Bootstrap;
	import as3bootstrap.common.IBootstrap;
	import as3bootstrap.common.constants.BootstrapConstants;
	import as3bootstrap.common.progress.IProgress;
	
	import flash.display.DisplayObject;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.as3bootstrap.common.constants.BootstrapPureMVCConstants;
	import org.puremvc.as3.multicore.utilities.as3bootstrap.common.model.BootstrapProxy;
	import org.puremvc.as3.multicore.utilities.as3bootstrap.common.model.ConfigProxy;
	import org.puremvc.as3.multicore.utilities.as3bootstrap.common.model.FlashVarsProxy;
	import org.puremvc.as3.multicore.utilities.as3bootstrap.common.model.IBootstrapProxy;
	import org.puremvc.as3.multicore.utilities.as3bootstrap.common.model.IConfigProxy;
	import org.puremvc.as3.multicore.utilities.as3bootstrap.common.model.IFlashVarsProxy;
	import org.puremvc.as3.multicore.utilities.as3bootstrap.common.view.mediators.IBootstrapMediator;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.command.SimpleFabricationCommand;
	
	/**
	 * Abstract startup command for PureMVC multicore bootstrapped applications
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange 
	 */
	public class BootstrapStartupCommand 
		extends SimpleFabricationCommand
	{
		//----------------------------------
		//  Error constants
		//----------------------------------
		
		private static const ERROR_GET_APP_MEDIATOR				:String = "Mediator for this Application or Module was not set. The getApplicationMediator() method was not overriden."; 
		private static const ERROR_REGISTER_APP_MEDIATOR		:String = "The mediator provided either did not implement IBootstrapMediator or the Constructor did not take the correct arguments."; 
		private static const ERROR_REGISTER_FLASH_VARS_PROXY	:String = "Instantation of the class specified in the getFlashVarsProxy() method failed.";
		private static const ERROR_REGISTER_BOOTSTRAP_PROXY		:String = "Instantation of the class specified in the getBootstrapProxy() method failed.";
		private static const ERROR_REGISTER_CONFIG_PROXY		:String = "Instantation of the class specified in the getConfigProxy() method failed.";
		private static const ERROR_INSTANTIATE_BOOTSTRAP		:String = "Instantation of the class specified in the getBootstrap() method failed.";
		
		//----------------------------------
		//  UI components
		//----------------------------------
		
		/**
		 * Reference to the applications main view 
		 */		
		protected var viewComponent : DisplayObject;
		
		//----------------------------------
		//  Boostrap variables
		//----------------------------------
		
		private var _bootstrap : IBootstrap;
		private var _appProgress : IProgress;
		
		//----------------------------------
		//  PureMVC variables
		//----------------------------------
		
		private var _flashVarsProxy : IFlashVarsProxy;
		private var _bootstrapProxy : IBootstrapProxy;
		private var _configProxy : IConfigProxy;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		//----------------------------------
		//  Override
		//----------------------------------
		
		/**
		 * @inheritDoc 
		 */		
		override public function execute( notification:INotification ):void
		{
			viewComponent = notification.getBody() as DisplayObject;
			initialize();
		}
		
		//---------------------------------------------------------------------
		//
		//  Protected methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * @private 
		 */		
		protected function initialize():void
		{
			registerBootstrap();
			registerProxies();
			registerCommands();
			registerApplicationMediator();
			
			startBootstrap();
		}
		
		/**
		 * Startup bootstrap
		 */		
		protected function startBootstrap():void
		{
			// Start bootstrap
			bootstrap.start( getFlashVarsParams() );
		}
		
		/**
		 * Instantiate the boostrap class 
		 */		
		protected function registerBootstrap():void
		{
			// Attempt to instantiate bootstrap
			try
			{
				_bootstrap = instantiateBootstrap();
			}
			catch( e : Error )
			{
				throw new Error( ERROR_INSTANTIATE_BOOTSTRAP );
			}
		}
		
		/**
		 * Register the PureMVC proxies 
		 */		
		protected function registerProxies():void
		{
			registerFlashVarsProxy();
			registerBootstrapProxy();
			registerConfigProxy();
		}
		
		/**
		 * Register the PureMVC commands
		 */		
		protected function registerCommands():void
		{
			registerConfigLoadCommands();
		}
		
		/**
		 * Instantiate the bootstrap instance to use
		 *  
		 * @return <code>IBootstrap</code> reference
		 */		
		protected function instantiateBootstrap():IBootstrap
		{
			_appProgress = getAppProgress();
			return new Bootstrap( appProgress );
		}
		
		/**
		 * Returns the application level <code>IProgress</code> instance that 
		 * will be used to track load
		 * 
		 * @return IProgress
		 */		
		protected function getAppProgress():IProgress
		{
			return null;
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
			var ApplicationMediatorClass : Object = getApplicationMediator();
			var appMediator : IBootstrapMediator;
			
			// Attempt to register the Mediator
			try 
			{
				appMediator = new ApplicationMediatorClass( ApplicationMediatorClass.NAME, viewComponent, bootstrap.viewProgress );
			} 
			catch( event:Error ) 
			{
				throw new Error( ERROR_REGISTER_APP_MEDIATOR );
			}
			
			// Instantation of the application mediator was a success, so 
			// register it
			registerMediator( appMediator );
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
				registerCommand( BootstrapPureMVCConstants.BOOTSTRAP_CONFIG_LOAD_COMPLETE, ConfigLoadCompleteClass );
			}
			
			// Register the fail command
			var ConfigLoadFailClass : Class = getConfigLoadFailCommand();
			if( ConfigLoadFailClass )
			{
				registerCommand( BootstrapPureMVCConstants.BOOTSTRAP_CONFIG_LOAD_FAIL, ConfigLoadFailClass );
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
		//  Proxy instantiations
		//----------------------------------
		
		/** 
		 * @private
		 * Register the bootstrap proxy
		 */
		protected function registerFlashVarsProxy():void 
		{
			var FlashVarsProxyClass : Object = getFlashVarsProxy();
			try
			{
				_flashVarsProxy = new FlashVarsProxyClass( FlashVarsProxyClass.NAME, getFlashVarsParams() );
			}
			catch( e:Error )
			{
				throw new Error( ERROR_REGISTER_FLASH_VARS_PROXY );	
			}
			
			// Instantation of the bootstrap proxy was a success, so register it
			registerProxy( _flashVarsProxy );
		}
		
		/**
		 * Return the flashvars proxy class to use
		 * 
		 * @return <code>IFlashVarsProxy</code> class reference
		 */
		protected function getFlashVarsProxy():Class
		{
			return FlashVarsProxy;
		}
		
		/** 
		 * @private
		 * Register the bootstrap proxy
		 */
		protected function registerBootstrapProxy():void 
		{
			var BootstrapProxyClass : Object = getBootstrapProxy();
			try
			{
				_bootstrapProxy = new BootstrapProxyClass( BootstrapProxyClass.NAME, bootstrap );
			}
			catch( e : Error )
			{
				throw new Error( ERROR_REGISTER_BOOTSTRAP_PROXY );	
			}
			
			// Instantation of the bootstrap proxy was a success, so register it
			registerProxy( _bootstrapProxy );
		}
		
		/**
		 * Return the bootstrap proxy class to use
		 * 
		 * @return <code>IBootstrapProxy</code> class reference
		 */
		protected function getBootstrapProxy():Class
		{
			return BootstrapProxy;
		}
		
		/** 
		 * @private
		 * Register the config proxy
		 */
		protected function registerConfigProxy():void 
		{
			var ConfigProxyClass : Object = getConfigProxy();
			try
			{
				_configProxy = new ConfigProxyClass( ConfigProxyClass.NAME, bootstrap.configModel );
			}
			catch( e : Error )
			{
				throw new Error( ERROR_REGISTER_CONFIG_PROXY );
			}
			
			// Instantation of the config proxy was a success, so register it
			registerProxy( _configProxy );
		}
		
		/**
		 * Return the config proxy class to use
		 * 
		 * @return <code>IConfigProxy</code> class reference
		 */		
		protected function getConfigProxy():Class
		{
			return ConfigProxy;
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
		 * Returns the bootstrap proxy
		 * 
		 * @return BootstrapProxy 
		 */		
		protected function get bootstrapProxy():IBootstrapProxy
		{
			return _bootstrapProxy;
		}

		/**
		 * The appliation level <code>IProgress</code>
		 *  
		 * @return IProgress
		 */		
		protected function get appProgress():IProgress { return _appProgress; }
		protected function set appProgress( value:IProgress ):void
		{
			_appProgress = value;
		}
	}
}