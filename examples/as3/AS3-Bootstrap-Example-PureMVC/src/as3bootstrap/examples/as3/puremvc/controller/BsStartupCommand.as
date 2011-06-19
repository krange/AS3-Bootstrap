package as3bootstrap.examples.as3.puremvc.controller
{
	import as3bootstrap.examples.as3.puremvc.view.mediators.ApplicationMediator;
	
	import org.puremvc.as3.multicore.utilities.as3bootstrap.flash.controller.BootstrapFlashStartupCommand;
	
	/**
	 * BsStartupCommand
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange 
	 */
	public class BsStartupCommand 
		extends BootstrapFlashStartupCommand
	{
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