package org.robotlegs.utilities.as3bootstrap.common.controller
{
	import org.robotlegs.mvcs.Command;
	import org.robotlegs.utilities.as3bootstrap.common.model.IBootstrapModel;
	import org.robotlegs.utilities.as3bootstrap.common.model.IConfigModel;
	
	/**
	 * BootstrapRobotlegsStartupCommand
	 * 
	 * @author krisrange
	 */
	public class BootstrapStartupCommand 
		extends Command
	{
		[Inject]
		public var bootstrapModel : IBootstrapModel;
		
		[Inject]
		public var configModel : IConfigModel;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		//----------------------------------
		//  Override
		//----------------------------------
		
		override public function execute():void
		{
		}
		
		//---------------------------------------------------------------------
		//
		//  Protected methods
		//
		//---------------------------------------------------------------------
		
		//----------------------------------
		//  Override
		//----------------------------------
		
		//---------------------------------------------------------------------
		//
		//  Private methods
		//
		//---------------------------------------------------------------------
		
		//----------------------------------
		//  Handlers
		//----------------------------------
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
	}
}