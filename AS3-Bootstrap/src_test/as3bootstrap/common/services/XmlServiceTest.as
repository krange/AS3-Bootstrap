package as3bootstrap.common.services
{
	import as3bootstrap.common.progress.IProgress;
	import as3bootstrap.common.progress.Progress;
	import as3bootstrap.common.services.xml.IXmlService;
	import as3bootstrap.common.services.xml.XmlService;
	
	import org.flexunit.asserts.assertEquals;
	import org.osflash.signals.utils.SignalAsyncEvent;
	import org.osflash.signals.utils.handleSignal;
	import org.osflash.signals.utils.registerFailureSignal;

	/**
	 * XmlServiceTest
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange 
	 */
	public class XmlServiceTest
	{		
		private var _service : IXmlService;
		
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
			_service = new XmlService();
			
			registerFailureSignal( this, _service.errored );
			handleSignal( this, _service.loaded, onServiceLoaded );
			
			_service.loadWithUrl( "xml/config.xml" );
		}
		
		[Test(async)]
		/**
		 * Test that the service that does load with the provided progress. 
		 * Result should be an <code>loaded</code> signal.
		 */
		public function testLoadServiceWithProgressSuccess():void
		{
			var progress : IProgress = new Progress();
			_service = new XmlService( progress );
			
			registerFailureSignal( this, _service.errored );
			handleSignal( this, _service.loaded, onServiceLoaded );
			
			_service.loadWithUrl( "xml/config.xml" );
		}
		
		[Test(async)]
		/**
		 * Test that the service that does not load. Result should be an
		 * <code>errored</code> signal.
		 */		
		public function testLoadServiceFailure():void
		{
			_service = new XmlService();
			
			registerFailureSignal( this, _service.loaded );
			handleSignal( this, _service.errored, onServiceErrored );
			
			_service.loadWithUrl( "config.xml" );		
		}
		
		[Test(async)]
		/**
		 * Test that the service that does not load with the provided progress. 
		 * Result should be an <code>errored</code> signal.
		 */		
		public function testLoadServiceWithProgressFailure():void
		{
			var progress : IProgress = new Progress();
			_service = new XmlService( progress );
			
			registerFailureSignal( this, _service.loaded );
			handleSignal( this, _service.errored, onServiceErrored );
			
			_service.loadWithUrl( "config.xml" );		
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