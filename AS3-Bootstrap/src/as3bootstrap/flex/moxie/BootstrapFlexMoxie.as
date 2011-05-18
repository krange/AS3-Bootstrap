package as3bootstrap.flex.moxie
{
	import as3bootstrap.common.Bootstrap;
	import as3bootstrap.common.progress.IProgress;
	import as3bootstrap.flex.moxie.model.BootstrapFlexMoxieStylesheetModel;
	
	/**
	 * Bootstrap for Flex3 applications
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange 
	 */
	public class BootstrapFlexMoxie 
		extends Bootstrap
	{
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		public function BootstrapFlexMoxie(
			progress:IProgress=null, 
			dataProgress:IProgress=null, 
			viewProgress:IProgress=null )
		{
			super( progress, dataProgress, viewProgress );
		}
		
		//---------------------------------------------------------------------
		//
		//  Protected methods
		//
		//---------------------------------------------------------------------
		
		//----------------------------------
		//  Override
		//----------------------------------
		
		/**
		 * @inheritDoc
		 */
		override protected function getStylesheetModel():Class
		{
			return BootstrapFlexMoxieStylesheetModel;
		}
	}
}