package org.puremvc.as3.multicore.utilities.as3bootstrap.flex.spark.controller
{
	import as3bootstrap.common.IBootstrap;
	import as3bootstrap.common.constants.BootstrapConstants;
	import as3bootstrap.common.progress.IProgress;
	import as3bootstrap.common.progress.ProgressManager;
	import as3bootstrap.flex.spark.BootstrapFlexSpark;

	/**
	 * BootstrapFlexSparkPreloaderStartupCommand
	 * 
	 * @author krisrange
	 */
	public class BootstrapFlexSparkPreloaderStartupCommand 
		extends BootstrapFlexSparkStartupCommand
	{		
		//---------------------------------------------------------------------
		//
		//  Protected methods
		//
		//---------------------------------------------------------------------
		
		//----------------------------------
		//  Override
		//----------------------------------
		
		/**
		 * @inheritDoc 
		 */		
		override protected function getAppProgress():IProgress
		{
			return ProgressManager.getInstance();
		}
		
		/**
		 * @inheritDoc 
		 */		
		override protected function instantiateBootstrap():IBootstrap
		{
			appProgress = getAppProgress();
			var dataProgress : IProgress = appProgress.retrieveChildLoadable( BootstrapConstants.PRELOAD_DATA );
			var viewProgress : IProgress = appProgress.retrieveChildLoadable( BootstrapConstants.PRELOAD_VIEW );
			return new BootstrapFlexSpark( appProgress, dataProgress, viewProgress );
		}
		
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