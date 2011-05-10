/**
 * ------------------------------------------------------------
 * Copyright (c) 2010 Dareville.
 * This software is the proprietary information of Dareville.
 * All Right Reserved.
 * ------------------------------------------------------------
 *
 * SVN revision information:
 * @version $Revision: $:
 * @author  $Author: $:
 * @date    $Date: $:
 */
package org.robotlegs.utilities.as3bootstrap.demos.as3
{
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.utilities.as3bootstrap.demos.as3.view.ApplicationMediator;
	import org.robotlegs.utilities.as3bootstrap.flash.BootstrapFlashContext;
	
	/**
	 * MainRobotLegsContext
	 * 
	 * @author krisrange
	 */
	public class MainRobotLegsContext 
		extends BootstrapFlashContext
	{	
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function MainRobotLegsContext( contextView:DisplayObjectContainer )
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
		
		override protected function getApplicationMediator():Class
		{
			return ApplicationMediator;
		}
	}
}