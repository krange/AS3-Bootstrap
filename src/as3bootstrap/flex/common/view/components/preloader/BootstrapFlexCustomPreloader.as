package as3bootstrap.flex.common.view.components.preloader
{
	import as3bootstrap.common.constants.BootstrapConstants;
	import as3bootstrap.common.events.ResourceProgressEvent;
	import as3bootstrap.common.progress.IProgress;
	import as3bootstrap.common.progress.Progress;
	import as3bootstrap.common.progress.ProgressManager;
	
	import flash.events.ProgressEvent;
	import flash.geom.Point;
	
	/**
	 * Custom preloader for Flex applications that use bootstrap
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange
	 */
	public class BootstrapFlexCustomPreloader
		extends FlexPreloaderDisplay
	{
		private static const ERROR_NO_PRELOADER_DISPLAY : String = "The getPreloaderDisplay() method must be overriden.";
		
		private var _stageSize : Point;
		private var _initProgressCounter : Number;
		private var _preloaderInitialized : Boolean;
		
		//----------------------------------
		//  Progress
		//----------------------------------
		
		private var _appProgress : IProgress;
		private var _flexAppProgress : IProgress;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 */ 
		public function BootstrapFlexCustomPreloader() 
		{
			super();
		}
		
		//---------------------------------------------------------------------
		//
		//  Protected methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Returns the IProgress instance to use for the Flex SWF
		 * load during the entire load process
		 * 
		 * @return IProgress The IProgress instance to use
		 */ 
		protected function getFlexAppProgress():IProgress
		{
			return new Progress( 4 );
		}
		
		/**
		 * Returns the IProgress instance to use for the data
		 * load during the entire load process
		 * 
		 * @return IProgress The IProgress instance to use
		 */ 
		protected function getDataLoadProgress():IProgress 
		{
			return new Progress( 3 );
		}
		
		/**
		 * Returns the IProgress instance to use for the view
		 * load during the entire load process
		 * 
		 * @return IProgress The IProgress instance to use
		 */ 
		protected function getViewLoadProgress():IProgress 
		{
			return new Progress( 3 );
		}
		
		//----------------------------------
		//  Override
		//----------------------------------
		
		/**
		 * @inheritDocs 
		 */		
		override protected function setupLoadProgress():void 
		{
			// Retreive the application progress tracker
			appProgress = ProgressManager.getInstance();
			
			// Add load listeners
			appProgress.addEventListener( ResourceProgressEvent.PROGRESS, handlePreloadUpdate, false, 0, true );
			appProgress.addEventListener( ResourceProgressEvent.FORCE_QUIT, handlePreloadForceQuit, false, 0, true );
			
			// Track flex app load
			flexAppProgress = getFlexAppProgress();
			flexAppProgress.setId( BootstrapConstants.PRELOAD_FLEX_APP );
			
			// Track data load
			var dataLoadProgress : IProgress = getDataLoadProgress();
			dataLoadProgress.setId( BootstrapConstants.PRELOAD_DATA );
			
			// Track view load
			var viewLoadProgress : IProgress = getViewLoadProgress();
			viewLoadProgress.setId( BootstrapConstants.PRELOAD_VIEW );
			
			// We instantiate a singleton load manager so we have the ability
			// to track loading across flex preload and application preload states
			appProgress.addChildLoadable( flexAppProgress );
			appProgress.addChildLoadable( dataLoadProgress );
			appProgress.addChildLoadable( viewLoadProgress );
		}
		
		override protected function handleProgress( event:ProgressEvent ):void 
		{
			// Set the flex application progress
			flexAppProgress.setAmountLoaded( event.bytesLoaded / event.bytesTotal );
			
			// Update the preload amount
			updatePreloaderAmount( Math.floor( appProgress.getAmountLoaded() * 100 ) );
		}
		
		//----------------------------------
		//  Handlers
		//----------------------------------
		
		/** 
		 * Called if the progress needs to force quit, for instance if
		 * an error has occurred
		 * 
		 * @param e <code>ResourceProgressEvent.FORCE_QUIT</code>
		 */ 
		protected function handlePreloadForceQuit( event:ResourceProgressEvent ):void 
		{
			preloadComplete();
		}
		
		/** 
		 * Handle progress update and status events from 
		 * the IProgress appProgress
		 * 
		 * @param event <code>ResourceProgressEvent.PROGRESS</code>
		 */
		protected function handlePreloadUpdate( event:ResourceProgressEvent ):void 
		{
			// Update the stage
			updateStage();
			
			// Get the progress amount loaded
			var amountLoaded : Number = appProgress.getAmountLoaded() * 100;
			
			// Update preloader amount
			updatePreloaderAmount( amountLoaded );
			
			// If the amount loaded is greater or equal to 100%, 
			// set the preload complete
			if( amountLoaded >= 100 ) 
			{
				preloadComplete();
			}
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Get/Set the application progress
		 *  
		 * @return IProgress
		 */		
		protected function get appProgress():IProgress { return _appProgress; }
		protected function set appProgress( value:IProgress ):void
		{
			_appProgress = value;
		}
		
		/**
		 * Get/Set the flex application progress
		 *  
		 * @return IProgress
		 */		
		protected function get flexAppProgress():IProgress { return _flexAppProgress; }
		protected function set flexAppProgress( value:IProgress ):void
		{
			_flexAppProgress = value;
		}
	}
}