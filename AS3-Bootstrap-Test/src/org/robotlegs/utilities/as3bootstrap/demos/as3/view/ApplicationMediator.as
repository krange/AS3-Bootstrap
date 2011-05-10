package org.robotlegs.utilities.as3bootstrap.demos.as3.view
{
	import org.robotlegs.utilities.as3bootstrap.common.model.events.BootstrapStatusEvent;
	import org.robotlegs.utilities.as3bootstrap.common.view.BootstrapMediator;
	
	/**
	 * ApplicationMediator
	 * 
	 * @author krisrange
	 */
	public class ApplicationMediator 
		extends BootstrapMediator
	{	
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		//----------------------------------
		//  Override
		//----------------------------------
		
		override public function onRegister():void
		{
			super.onRegister();
		}
		
		//---------------------------------------------------------------------
		//
		//  Protected methods
		//
		//---------------------------------------------------------------------
		
		//----------------------------------
		//  Override
		//----------------------------------
		
		override protected function onBootstrapLoadComplete($event:BootstrapStatusEvent):void
		{
			trace( $event );
		}
		
		override protected function onDataLoadComplete($event:BootstrapStatusEvent):void
		{
			trace( $event );
			//progress.setAmountLoaded( 1 );
		}
		
		override protected function onApplicationLoadComplete($event:BootstrapStatusEvent):void
		{
			trace( $event );
		}
	}
}