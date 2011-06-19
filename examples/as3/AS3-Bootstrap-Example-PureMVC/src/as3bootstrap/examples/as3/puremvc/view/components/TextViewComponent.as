package as3bootstrap.examples.as3.puremvc.view.components
{
	import as3bootstrap.common.model.vo.ILocalization;
	
	import flash.display.Sprite;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * TextViewComponent
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange 
	 */
	public class TextViewComponent
		extends Sprite
	{
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		public function TextViewComponent()
		{
		}
		
		/**
		 * Setup the view 
		 *  
		 * @param loc
		 * @param styles
		 */		
		public function setupView( loc:ILocalization, styles:StyleSheet ):void
		{
			var txt : TextField = new TextField();
			txt.embedFonts = true;
			txt.selectable = false;
			addChild( txt );
			
			var txtFmt : TextFormat = styles.transform( styles.getStyle( ".some_style" ) );
			txt.text = loc.getLocalizedValue( "value1" );
			txt.setTextFormat( txtFmt );
			
			txt.x = 50;
			txt.y = 50;
		}
	}
}