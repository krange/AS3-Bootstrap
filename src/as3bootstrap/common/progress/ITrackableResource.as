package as3bootstrap.common.progress
{
	/**
	 * Interface for resources that can be tracked via the 
	 * <code>IProgress</code> interface
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange 
	 */
	public interface ITrackableResource
	{
		/**
		 * Set the <code>IProgress</code> instance
		 * 
		 * @param value <code>IProgress</code> instance to set
		 */		
		function set progress( value : IProgress ):void;
		
		/**
		 * @return IProgress 
		 */		
		function get progress():IProgress;
	}
}