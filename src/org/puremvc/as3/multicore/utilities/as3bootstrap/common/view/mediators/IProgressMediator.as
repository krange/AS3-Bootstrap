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
		 * Sets a new progress reference to this mediator
		 * 
		 * @param progress IProgress instance 
		 */ 
		function set progress( progress : IProgress ) : void
		
		/** 
		 * @return IProgress IProgress instance associated to this mediator 
		 */
		function get progress() : IProgress
	}
}