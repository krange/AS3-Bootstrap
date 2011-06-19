package as3bootstrap.examples.flex.puremvc.controller
{
	import as3bootstrap.examples.flex.puremvc.view.mediators.ApplicationMediator;
	
	import org.puremvc.as3.multicore.utilities.as3bootstrap.flex.spark.controller.BootstrapFlexSparkStartupCommand;
	
	/**
	 * BsStartupCommand
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange 
	 */
	public class BsStartupCommand 
		extends BootstrapFlexSparkStartupCommand
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