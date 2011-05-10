package org.robotlegs.utilities.as3bootstrap.flash
{
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.utilities.as3bootstrap.common.BootstrapAbstractContext;
	
	/**
	 * BootstrapRobotlegsFlashContext
	 * 
	 * @author krisrange
	 */
	public class BootstrapFlashContext 
		extends BootstrapAbstractContext
	{
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function BootstrapFlashContext( contextView:DisplayObjectContainer )
		{
			super( contextView );
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
		override protected function getFlashVarsParams():Object
		{
			return contextView.loaderInfo.parameters;
		}
	}
}