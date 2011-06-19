package as3bootstrap.examples.as3.puremvc.view.mediators
{
	import as3bootstrap.common.progress.IProgress;
	import as3bootstrap.examples.as3.puremvc.view.components.TextViewComponent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.as3bootstrap.flash.view.mediators.BootstrapFlashMediator;
	
	/**
	 * ApplicationMediator
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
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
		
		public function ApplicationMediator( name:String, viewComponent:Object, progress:IProgress )
		{
			super( name, viewComponent, progress );
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			var textView : TextViewComponent = new TextViewComponent();
			registerMediator( new TextViewMediator( TextViewMediator.NAME, textView ) );
			viewComponent.addChild( textView );
		}
	}
}