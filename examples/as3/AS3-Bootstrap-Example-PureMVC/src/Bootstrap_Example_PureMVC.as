package 
{
	import as3bootstrap.examples.as3.puremvc.controller.BsStartupCommand;
	
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.utils.getDefinitionByName;
	
	import org.puremvc.as3.multicore.utilities.fabrication.components.FlashApplication;
	
	/**
	 * Main
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange 
	 */
	public class Bootstrap_Example_PureMVC 
		extends FlashApplication
	{
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		public function Bootstrap_Example_PureMVC()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			super();
		}
		
		//----------------------------------
		//  Override
		//----------------------------------
		
		override public function getStartupCommand():Class
		{
			return BsStartupCommand;
		}
		
		override public function getClassByName( path:String ):Class 
		{
			return getDefinitionByName( path ) as Class;      
		}
	}
}