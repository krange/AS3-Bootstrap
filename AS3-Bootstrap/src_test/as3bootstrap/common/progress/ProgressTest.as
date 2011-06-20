package as3bootstrap.common.progress
{
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;
	
	/**
	 * ProgressTest
	 * 
	 * @author krisrange
	 */
	public class ProgressTest
	{
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
		 * Test creating a progress with a specified weight
		 */		
		public function testCreateProgressWithWeight():void
		{
			var progress : IProgress = new Progress( 5 );
			
			assertEquals( progress.getWeight(), 5 );
		}
		
		[Test]
		/**
		 * Test creating a progress with a specified ID
		 */		
		public function testCreateProgressWithId():void
		{
			var progress : IProgress = new Progress( 1, "SOME_ID" );
			
			assertEquals( progress.getId(), "SOME_ID" );
		}
		
		[Test]
		/**
		 * Test creating a progress to be a child of another progress
		 */		
		public function testCreateChildProgress():void
		{
			var progress : IProgress = new Progress();
			var childProgress : IProgress = progress.createChildLoadable();
			
			assertTrue( progress.isChildLoadable( childProgress ) );
		}
		
		[Test]
		/**
		 * Test creating a progress to be a child of another progress has a
		 * specified weight
		 */		
		public function testCreateChildProgressWithWeight():void
		{
			var progress : IProgress = new Progress();
			var childProgress : IProgress = progress.createChildLoadable( 5 );
			
			assertEquals( childProgress.getWeight(), 5 );
		}
		
		[Test]
		/**
		 * Test creating a progress to be a child of another progress has a
		 * specified weight
		 */		
		public function testCreateChildProgressWithId():void
		{
			var progress : IProgress = new Progress();
			var childProgress : IProgress = progress.createChildLoadable( 1, "SOME_ID" );
			
			assertEquals( childProgress.getId(), "SOME_ID" );
		}
		
		[Test]
		/**
		 * Test adding a progress to be a child of another progress
		 */		
		public function testSetProgressToBeChildProgress():void
		{
			var progress : IProgress = new Progress();
			var childProgress : IProgress = new Progress();
			
			progress.addChildLoadable( childProgress );
			
			assertTrue( progress.isChildLoadable( childProgress ) );
		}
		
		[Test]
		/**
		 * Test retrieving a child of another progress by it's ID
		 */		
		public function testRetrieveChildProgressById():void
		{
			var progress : IProgress = new Progress();
			var childProgress : IProgress = new Progress( 1, "SOME_ID" );
			
			progress.addChildLoadable( childProgress );
			
			assertEquals( childProgress, progress.retrieveChildLoadable( "SOME_ID" ) );
		}
		
		[Test]
		/**
		 * Test adding a progress to be a child of another progress for which it
		 * is not a parent progress instance
		 */		
		public function testRetrieveChildProgressByIdFromProgressWhichIsNotAChild():void
		{
			var progress : IProgress = new Progress();
			var childProgress : IProgress = new Progress( 1, "SOME_ID" );
			
			assertNull( progress.retrieveChildLoadable( "SOME_ID" ) );
		}
		
		[Test]
		/**
		 * Test checking to see if the specified progress instance has child
		 * loadable instances
		 */		
		public function testHasChildLoadables():void
		{
			var progress : IProgress = new Progress();
			var childProgress : IProgress = new Progress();
			
			progress.addChildLoadable( childProgress );
			
			assertTrue( progress.hasChildLoadables() );
		}
		
		[Test]
		/**
		 * Test removing a progress from being a child of another progress
		 */		
		public function testRemoveProgressFromParentProgress():void
		{
			var progress : IProgress = new Progress();
			var childProgress : IProgress = new Progress();
			
			progress.addChildLoadable( childProgress );
			
			assertTrue( progress.removeChildLoadable( childProgress ) );
			assertFalse( progress.isChildLoadable( childProgress ) );
		}
		
		[Test]
		/**
		 * Test removing a progress from being a child of another progress that 
		 * is not actually a child progress. 
		 */		
		public function testRemoveProgressFromParentProgressThatIsNotChild():void
		{
			var progress : IProgress = new Progress();
			var childProgress : IProgress = new Progress();
			
			assertFalse( progress.removeChildLoadable( childProgress ) );
			assertFalse( progress.isChildLoadable( childProgress ) );
		}
	}
}