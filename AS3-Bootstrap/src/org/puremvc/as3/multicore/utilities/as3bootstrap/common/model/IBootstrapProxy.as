package org.puremvc.as3.multicore.utilities.as3bootstrap.common.model
{
	import as3bootstrap.common.IBootstrap;
	
	import org.puremvc.as3.multicore.interfaces.IProxy;
	
	/**
	 * IBootstrapProxy
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange 
	 */
	public interface IBootstrapProxy 
		extends IProxy
	{
		/**
		 * Returns the <code>IBootstrap</code> object
		 * 
		 * @return IBootstrap
		 */		
		function get bootstrap():IBootstrap
	}
}