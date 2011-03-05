package org.robotlegs.utilities.as3bootstrap.common.view
{
	import as3bootstrap.common.progress.IProgress;
	
	import org.robotlegs.mvcs.Mediator;
	import org.robotlegs.utilities.as3bootstrap.common.model.events.BootstrapStatusEvent;
	
	/**
	 * BootstrapRobotlegsApplicationMediator
	 * 
	 * @author krisrange
	 */
	public class BootstrapMediator 
		extends Mediator
		implements IBootstrapMediator
	{
		//----------------------------------
		//  Private
		//----------------------------------
		
		private var _progress : IProgress;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		public function BootstrapMediator()
		{
			super();
		}
		
		//----------------------------------
		//  Override
		//----------------------------------
		
		/**
		 * @inheritDoc 
		 */		
		override public function onRegister():void
		{
			eventDispatcher.addEventListener( BootstrapStatusEvent.BOOTSTRAP_LOAD_COMPLETE, onBootstrapLoadComplete );
			eventDispatcher.addEventListener( BootstrapStatusEvent.DATA_LOAD_COMPLETE, onDataLoadComplete );
			eventDispatcher.addEventListener( BootstrapStatusEvent.APPLICATION_LOAD_COMPLETE, onApplicationLoadComplete );
		}
		
		//---------------------------------------------------------------------
		//
		//  Protected methods
		//
		//---------------------------------------------------------------------
		
		//----------------------------------
		//  Handlers
		//----------------------------------
		
		/**
		 * Callback for when bootstrap has loaded complete
		 * 
		 * @param $event <code>BootstrapStatusEvent</code>
		 */		
		protected function onBootstrapLoadComplete( $event:BootstrapStatusEvent ):void
		{
		}
		
		/**
		 * Callback for when the application data has loaded complete
		 * 
		 * @param $event <code>BootstrapStatusEvent</code>
		 */	
		protected function onDataLoadComplete( $event:BootstrapStatusEvent ):void
		{
		}
		
		/**
		 * Callback for when the application has loaded complete
		 * 
		 * @param $event <code>BootstrapStatusEvent</code>
		 */	
		protected function onApplicationLoadComplete( $event:BootstrapStatusEvent ):void
		{
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Set the <code>IProgress</code> instance
		 * 
		 * @param $progress <code>IProgress</code> instance to set
		 */		
		public function set progress( $progress:IProgress ):void
		{
			_progress = $progress;
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