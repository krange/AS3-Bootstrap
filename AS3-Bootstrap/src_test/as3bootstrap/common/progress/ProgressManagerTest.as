package as3bootstrap.common.progress
{
	import org.flexunit.asserts.assertEquals;

	/**
	 * ProgressManagerTest
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange
	 */
	public class ProgressManagerTest
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
		 * Test that the progress managers weight is default 
		 */		
		public function testProgressManagerWeight():void
		{
			var appProgress : IProgress = ProgressManager.getInstance();
			
			assertEquals( 1, appProgress.getWeight() );
		}
		
		[Test]
		/**
		 * Test adding an instance to the progress manager
		 */		
		public function testAddChildToProgressManager():void
		{
			var appProgress : IProgress = ProgressManager.getInstance();
			var childProgress : IProgress = new Progress( 1, "SOME_ID" );
			
			appProgress.addChildLoadable( childProgress );
			assertEquals( childProgress, appProgress.retrieveChildLoadable( "SOME_ID" ) );
		}
	}
}