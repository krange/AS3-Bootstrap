package as3bootstrap.flex.common.view.components.preloader
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.geom.Point;
	
	import mx.events.RSLEvent;
	import mx.preloaders.IPreloaderDisplay;
	
	/**
	 * Abstract implementation of a custom Flex preloader. This is used in place 
	 * of the default preloader used by Flex to load up applications. 
	 * 
	 * In order to use this class, you must override the 
	 * <code>getPreloaderAssetClass()</code> method in the child and return the 
	 * class asset needed. Then in your Flex Application MXML class:
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange
	 */ 
	public class FlexPreloaderDisplay 
		extends Sprite 
		implements IPreloaderDisplay
	{
		private static const ERROR_NO_PRELOADER_DISPLAY 		: String = "The getPreloaderDisplay() method must be overriden.";
		
		private var _stageSize : Point;
		private var _initProgressCounter : Number = 0;
		
		//----------------------------------
		//  UI components
		//----------------------------------
		
		private var _preloaderDisplay : MovieClip;
		private var _preloader : Sprite;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 */ 
		public function FlexPreloaderDisplay() 
		{
			stageSize = new Point();
			super();
		}
		
		/** 
		 * Called once the preloader has initialized 
		 */
		public function initialize():void 
		{
			// Add the preloader
			addPreloader();
			
			// Update the stage initially
			updateStage();
			
			// Setup load progress
			setupLoadProgress();
		}
		
		//---------------------------------------------------------------------
		//
		//  Protected methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Add the preloader to the stage
		 */		
		protected function addPreloader():void
		{
			preloaderDisplay = getPreloaderDisplay();
			addChild( preloaderDisplay );
		}
		
		/**
		 * Gets the preloader display to initialize it. This method must be 
		 * overriden in subclass.
		 * 
		 * @return MovieClip 
		 */		
		protected function getPreloaderDisplay():MovieClip
		{
			throw new Error( ERROR_NO_PRELOADER_DISPLAY );
		}
		
		/**
		 * Sets up all preload event listeners
		 */ 
		protected function setupLoadEventListeners():void 
		{
			// Handle resize event for preload centering, if needed
			stage.addEventListener( Event.RESIZE, handleStageResize, false, 0, true );
			
			// Add load tracking to flex preloaders
			_preloader.addEventListener( Event.REMOVED, handleDisplayListChanged, false, 0, true );
			_preloader.addEventListener( Event.COMPLETE, handleComplete, false, 0, true );
			_preloader.addEventListener( ProgressEvent.PROGRESS, handleProgress, false, 0, true );
			_preloader.addEventListener( RSLEvent.RSL_PROGRESS, rslProgressHandler, false, 0, true );
			_preloader.addEventListener( RSLEvent.RSL_COMPLETE, rslCompleteHandler, false, 0, true );
			_preloader.addEventListener( RSLEvent.RSL_ERROR, rslErrorHandler, false, 0, true );
		}
		
		/** 
		 * Setup the load progresses for the preloader.
		 */
		protected function setupLoadProgress():void 
		{
			// Override
		}
		
		/**
		 * This method is called each time the preloader is updated 
		 * as well as when the Event.RESIZE is dispatched. Override
		 * this method if preloader center isn't needed
		 */ 
		protected function updateStage():void 
		{
			// center asset on stage
			if( preloaderDisplay ) 
			{
				preloaderDisplay.x = Math.ceil( ( stage.stageWidth - preloaderDisplay.width ) / 2 );
				preloaderDisplay.y = Math.ceil( ( stage.stageHeight - preloaderDisplay.height ) / 2 );
			}
		}
		
		/**
		 * Update the amount the preloader shows has completed
		 * 
		 * @param amount Amount to update
		 */ 
		protected function updatePreloaderAmount( amount:Number ):void 
		{
			// If the preloader asset exists, 
			if( preloaderDisplay ) 
			{
				preloaderDisplay.gotoAndStop( Math.floor( amount ) );
			}
		}
		
		/** 
		 * Indicate the preload is complete and dispatch a 
		 * Event.COMPLETE event. This initiates the process to
		 * remove the preloader from the stage and the actual
		 * application is shown
		 */
		protected function preloadComplete():void 
		{
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
		
		//----------------------------------
		//  UI components
		//----------------------------------
		
		/**
		 * Callback for when the stage is resized
		 * 
		 * @param event <code>Event.RESIZE</code>
		 */ 
		protected function handleStageResize( event:Event ):void 
		{
			// Update the stage
			updateStage();
		}
        
		/** 
		 * Clean up when we are removed from the display list 
		 * 
		 * @param event <code>Event>REMOVED</code>
		 */
		protected function handleDisplayListChanged( event:Event ):void 
		{
			if( event.type == Event.REMOVED ) 
			{
				stage.removeEventListener( Event.RESIZE, handleStageResize );
				_preloader.removeEventListener( Event.REMOVED, handleDisplayListChanged );
				_preloader.removeEventListener( ProgressEvent.PROGRESS, handleProgress );
				_preloader.removeEventListener( Event.COMPLETE, handleComplete );
				_preloader.removeEventListener( RSLEvent.RSL_PROGRESS, rslProgressHandler );
				_preloader.removeEventListener( RSLEvent.RSL_COMPLETE, rslCompleteHandler );
				_preloader.removeEventListener( RSLEvent.RSL_ERROR, rslErrorHandler );
				
				removeChild( preloaderDisplay );
				preloaderDisplay = null;
			}
		}
		
		/** 
		 * Listen for Flex app load progress events 
		 * 
		 * @param event <code>ProgressEvent.PROGRESS</code>
		 */
		protected function handleProgress( event:ProgressEvent ):void 
		{
			// Override
		}
		
		/** 
		 * 
		 * 
		 * @param event <code>RSLEvent.RSL_ERROR</code>
		 */
		protected function rslErrorHandler( event:RSLEvent ):void 
		{
		}
		
		/**
		 * 
		 * 
		 * @param event <code>RSLEvent.RSL_PROGRESS</code> 
		 */		
		protected function rslProgressHandler( event:RSLEvent ):void 
		{
		}
		
		/**
		 * 
		 *
		 * @param event <code>RSLEvent.RSL_COMPLETE</code> 
		 */		
		protected function rslCompleteHandler( event:RSLEvent ):void 
		{
		}
		
		/** 
		 * Callback for when Flex application has loaded. Now initialize Flex
		 * 
		 * @param event <code>Event.COMPLETE</code> 
		 */
		protected function handleComplete( e : Event ): void 
		{
			// Complete application load
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		//----------------------------------
		//  Protected
		//----------------------------------
		
		/**
		 * Get the preloader movieclip
		 *  
		 * @return MovieClip
		 */		
		protected function get preloaderDisplay():MovieClip { return _preloaderDisplay; }
		protected function set preloaderDisplay( value:MovieClip ):void
		{
			_preloaderDisplay = value;
		}
		
		/**
		 * Get the stage size point
		 *  
		 * @return Point
		 */		
		protected function get stageSize():Point { return _stageSize; }
		protected function set stageSize( value:Point ):void
		{
			_stageSize = value;
		}
		
		/**
		 * Get the progress initialization counter
		 *  
		 * @return Number
		 */		
		protected function get initProgressCounter():Number { return _initProgressCounter; }
		protected function set initProgressCounter( value:Number ):void
		{
			_initProgressCounter = value;
		}
		
		//----------------------------------
		//  Public
		//----------------------------------
		
		/**
		 * Sets the preloader to use
		 * 
		 * @param preloader Preloader
		 */ 
		public function set preloader( preloader:Sprite ):void 
		{
			// Set the preloader
			_preloader = preloader;
			
			// Sets up preload event listeners
			setupLoadEventListeners();
		}
		
		public function get backgroundColor() : uint { return 0; }
		public function set backgroundColor( value : uint ):void {}

		public function get backgroundAlpha() : Number { return 0; }
		public function set backgroundAlpha( value : Number ):void {}
		
		public function get backgroundImage() : Object { return undefined; }
		public function set backgroundImage( value : Object ):void {}

		public function get backgroundSize() : String { return ""; }
		public function set backgroundSize( value : String ):void {}

		public function get stageWidth() : Number { return stageSize.x; }
		public function set stageWidth( w : Number ):void { stageSize.x = w; }

		public function get stageHeight() : Number { return stageSize.y; }
		public function set stageHeight( h : Number ):void { stageSize.y = h; }
	}
}