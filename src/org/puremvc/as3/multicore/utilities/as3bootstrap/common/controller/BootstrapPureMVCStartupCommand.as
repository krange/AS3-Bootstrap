package org.puremvc.as3.multicore.utilities.as3bootstrap.common.controller
{
	import as3bootstrap.common.Bootstrap;
	import as3bootstrap.common.IBootstrap;
	import as3bootstrap.common.constants.BootstrapConstants;
	
	import flash.display.DisplayObject;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.as3bootstrap.common.constants.BootstrapPureMVCConstants;
	import org.puremvc.as3.multicore.utilities.as3bootstrap.common.model.BootstrapProxy;
	import org.puremvc.as3.multicore.utilities.as3bootstrap.common.model.IBootstrapProxy;
	import org.puremvc.as3.multicore.utilities.as3bootstrap.common.view.mediators.IBootStrapMediator;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.command.SimpleFabricationCommand;
	
	/**
	 * Base startup command for PureMVC multicore bootstrapped applications.
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange 
	 */
	public class BootstrapPureMVCStartupCommand 
		extends SimpleFabricationCommand
	{
		//----------------------------------
		//  Error constants
		//----------------------------------
		
		private static const ERROR_GET_APP_MEDIATOR				:String = "Mediator for this Application or Module was not set. The getApplicationMediator() method was not overriden."; 
		private static const ERROR_REGISTER_APP_MEDIATOR		:String = "The mediator provided either did not implement IBootstrapMediator or the Constructor did not take the correct arguments."; 
		private static const ERROR_REGISTER_BOOTSTRAP_PROXY		:String = "Instantation of the class specified in the getBootstrapProxy() method failed.";
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
		
		//----------------------------------
		//  PureMVC variables
		//----------------------------------
		
		private var _bootstrapProxy : IBootstrapProxy;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		//----------------------------------
		//  Override
		//----------------------------------
		
		override public function execute(notification:INotification):void
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
		
		protected function startBootstrap():void
		{
			// Start bootstrap
			bootstrap.start( getFlashVarsParams() );
		}
		
		/**
		 * @private
		 * Instantiate the boostrap class 
		 */		
		protected function registerBootstrap():void
		{
			var BootstrapClass : Object = getBootstrap();
			
			// Attempt to register bootstrap
			try
			{
				_bootstrap = new BootstrapClass();
			}
			catch( e : Error )
			{
				throw new Error( ERROR_INSTANTIATE_BOOTSTRAP );
			}
		}
		
		/**
		 * @private
		 * Register the PureMVC proxies 
		 */		
		protected function registerProxies():void
		{
			registerBootstrapProxy();
		}
		
		/**
		 * @private
		 * Register the PureMVC commands
		 */		
		protected function registerCommands():void
		{
			registerConfigLoadCommands();
		}
		
		//----------------------------------
		//  Mediator instantiations
		//----------------------------------
		
		/** 
		 * @private
		 * Registers the application mediator
		 */
		protected function registerApplicationMediator() : void 
		{
			var ApplicationMediator : Object = getApplicationMediator();
			var appMediator : IBootStrapMediator;
			
			// Attempt to register the Mediator
			try 
			{
				appMediator = new ApplicationMediator( ApplicationMediator.NAME, viewComponent, bootstrap.viewProgress );
			} 
			catch( e : Error ) 
			{
				throw new Error( ERROR_REGISTER_APP_MEDIATOR );
			}
			
			// Instantation of the application mediator was a success, so 
			// register it
			registerMediator( appMediator );
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
		protected function registerBootstrapProxy() : void 
		{
			var BootstrapProxyClass : Object = getBootstrapProxy();
			_bootstrapProxy = new BootstrapProxyClass( BootstrapProxyClass.NAME, bootstrap );
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
		 * Returns the application mediator class to be used
		 * 
		 * @return <code>IBoostrapMediator</code> class reference
		 */ 
		protected function getApplicationMediator():Class 
		{
			// Must be overriden
			throw new Error( ERROR_GET_APP_MEDIATOR );
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

	}
}