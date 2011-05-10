package org.puremvc.as3.multicore.utilities.as3bootstrap.common.model
{
	import as3bootstrap.common.model.IBootstrapConfigModel;
	
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.proxy.FabricationProxy;
	
	/**
	 * Proxy which provides a reference to the bootstrap config model
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange
	 */
	public class ConfigProxy 
		extends FabricationProxy
		implements IConfigProxy
	{
		public static const NAME : String = "ConfigProxy";
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 * 
		 * @param $name IProxy name
		 * @param $data IBootstrapConfigModel reference
		 */
		public function ConfigProxy( $name:String, $data:IBootstrapConfigModel )
		{
			super( $name, $data );
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Get the IBootstrapConfigModel reference
		 * 
		 * @return IBootstrapConfigModel 
		 */		
		public function get configModel():IBootstrapConfigModel
		{
			return data as IBootstrapConfigModel;
		}
	}
}