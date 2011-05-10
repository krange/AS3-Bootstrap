package as3bootstrap.common
{
	import as3bootstrap.common.model.vo.LocalizationVO;
	
	import flash.text.StyleSheet;
	
	import flashx.textLayout.debug.assert;
	
	import org.flexunit.asserts.assertNotNull;
	import org.osflash.signals.utils.SignalAsyncEvent;
	import org.osflash.signals.utils.handleSignal;
	import org.osflash.signals.utils.registerFailureSignal;

	/**
	 * BootstrapLoadTest
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange 
	 */
	public class BootstrapLoadTest
	{	
		private var _bootstrap : IBootstrap;
		
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
		 * Test the bootstrap load process with a blank parameters provided. 
		 * Result should be that the <code>bootstrapLoaded</code> and 
		 * <code>dataLoaded</code> are dispatched.
		 */		
		public function testLoadWithBlankParameters():void
		{
			var parameters : Object = {};
			_bootstrap = new Bootstrap();
			
			registerFailureSignal( this, _bootstrap.bootstrapResourceErrored );
			registerFailureSignal( this, _bootstrap.configErrored );
			handleSignal( this, _bootstrap.bootstrapLoaded, onBootstrapLoadComplete );
			handleSignal( this, _bootstrap.dataLoaded, onDataLoadComplete );
			
			_bootstrap.start( parameters );
			
			function onBootstrapLoadComplete( event:SignalAsyncEvent, data:Object ):void
			{
				assert();
			}
			
			function onDataLoadComplete( event:SignalAsyncEvent, data:Object ):void
			{
				assert();
			}
		}
		
		[Test(async)]
		/**
		 * Test the bootstrap load process with a null parameters provided. 
		 * Result should be that the <code>bootstrapLoaded</code> and 
		 * <code>dataLoaded</code> are dispatched.
		 */		
		public function testLoadWithNullParameters():void
		{
			var parameters : Object;
			_bootstrap = new Bootstrap();
			
			registerFailureSignal( this, _bootstrap.bootstrapResourceErrored );
			registerFailureSignal( this, _bootstrap.configErrored );
			handleSignal( this, _bootstrap.bootstrapLoaded, onBootstrapLoadComplete );
			handleSignal( this, _bootstrap.dataLoaded, onDataLoadComplete );
			
			_bootstrap.start( parameters );
			
			function onBootstrapLoadComplete( event:SignalAsyncEvent, data:Object ):void
			{
				assert();
			}
			
			function onDataLoadComplete( event:SignalAsyncEvent, data:Object ):void
			{
				assert();
			}
		}
		
		[Test(async)]
		/**
		 * Test the bootstrap load process with an incorrect URL provided. 
		 * Result should be that the <code>configErrored</code> is dispatched.
		 */		
		public function testLoadWithIncorrectConfigUrl():void
		{
			var parameters : Object = {};
			parameters.configXmlUrl = "config.xml";
			_bootstrap = new Bootstrap();
			
			registerFailureSignal( this, _bootstrap.bootstrapResourceErrored );
			registerFailureSignal( this, _bootstrap.bootstrapLoaded );
			handleSignal( this, _bootstrap.configErrored, onConfigLoadErrored );
			
			_bootstrap.start( parameters );
			
			function onConfigLoadErrored( event:SignalAsyncEvent, data:Object ):void
			{
				assert();
			}
		}
		
		[Test(async)]
		/**
		 * Test the bootstrap load process with an incorrect URL provided. 
		 * Result should be that the <code>configErrored</code> is dispatched.
		 */		
		public function testLoadWithConfigUrl():void
		{
			var parameters : Object = {};
			parameters.baseUrl = "";
			parameters.configXmlUrl = "xml/config-nodata.xml";
			_bootstrap = new Bootstrap();
			
			registerFailureSignal( this, _bootstrap.bootstrapResourceErrored );
			registerFailureSignal( this, _bootstrap.configErrored );
			handleSignal( this, _bootstrap.bootstrapLoaded, onBootstrapLoadComplete );
			handleSignal( this, _bootstrap.dataLoaded, onDataLoadComplete );
			
			_bootstrap.start( parameters );
			
			function onBootstrapLoadComplete( event:SignalAsyncEvent, data:Object ):void
			{
				assert();
			}
			
			function onDataLoadComplete( event:SignalAsyncEvent, data:Object ):void
			{
				assert();
			}
		}
		
		[Test(async)]
		/**
		 * Test the bootstrap load process a single stylesheet passed. Result
		 * should be that the first stylesheet property "some_style" should
		 * exist.
		 */		
		public function testLoadWithConfigUrlWithSingleStylesheet():void
		{
			var parameters : Object = {};
			parameters.baseUrl = "";
			parameters.configXmlUrl = "xml/config-ss-single.xml";
			_bootstrap = new Bootstrap();
			
			registerFailureSignal( this, _bootstrap.bootstrapResourceErrored );
			registerFailureSignal( this, _bootstrap.configErrored );
			handleSignal( this, _bootstrap.bootstrapLoaded, onBootstrapLoadComplete );
			
			_bootstrap.start( parameters );
			
			function onBootstrapLoadComplete( event:SignalAsyncEvent, data:Object ):void
			{
				assertNotNull( _bootstrap.stylesheetModel.stylesheets );
				
				var ss : StyleSheet = _bootstrap.stylesheetModel.stylesheets;
				var style : Object = ss.getStyle( ".some_style" );
				
				assertNotNull( style.color );
			}
		}
		
		[Test(async)]
		/**
		 * Test the bootstrap load process a multiple stylesheet passed. Result
		 * should be that the first stylesheet property "some_style" and 
		 * "some_style1" should exist.
		 */		
		public function testLoadWithConfigUrlWithMultipleStylesheet():void
		{
			var parameters : Object = {};
			parameters.baseUrl = "";
			parameters.configXmlUrl = "xml/config-ss-mult.xml";
			_bootstrap = new Bootstrap();
			
			registerFailureSignal( this, _bootstrap.bootstrapResourceErrored );
			registerFailureSignal( this, _bootstrap.configErrored );
			handleSignal( this, _bootstrap.bootstrapLoaded, onBootstrapLoadComplete );
			
			_bootstrap.start( parameters );
			
			function onBootstrapLoadComplete( event:SignalAsyncEvent, data:Object ):void
			{
				assertNotNull( _bootstrap.stylesheetModel.stylesheets );
				
				var ss : StyleSheet = _bootstrap.stylesheetModel.stylesheets;
				var style : Object = ss.getStyle( ".some_style" );
				var style1 : Object = ss.getStyle( ".some_style1" );
				
				assertNotNull( style.color );
				assertNotNull( style1.color );
			}
		}
		
		[Test(async)]
		/**
		 * Test the bootstrap load process a single localization passed. Result
		 * should be that the first localization should exist and the property
		 * "value1" should also exist
		 */			
		public function testLoadWithConfigUrlWithSingleLocalization():void
		{
			var parameters : Object = {};
			parameters.baseUrl = "";
			parameters.configXmlUrl = "xml/config-loc-single.xml";
			_bootstrap = new Bootstrap();
			
			registerFailureSignal( this, _bootstrap.bootstrapResourceErrored );
			registerFailureSignal( this, _bootstrap.configErrored );
			handleSignal( this, _bootstrap.bootstrapLoaded, onBootstrapLoadComplete );
			
			_bootstrap.start( parameters );
			
			function onBootstrapLoadComplete( event:SignalAsyncEvent, data:Object ):void
			{
				assertNotNull( _bootstrap.localizationModel.localizations );
				assertNotNull( _bootstrap.localizationModel.localizations.getLocalizedValue( "value1" ) );
			}
		}
	}
}