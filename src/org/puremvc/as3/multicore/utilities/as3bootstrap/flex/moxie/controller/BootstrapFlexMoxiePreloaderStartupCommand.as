package org.puremvc.as3.multicore.utilities.as3bootstrap.flex.moxie.controller
{
	import as3bootstrap.common.IBootstrap;
	import as3bootstrap.common.constants.BootstrapConstants;
	import as3bootstrap.common.progress.IProgress;
	import as3bootstrap.common.progress.ProgressManager;
	import as3bootstrap.flex.moxie.BootstrapFlexMoxie;

	/**
	 * Flex3 startup command for PureMVC multicore bootstrapped applications 
	 * that integrate into a bootstrap enabled custom preloader.
	 * 
	 * @see as3bootstrap.flex.common.view.components.preloader.BootstrapFlexCustomPreloader
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange
	 */
	public class BootstrapFlexMoxiePreloaderStartupCommand 
		extends BootstrapFlexMoxieStartupCommand
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
			return new BootstrapFlexMoxie( appProgress, dataProgress, viewProgress );
		}
	}
}