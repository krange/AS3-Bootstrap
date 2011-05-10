package as3bootstrap.common.services
{
	import as3bootstrap.common.progress.IProgress;
	import as3bootstrap.common.progress.Progress;
	import as3bootstrap.common.services.css.IStylesheetService;
	import as3bootstrap.common.services.css.StylesheetService;
	
	import org.flexunit.asserts.assertEquals;
	import org.osflash.signals.utils.SignalAsyncEvent;
	import org.osflash.signals.utils.handleSignal;
	import org.osflash.signals.utils.registerFailureSignal;

	/**
	 * StylesheetServiceTest
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange 
	 */
	public class StylesheetServiceTest
	{		
		private var _service : IStylesheetService;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		[Before]
		public function setUp():void
		{
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		//----------------------------------
		//  Tests
		//----------------------------------
		
		[Test(async)]
		/**
		 * Test that the service that does load. Result should be an
		 * <code>loaded</code> signal.
		 */
		public function testLoadServiceSuccess():void
		{
			_service = new StylesheetService();
			
			registerFailureSignal( this, _service.errored );
			handleSignal( this, _service.loaded, onServiceLoaded );
			
			_service.loadWithUrl( "css/styles.css" );
		}
		
		[Test(async)]
		/**
		 * Test that the service that does load with the provided progress. 
		 * Result should be an <code>loaded</code> signal.
		 */
		public function testLoadServiceWithProgressSuccess():void
		{
			var progress : IProgress = new Progress();
			_service = new StylesheetService( progress );
			
			registerFailureSignal( this, _service.errored );
			handleSignal( this, _service.loaded, onServiceLoaded );
			
			_service.loadWithUrl( "css/styles.css" );
		}
		
		[Test(async)]
		/**
		 * Test that the service that does not load. Result should be an
		 * <code>errored</code> signal.
		 */		
		public function testLoadServiceFailure():void
		{
			_service = new StylesheetService();
			
			registerFailureSignal( this, _service.loaded );
			handleSignal( this, _service.errored, onServiceErrored );
			
			_service.loadWithUrl( "styles.css" );		
		}
		
		[Test(async)]
		/**
		 * Test that the service that does not load with the provided progress. 
		 * Result should be an <code>errored</code> signal.
		 */		
		public function testLoadServiceWithProgressFailure():void
		{
			var progress : IProgress = new Progress();
			_service = new StylesheetService( progress );
			
			registerFailureSignal( this, _service.loaded );
			handleSignal( this, _service.errored, onServiceErrored );
			
			_service.loadWithUrl( "styles.css" );		
		}
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		//----------------------------------
		//  Handlers
		//----------------------------------
		
		/**
		 * Callback for when the service successfully loads. Asset that the 
		 * progress value is correct.
		 * 
		 * @param event SignalAsyncEvent
		 * @param data Object 
		 */		
		private function onServiceLoaded( event:SignalAsyncEvent, data:Object ):void
		{
			assertEquals( _service.progress.getAmountLoaded(), 1 );
		}
		
		/**
		 * Callback for when the service does not loads. Asset that the 
		 * progress value is correct.
		 * 
		 * @param event SignalAsyncEvent
		 * @param data Object 
		 */	
		private function onServiceErrored( event:SignalAsyncEvent, data:Object ):void
		{
			assertEquals( _service.progress.getAmountLoaded(), 0 );
		}
	}
}