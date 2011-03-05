package org.robotlegs.utilities.as3bootstrap.common.view
{
	import as3bootstrap.common.progress.IProgress;
	
	import org.robotlegs.core.IMediator;
	
	/**
	 * IBootstrapRobotlegsMediator.as
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