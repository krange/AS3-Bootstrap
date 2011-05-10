package org.robotlegs.utilities.as3bootstrap.common.model
{
	import as3bootstrap.common.model.IBootstrapConfigModel;
	
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * Robotlegs model for storing the config object
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange
	 */
	public class ConfigModel 
		extends Actor
		implements IConfigModel
	{
		private var _configModel : IBootstrapConfigModel;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 * 
		 * @param $configModel <code>IBootstrapConfigModel</code> instance
		 */
		public function ConfigModel( $configModel:IBootstrapConfigModel )
		{
			super();
			_configModel = $configModel;
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
			return _configModel;
		}
	}
}