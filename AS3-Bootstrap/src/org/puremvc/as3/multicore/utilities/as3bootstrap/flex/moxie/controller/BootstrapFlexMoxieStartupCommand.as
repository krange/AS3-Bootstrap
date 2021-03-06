package org.puremvc.as3.multicore.utilities.as3bootstrap.flex.moxie.controller
{
	import as3bootstrap.common.IBootstrap;
	import as3bootstrap.flex.moxie.BootstrapFlexMoxie;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.as3bootstrap.common.controller.BootstrapStartupCommand;
	
	/**
	 * Flex3 startup command for PureMVC multicore bootstrapped applications.
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 10.0.0
	 * 
	 * @author krisrange 
	 */
	public class BootstrapFlexMoxieStartupCommand 
		extends BootstrapStartupCommand
	{
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
			super.execute( notification );
		}
		
		//---------------------------------------------------------------------
		//
		//  Protected methods
		//
		//---------------------------------------------------------------------
		
		//----------------------------------
		//  Override
		//----------------------------------
		
		/**
		 * @inheritDoc 
		 */	
		override protected function instantiateBootstrap():IBootstrap
		{
			appProgress = getAppProgress();
			return new BootstrapFlexMoxie( appProgress );
		}
		
		/**
		 * @inheritDoc 
		 */	
		override protected function getFlashVarsParams():Object
		{
			if( viewComponent &&
				Object( viewComponent ).parameters )
			{
				return Object( viewComponent ).parameters;
			}
			else
			{
				return null;
			}
		}
	}
}