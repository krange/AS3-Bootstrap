package org.puremvc.as3.multicore.utilities.as3bootstrap.common.view.mediators
{
	import as3bootstrap.common.progress.IProgress;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	
	/**
	 * PureMVC mediator interface that have a stored progress instance
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange
	 */ 
	public interface IProgressMediator 
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