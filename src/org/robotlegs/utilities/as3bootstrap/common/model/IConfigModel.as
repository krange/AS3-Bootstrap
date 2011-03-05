package org.robotlegs.utilities.as3bootstrap.common.model
{
	import as3bootstrap.common.model.IBootstrapConfigModel;

	/**
	 * IConfigModel
	 * 
	 * @author krisrange
	 */
	public interface IConfigModel
	{
		/**
		 * Get the IBootstrapConfigModel reference
		 * 
		 * @return IBootstrapConfigModel 
		 */		
		function get configModel():IBootstrapConfigModel;
	}
}