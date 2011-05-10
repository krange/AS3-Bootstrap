/**
 * ------------------------------------------------------------
 * Copyright (c) 2010 Dareville.
 * This software is the proprietary information of Dareville.
 * All Right Reserved.
 * ------------------------------------------------------------
 *
 * SVN revision information:
 * @version $Revision: $:
 * @author  $Author: $:
 * @date    $Date: $:
 */
package org.puremvc.as3.multicore.utilities.as3bootstrap.demos.as3
{
	import org.puremvc.as3.multicore.utilities.as3bootstrap.demos.as3.controller.FlStartupCommand;
	
	import org.puremvc.as3.multicore.utilities.fabrication.components.FlashApplication;
	
	/**
	 * Main
	 * 
	 * @author krisrange
	 */
	public class Main 
		extends FlashApplication //Sprite
	{
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		override public function getStartupCommand():Class
		{
			return FlStartupCommand;
		}
		
		
		
		/*public function Main()
		{
			var bootstrap:IBootstrap = new Bootstrap(new Progress());
			bootstrap.appLoaded.add( onAppLoaded );
			bootstrap.dataLoaded.add( onDataLoaded );
			bootstrap.bootstrapLoaded.add( onBootstrapLoaded );
			bootstrap.start( loaderInfo.parameters );
			
			var modProg : IProgress = new Progress();
			bootstrap.viewProgress.addChildLoadable( modProg );
			
			var moduleBootstrap : IBootstrap = new Bootstrap( modProg );
			moduleBootstrap.bootstrapLoaded.add( onModuleBootstrapLoaded );
			
			function onBootstrapLoaded():void
			{
				trace( "bootstrap loaded" );
				moduleBootstrap.start( loaderInfo );
			}
			
			function onDataLoaded():void
			{
				trace( "data loaded" );
			}
			
			function onModuleBootstrapLoaded():void
			{
				trace( "module loaded" );
				bootstrap.viewProgress.setAmountLoaded( 1 );
			}
			
			function onAppLoaded():void
			{
				trace( "entire app loaded" );
			}
		}*/
		
		//----------------------------------
		//  Override
		//----------------------------------
		
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