package
{
	import as3bootstrap.common.Bootstrap;
	import as3bootstrap.common.IBootstrap;
	import as3bootstrap.common.model.vo.ILocalization;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * Bootstrap_Example_as3
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange 
	 */
	public class Bootstrap_Example_as3 
		extends Sprite
	{
		private var _bootstrap : IBootstrap;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		public function Bootstrap_Example_as3()
		{
			super();
			init();
		}
		
		//---------------------------------------------------------------------
		//
		//  Private methods
		//
		//---------------------------------------------------------------------
		
		private function init():void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			_bootstrap = new Bootstrap();
			_bootstrap.configErrored.add( onConfigErrored );
			_bootstrap.bootstrapResourceErrored.add( onBootstrapResourceErrored );
			_bootstrap.bootstrapLoaded.add( onBootstrapLoaded );
			_bootstrap.start( loaderInfo.parameters );
		}
		
		//----------------------------------
		//  Handlers
		//----------------------------------
		
		private function onBootstrapLoaded():void
		{
			var ss : StyleSheet = _bootstrap.stylesheetModel.stylesheets;
			var loc : ILocalization = _bootstrap.localizationModel.localizations;
			
			var txt : TextField = new TextField();
			txt.embedFonts = true;
			txt.selectable = false;
			addChild( txt );
			
			txt.x = 50;
			txt.y = 50;
			
			var txtFmt : TextFormat = ss.transform( ss.getStyle( ".some_style" ) );
			txt.text = loc.getLocalizedValue( "value1" );
			txt.setTextFormat( txtFmt );
		}
		
		private function onConfigErrored( event:Event ):void
		{
			
		}
		
		private function onBootstrapResourceErrored( event:Event ):void
		{
			trace( event );
		}
	}
}