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
package org.puremvc.as3.multicore.utilities.as3bootstrap.demos.as3.view
{
	import as3bootstrap.common.progress.IProgress;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.as3bootstrap.flash.view.mediators.BootstrapFlashMediator;
	
	/**
	 * ApplicationMediator
	 * 
	 * @author krisrange
	 */
	public class ApplicationMediator 
		extends BootstrapFlashMediator
	{
		public static const NAME : String = "ApplicationMediator";
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function ApplicationMediator(name:String, viewComponent:Object, progress:IProgress=null)
		{
			super(name, viewComponent, progress);
		}
		
		//----------------------------------
		//  Override
		//----------------------------------
		
		override public function respondToApplicationLoadComplete(notification:INotification):void
		{
			trace( notification );
		}
		
		override public function respondToBootstrapLoadComplete(notification:INotification):void
		{
			trace( notification );
		}
		
		override public function respondToDataLoadComplete(notification:INotification):void
		{
			trace( notification );
			progress.setAmountLoaded( 1 );
		}
		
		//---------------------------------------------------------------------
		//
		//  Protected methods
		//
		//---------------------------------------------------------------------
		
		//----------------------------------
		//  Override
		//----------------------------------
		
		//---------------------------------------------------------------------
		//
		//  Private methods
		//
		//---------------------------------------------------------------------
		
		//----------------------------------
		//  Handlers
		//----------------------------------
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
	}
}