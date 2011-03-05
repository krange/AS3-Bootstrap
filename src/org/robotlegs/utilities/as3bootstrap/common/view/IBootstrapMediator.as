package org.robotlegs.utilities.as3bootstrap.common.view
{
	import as3bootstrap.common.progress.IProgress;
	
	import org.robotlegs.core.IMediator;
	
	/**
	 * Interface for bootstrap mediators
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange
	 */
	public interface IBootstrapMediator 
		extends IMediator
	{
		/**
		 * Set the <code>IProgress</code> instance
		 * 
		 * @param $progress <code>IProgress</code> instance to set
		 */		
		function set progress( $progress:IProgress ):void;
		
		/**
		 * Get the <code>IProgress</code> instance
		 *  
		 * @return IProgress
		 */		
		function get progress():IProgress;
	}
}