/**
 * ------------------------------------------------------------
 * Copyright (c) 2010 Dareville.
 * This software is the proprietary information of Dareville.
 * All Right Reserved.
 * ------------------------------------------------------------
 *
 * SVN revision information:
 * @version $Revision: $:
 * @author  $Author: $:
 * @date    $Date: $:
 */
package org.puremvc.as3.multicore.utilities.as3bootstrap.common.model
{
	import as3bootstrap.common.model.IBootstrapConfigModel;
	
	import org.puremvc.as3.multicore.interfaces.IProxy;
	
	/**
	 * Interface for the config proxy
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange
	 */
	public interface IConfigProxy 
		extends IProxy
	{
		/**
		 * Get the IBootstrapConfigModel reference
		 * 
		 * @return IBootstrapConfigModel 
		 */		
		function get configModel():IBootstrapConfigModel;
	}
}