package org.puremvc.as3.multicore.utilities.as3bootstrap.common.model
{
	import as3bootstrap.common.progress.IProgress;
	
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.proxy.FabricationProxy;
	
	/**
	 * Base for <code>IProxy</code> classes that need to track 
	 * <code>IProgress</code> amounts
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange
	 */
	public class BaseProgressProxy 
		extends FabricationProxy
	{
		private var _progress : IProgress;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 * 
		 * @param name IProxy name
		 * @param data Data reference
		 * @param progress IProgress instance to track
		 */
		public function BaseProgressProxy( name:String=null, data:Object=null, progress:IProgress=null )
		{
			super( name, data );
			_progress = progress;
		}
		
		/**
		 * Set the <code>IProgress</code> instance
		 * 
		 * @param value IProgress 
		 */		
		public function setProgress( value:IProgress ):void
		{
			_progress = value;
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Set the <code>IProgress</code> instance
		 * 
		 * @return IProgress
		 */		
		public function get progress():IProgress
		{
			return _progress;
		}
	}
}