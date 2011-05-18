package org.puremvc.as3.multicore.utilities.as3bootstrap.flash.view.mediators
{
	import as3bootstrap.common.progress.IProgress;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.as3bootstrap.common.view.mediators.IBootstrapMediator;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlashMediator;
	
	/**
	 * BootstrapFlashMediator
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange 
	 */
	public class BootstrapFlashMediator 
		extends FlashMediator 
		implements IBootstrapMediator
	{
		private var _progress : IProgress;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 * 
		 * @param name
		 * @param viewComponent
		 * @param progress 
		 */		
		public function BootstrapFlashMediator(
			name:String, 
			viewComponent:Object,
			progress:IProgress=null )
		{
			super( name, viewComponent );
			_progress = progress;
		}
		
		//----------------------------------
		//  respondTo methods
		//----------------------------------
		
		/**
		 * Responds to when the bootstrap load complete has been dispatched
		 * 
		 * @param notification 
		 */		
		public function respondToBootstrapLoadComplete( notification:INotification ):void
		{
		}
		
		/**
		 * Responds to when the data load complete has been dispatched
		 * 
		 * @param notification 
		 */		
		public function respondToDataLoadComplete( notification:INotification ):void
		{
		}
		
		/**
		 * Responds to when the application load complete has been dispatched
		 * 
		 * @param notification 
		 */		
		public function respondToApplicationLoadComplete( notification:INotification ):void
		{
		}
		
		//----------------------------------
		//  Override
		//----------------------------------
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Set the <code>IProgress</code> instance
		 * 
		 * @param progress <code>IProgress</code> instance to set
		 */		
		public function set progress( progress:IProgress ):void
		{
			_progress = progress;
		}
		
		/**
		 * Get the <code>IProgress</code> instance
		 *  
		 * @return IProgress
		 */		
		public function get progress():IProgress
		{
			return _progress;
		}
	}
}