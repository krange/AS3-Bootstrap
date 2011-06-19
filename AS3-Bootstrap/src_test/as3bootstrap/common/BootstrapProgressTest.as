package as3bootstrap.common
{
	import as3bootstrap.common.progress.IProgress;
	import as3bootstrap.common.progress.Progress;
	
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertTrue;
	
	/**
	 * Bootstrap progress tests
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange 
	 */
	public class BootstrapProgressTest
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
		
		[Test]
		/**
		 * Test the default progress setup of bootstrap. This is passing in no
		 * progress instances. Bootstrap should create all progress instances
		 */		
		public function testProgressDefault():void
		{
			_bootstrap = new Bootstrap();
			progressExists();
			_bootstrap = null;
		}
		
		[Test]
		/**
		 * Test the progress setup of bootstrap of passing in a main progress 
		 * instance. Bootstrap should use the progress instances specified and 
		 * create all child progress instances.
		 */		
		public function testProgressPassedProgress():void
		{
			var progress : IProgress = new Progress();
			
			_bootstrap = new Bootstrap( progress );
			progressExists();
			
			assertTrue( _bootstrap.progress == progress );
			
			_bootstrap = null;
		}
		
		[Test]
		/**
		 * Test the progress setup of bootstrap of passing in a main progress 
		 * and a data progress. Bootstrap should use both progress instances and
		 * create a child view progress. 
		 */		
		public function testProgressPassedProgressAndDataProgress():void
		{
			var progress : IProgress = new Progress();
			var dataProgress : IProgress = new Progress();
			_bootstrap = new Bootstrap( progress, dataProgress );
			progressExists();
			
			assertTrue( _bootstrap.progress == progress );
			assertFalse( _bootstrap.dataProgress == dataProgress );
			
			_bootstrap = null;
		}
		
		[Test]
		/**
		 * Test the progress setup of bootstrap of passing in a main progress
		 * instance as well as non-child data and view progress instance. 
		 * Bootstrap should use the main progress instance but not the data and 
		 * view as they are not direct child instances. 
		 */		
		public function testProgressPassedProgressAndDataProgressAndViewProgress():void
		{
			var progress : IProgress = new Progress();
			var dataProgress : IProgress = new Progress();
			var viewProgress : IProgress = new Progress();
			_bootstrap = new Bootstrap( progress, dataProgress, viewProgress );
			progressExists();
			
			assertTrue( _bootstrap.progress == progress );
			assertFalse( _bootstrap.dataProgress == dataProgress );
			assertFalse( _bootstrap.viewProgress == viewProgress );
			
			_bootstrap = null;
		}
		
		[Test]
		/**
		 * Test the progress setup of bootstrap of passing in a main progress
		 * instance as well as child data progress instance. Bootstrap should 
		 * use the main progress instance and the data progress instance as well
		 * as create a view progress instance. 
		 */
		public function testProgressPassedProgressAndChildDataProgress():void
		{
			var progress : IProgress = new Progress();
			var dataProgress : IProgress = new Progress();
			progress.addChildLoadable( dataProgress );
			
			_bootstrap = new Bootstrap( progress, dataProgress );
			progressExists();
			
			assertTrue( _bootstrap.progress == progress );
			assertTrue( _bootstrap.dataProgress == dataProgress );
			
			_bootstrap = null;
		}
		
		[Test]
		/**
		 * Test the progress setup of bootstrap of passing in a main progress
		 * instance as well as child data and view progress instances. Bootstrap 
		 * should use all passed in progress instances. 
		 */
		public function testProgressPassedProgressAndChildDataProgressAndChildViewProgress():void
		{
			var progress : IProgress = new Progress();
			var dataProgress : IProgress = new Progress();
			var viewProgress : IProgress = new Progress();
			progress.addChildLoadable( dataProgress );
			progress.addChildLoadable( viewProgress );
			
			_bootstrap = new Bootstrap( progress, dataProgress, viewProgress );
			progressExists();
			
			assertTrue( _bootstrap.progress == progress );
			assertTrue( _bootstrap.dataProgress == dataProgress );
			assertTrue( _bootstrap.viewProgress == viewProgress );
			
			_bootstrap = null;
		}
		
		//---------------------------------------------------------------------
		//
		//  Private methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * @private
		 * Commonly used test asserts
		 */		
		private function progressExists():void
		{
			// Test that all progress values exist
			assertNotNull( _bootstrap.progress );
			assertNotNull( _bootstrap.dataProgress );
			assertNotNull( _bootstrap.viewProgress );
			
			assertTrue( _bootstrap.progress.isChildLoadable( _bootstrap.dataProgress ) );
			assertTrue( _bootstrap.progress.isChildLoadable( _bootstrap.viewProgress ) );
		}
	}
}