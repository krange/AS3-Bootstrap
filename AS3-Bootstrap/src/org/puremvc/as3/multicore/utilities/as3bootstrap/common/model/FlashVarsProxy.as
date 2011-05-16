package org.puremvc.as3.multicore.utilities.as3bootstrap.common.model
{
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.proxy.FabricationProxy;
	
	/**
	 * Proxy containing the applications flashvars data
	 * 
	 * @author krisrange
	 */
	public class FlashVarsProxy 
		extends FabricationProxy
		implements IFlashVarsProxy
	{
		public static const NAME : String = "FlashVarsProxy";
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		public function FlashVarsProxy( name:String=null, data:Object=null )
		{
			super( name, data );
		}
		
		/**
		 * @return Object Specific flash vars parameter
		 */ 
		public function getParam( key:String ):Object
		{
			return data[key];
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * The parameters supplied to the main application.
		 */
		public function get params():Object
		{
			return data as Object;
		}
	}
}