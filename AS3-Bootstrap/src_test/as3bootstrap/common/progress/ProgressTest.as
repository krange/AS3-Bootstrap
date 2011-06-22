package as3bootstrap.common.progress
{
	import as3bootstrap.common.events.ResourceProgressEvent;
	
	import flashx.textLayout.debug.assert;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;
	
	/**
	 * ProgressTest
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
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
		 * Test creating a progress with a specified weight
		 */		
		public function testCreateProgressWithIdAfterInstantiation():void
		{
			var progress : IProgress = new Progress();
			progress.setId( "SOME_ID" );
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
		 * Test setting the amount loaded on a progress instance that also has
		 * child progress instances
		 */		
		public function testSetAmountLoadOnProgressThatHasChildProgress():void
		{
			var progress : IProgress = new Progress();
			var childProgress : IProgress = new Progress();
			
			progress.addEventListener( ResourceProgressEvent.PROGRESS, onProgressUpdate );
			progress.addChildLoadable( childProgress );
			progress.setAmountLoaded( 1 );
			
			function onProgressUpdate( event:ResourceProgressEvent ):void
			{
				progress.removeEventListener( ResourceProgressEvent.PROGRESS, onProgressUpdate );
				assertEquals( 0, progress.getAmountLoaded() );
			}
		}
		
		[Test(async)]
		/**
		 * Test setting the amount loaded on a child progress instance that has 
		 * a parent progress instances
		 */		
		public function testSetAmountLoadOnChildProgressThatHasParentProgress():void
		{
			var progress : IProgress = new Progress();
			var childProgress : IProgress = new Progress();
			
			progress.addEventListener( ResourceProgressEvent.PROGRESS, onProgressUpdate );
			progress.addChildLoadable( childProgress );
			childProgress.setAmountLoaded( 1 );
			
			function onProgressUpdate( event:ResourceProgressEvent ):void
			{
				progress.removeEventListener( ResourceProgressEvent.PROGRESS, onProgressUpdate );
				assertEquals( 1, progress.getAmountLoaded() );
			}
		}
		
		[Test(async)]
		/**
		 * Test setting the amount loaded on multiple child progress instance 
		 * that have parent progress instances
		 */		
		public function testSetAmountLoadOnMultipleChildProgressThatHasParentProgress():void
		{
			var progress : IProgress = new Progress();
			var child : IProgress = new Progress();
			var child1 : IProgress = new Progress();
			
			progress.addEventListener( ResourceProgressEvent.PROGRESS, onProgressUpdate );
			progress.addChildLoadable( child );
			progress.addChildLoadable( child1 );
			
			child.setAmountLoaded( 1 );
			child1.setAmountLoaded( 1 );
			
			function onProgressUpdate( event:ResourceProgressEvent ):void
			{
				progress.removeEventListener( ResourceProgressEvent.PROGRESS, onProgressUpdate );
				assertEquals( 1, progress.getAmountLoaded() );
			}
		}
		
		[Test(async)]
		/**
		 * Test setting the amount loaded on a complex progress structure and 
		 * validate that the correct values are dispatched out
		 */		
		public function testSetAmountLoadOnComplexProgressSetup():void
		{
			var progress : IProgress = new Progress();
			var child : IProgress = new Progress();
			var child1 : IProgress = new Progress();
			var child2 : IProgress = new Progress();
			var child3 : IProgress = new Progress();
			
			progress.addEventListener( ResourceProgressEvent.PROGRESS, onProgressUpdate );
			progress.addChildLoadable( child );
			progress.addChildLoadable( child1 );
			
			child.addChildLoadable( child2 );
			child.addChildLoadable( child3 );
			
			child2.addEventListener( ResourceProgressEvent.PROGRESS, onChildProgressUpdate );
			child2.setAmountLoaded( 1 );
			
			function onProgressUpdate( event:ResourceProgressEvent ):void
			{
				if( event.amountLoaded == 0.5 )
				{
					progress.removeEventListener( ResourceProgressEvent.PROGRESS, onProgressUpdate );
					assert();
				}
			}
			
			function onChildProgressUpdate( event:ResourceProgressEvent ):void
			{
				child2.removeEventListener( ResourceProgressEvent.PROGRESS, onProgressUpdate );
				child3.setAmountLoaded( 1 );
			}
		}
		
		[Test(async)]
		/**
		 * Test setting the amount loaded on a complex progress structure and 
		 * validate that the correct values are dispatched out when assigning 
		 * weights to the progress instances
		 */		
		public function testSetAmountLoadOnComplexProgressSetupWithWeight():void
		{
			var progress : IProgress = new Progress();
			var child : IProgress = new Progress( 8 );
			var child1 : IProgress = new Progress( 2 );
			var child2 : IProgress = new Progress();
			var child3 : IProgress = new Progress();
			
			progress.addEventListener( ResourceProgressEvent.PROGRESS, onProgressUpdate );
			progress.addChildLoadable( child );
			progress.addChildLoadable( child1 );
			
			child.addChildLoadable( child2 );
			child.addChildLoadable( child3 );
			
			child2.addEventListener( ResourceProgressEvent.PROGRESS, onChildProgressUpdate );
			child2.setAmountLoaded( 1 );
			
			function onProgressUpdate( event:ResourceProgressEvent ):void
			{
				if( event.amountLoaded == 0.8 )
				{
					progress.removeEventListener( ResourceProgressEvent.PROGRESS, onProgressUpdate );
					assert();
				}
			}
			
			function onChildProgressUpdate( event:ResourceProgressEvent ):void
			{
				child2.removeEventListener( ResourceProgressEvent.PROGRESS, onProgressUpdate );
				child3.setAmountLoaded( 1 );
			}
		}
		
		[Test(async)]
		/**
		 * Test that on a complex setup of instances that the progress update 
		 * progress event total equals the same total that is reported from the 
		 * progress instance
		 */		
		public function testComplexOnProgressUpdateThatProgressEventEqualsSameTotalAsProgressInstance():void
		{
			var progress : IProgress = new Progress();
			var child : IProgress = new Progress();
			var child1 : IProgress = new Progress();
			var child2 : IProgress = new Progress();
			var child3 : IProgress = new Progress();
			
			progress.addEventListener( ResourceProgressEvent.PROGRESS, onProgressUpdate );
			progress.addChildLoadable( child );
			progress.addChildLoadable( child1 );
			
			child.addChildLoadable( child2 );
			child.addChildLoadable( child3 );
			
			child2.addEventListener( ResourceProgressEvent.PROGRESS, onChildProgressUpdate );
			child2.setAmountLoaded( 1 );
			
			function onProgressUpdate( event:ResourceProgressEvent ):void
			{
				if( event.amountLoaded == 0.5 )
				{
					progress.removeEventListener( ResourceProgressEvent.PROGRESS, onProgressUpdate );
					assertEquals( event.amountLoaded, progress.getAmountLoaded() );
				}
			}
			
			function onChildProgressUpdate( event:ResourceProgressEvent ):void
			{
				child2.removeEventListener( ResourceProgressEvent.PROGRESS, onProgressUpdate );
				child3.setAmountLoaded( 1 );
			}
		}
		
		[Test(async)]
		/**
		 * Test that on a simple setup of instances that the progress update 
		 * progress event total equals the same total that is reported from the 
		 * progress instance
		 */		
		public function testSimpleOnProgressUpdateThatProgressEventEqualsSameTotalAsProgressInstance():void
		{
			var progress : IProgress = new Progress();
			progress.addEventListener( ResourceProgressEvent.PROGRESS, onProgressUpdate );
			progress.setAmountLoaded( 0.5 );
			
			function onProgressUpdate( event:ResourceProgressEvent ):void
			{
				if( event.amountLoaded == 0.5 )
				{
					progress.removeEventListener( ResourceProgressEvent.PROGRESS, onProgressUpdate );
					assertEquals( event.amountLoaded, progress.getAmountLoaded() );
				}
			}
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