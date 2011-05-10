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
package org.puremvc.as3.multicore.utilities.as3bootstrap.demos.as3.controller
{
	import org.puremvc.as3.multicore.utilities.as3bootstrap.demos.as3.view.ApplicationMediator;
	import org.puremvc.as3.multicore.utilities.as3bootstrap.flash.controller.BootstrapFlashStartupCommand;
	
	/**
	 * FlStartupCommand
	 * 
	 * @author krisrange
	 */
	public class FlStartupCommand 
		extends BootstrapFlashStartupCommand
	{
		//---------------------------------------------------------------------
		//
		//  Public methods
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