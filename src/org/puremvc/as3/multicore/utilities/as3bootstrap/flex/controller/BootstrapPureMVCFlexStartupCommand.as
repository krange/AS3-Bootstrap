package org.puremvc.as3.multicore.utilities.as3bootstrap.flex.controller
{
	import as3bootstrap.flex.moxie.BootstrapFlex;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.as3bootstrap.common.controller.BootstrapPureMVCStartupCommand;
	import org.puremvc.as3.multicore.utilities.fabrication.components.FlexApplication;
	
	/**
	 * Flex 3 startup command for PureMVC multicore bootstrapped applications.
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange 
	 */
	public class BootstrapPureMVCFlexStartupCommand 
		extends BootstrapPureMVCStartupCommand
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
		override public function execute( $notification:INotification ):void
		{
			super.execute( $notification );
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
		override protected function getBootstrap():Class
		{
			return BootstrapFlex;
		}
		
		/**
		 * @inheritDoc 
		 */	
		override protected function getFlashVarsParams():Object
		{
			var flexViewComponent : FlexApplication = viewComponent as FlexApplication;
			if( flexViewComponent )
			{
				return flexViewComponent.parameters;
			}
			else
			{
				return null;
			}
		}
	}
}