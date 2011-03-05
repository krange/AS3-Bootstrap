package as3bootstrap.flex.halo
{
	import as3bootstrap.common.Bootstrap;
	import as3bootstrap.common.progress.IProgress;
	import as3bootstrap.flex.halo.model.BootstrapFlexHaloStylesheetModel;
	
	/**
	 * Bootstrap for Flex 4 applications
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 10.0.0
	 * 
	 * @author krisrange 
	 */
	public class BootstrapFlexHalo 
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
		public function BootstrapFlexHalo(
			$progress:IProgress=null, 
			$dataProgress:IProgress=null, 
			$viewProgress:IProgress=null )
		{
			super( $progress, $dataProgress, $viewProgress );
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
			return BootstrapFlexHaloStylesheetModel;
		}
	}
}