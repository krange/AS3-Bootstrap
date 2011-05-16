package org.puremvc.as3.multicore.utilities.as3bootstrap.common.model
{
	import org.puremvc.as3.multicore.interfaces.IProxy;
	
	/**
	 * Interface for a Flash Vars proxy
	 * 
	 * @author krisrange
	 */ 
	public interface IFlashVarsProxy 
		extends IProxy
	{
		/**
		 * The parameters supplied to the main application.
		 */
		function get params():Object;
		
		/**
		 * @return Object Specific flash vars parameter
		 */ 
		function getParam( key:String ):Object;
	}
}