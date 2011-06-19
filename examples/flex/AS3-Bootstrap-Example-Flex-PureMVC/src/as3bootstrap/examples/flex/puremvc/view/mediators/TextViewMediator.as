package as3bootstrap.examples.flex.puremvc.view.mediators
{
	import as3bootstrap.common.IBootstrap;
	import as3bootstrap.common.progress.IProgress;
	import as3bootstrap.examples.flex.puremvc.view.components.TextViewComponent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.as3bootstrap.common.model.BootstrapProxy;
	import org.puremvc.as3.multicore.utilities.as3bootstrap.common.model.IBootstrapProxy;
	import org.puremvc.as3.multicore.utilities.as3bootstrap.flex.common.view.mediators.BootstrapFlexMediator;
	
	/**
	 * TextViewMediator
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange 
	 */
	public class TextViewMediator 
		extends BootstrapFlexMediator
	{
		public static const NAME : String = "TextViewMediator";
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		public function TextViewMediator( name:String, viewComponent:Object, progress:IProgress=null )
		{
			super( name, viewComponent, progress );
		}
		
		//----------------------------------
		//  Override
		//----------------------------------
		
		override public function respondToBootstrapLoadComplete( notification:INotification ):void
		{
			var bootstrapProxy : IBootstrapProxy = retrieveProxy( BootstrapProxy.NAME ) as IBootstrapProxy;
			var bootstrap : IBootstrap = bootstrapProxy.bootstrap;
			
			view.setupView( bootstrap.localizationModel.localizations );
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		private function get view():TextViewComponent
		{
			return viewComponent as TextViewComponent;
		}
	}
}