package as3bootstrap.common
{
	import as3bootstrap.common.progress.ProgressManagerTest;
	import as3bootstrap.common.progress.ProgressTest;
	import as3bootstrap.common.services.FontServiceTest;
	import as3bootstrap.common.services.StylesheetServiceTest;
	import as3bootstrap.common.services.XmlServiceTest;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	/**
	 * Bootstrap test suite
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange 
	 */
	public class BootstrapTestSuite
	{
		public var test1:BootstrapProgressTest;
		public var test2:BootstrapLoadTest;
		
		public var test3:XmlServiceTest;
		public var test4:StylesheetServiceTest;
		public var test5:FontServiceTest;
		
		public var test6:ProgressTest;
		public var test7:ProgressManagerTest;
	}
}