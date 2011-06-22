package as3bootstrap.examples.flex.puremvc.view.mediators
{
	import as3bootstrap.common.progress.IProgress;
	
	import org.puremvc.as3.multicore.utilities.as3bootstrap.flex.common.view.mediators.BootstrapFlexMediator;
	
	/**
	 * ApplicationMediator
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 10.0.0
	 * 
	 * @author krisrange 
	 */
	public class ApplicationMediator 
		extends BootstrapFlexMediator
	{
		public static const NAME : String = "ApplicationMediator";
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		public function ApplicationMediator( name:String, viewComponent:Object, progress:IProgress )
		{
			super( name, viewComponent, progress );
		}
		
		//----------------------------------
		//  Override
		//----------------------------------
		
		override public function onRegister():void
		{
			super.onRegister();
			
			registerMediator( new TextViewMediator( TextViewMediator.NAME, view.textView ) );
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		private function get view():Bootstrap_Example_Flex_PureMVC
		{
			return viewComponent as Bootstrap_Example_Flex_PureMVC;
		}
	}
}