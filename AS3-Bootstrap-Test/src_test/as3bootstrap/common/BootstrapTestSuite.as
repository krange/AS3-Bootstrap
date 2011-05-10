package as3bootstrap.common
{
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
	}
}