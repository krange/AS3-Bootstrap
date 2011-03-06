package as3bootstrap.flex.spark
{
	import as3bootstrap.common.Bootstrap;
	import as3bootstrap.common.progress.IProgress;
	import as3bootstrap.flex.spark.model.BootstrapFlexSparkStylesheetModel;
	
	/**
	 * Bootstrap for Flex 4 applications
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 10.0.0
	 * 
	 * @author krisrange 
	 */
	public class BootstrapFlexSpark 
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
		public function BootstrapFlexSpark(
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
			return BootstrapFlexSparkStylesheetModel;
		}
	}
}