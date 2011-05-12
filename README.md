Bootstrap
=======

# Introduction

Bootstrap is a Flex and AS3 utility which accelerates development when loading common startup load processes within an application. It is available currently as either integrated into multi-core PureMVC application or as a standalone utility. Robotlegs is intended to be fully supported but is not quite completed as of this writing. 

Bootstrap uses AS3 Signals for dispatching of all events. The PureMVC version is also built upon the PureMVC Fabrication utility which adds many useful features to typical PureMVC programming syntax as well as simpler integration when building modular applications.

## What does Bootstrap provide?

The main function of Bootstrap is to simplify the process to load common external resources through an XML file. It also provides the user with a few helpful additional utility classes like integrating preloaders in Flex as well as progress classes integrated with the load.

The following resources can be loading via XML:

* external CSS (AS 3.0) and CSS SWF (Flex) files
* external font files (including bitmap font SWFs via the Flash IDE)
* external localization XML files

# Configuration Setup

## Flash Vars

The following Flashvars variables are available for use with Bootstrap:

   - **baseUrl** – The base URL to load all Bootstrap resources from. This allows you to load correctly when moving throughout the lifecycle of your project from development,staging and production environments. If you provide no baseUrl, Bootstrap will load based on whatever URL you provide in the XML.
   - **configXmlBaseUrl** – The base URL to your configuration XML file. Sometimes this might be on a different location entirely than the rest of your assets. If you provide no configXmlBaseUrl then Bootstrap will load based on the URL you provide as the configXmlUrl.
   - **configXmlUrl** – The URL to where your configuration XML file lives.

## XML Setup

The Bootstrap utility loads up a configuration external XML file. This file defines all the values that this utility will require to load. The XML can have as many as little of each item as you need. This XML can include other data as well, but the only values that this utility looks for inside the root node are below.

Please note that if you pass in a *baseUrl* flashVar parameter, Bootstrap will apply it as the base of the URLs for the below resources.

   - **stylesheet** – Reference to your externalized CSS file or SWF-Compiled CSS (Flex) file.

```
<stylesheet url="css/styles.css" />
<stylesheet url="swf/css/styles.swf" />
```

   - **font** – Reference to your externalized SWF compiled font file. The *name* property here completely **optional** and is the fully-qualified path of the font class (ex. as3bootstrap.fonts._Arial ).

You can also reference a externalized Flash IDE SWF with bitmap fonts embedded using the same method as currently it's impossible to compile bitmap fonts from outside the Flash IDE. 

```
<font url="_AFFuturaBook_en.swf" />
<font url="SomeFont.swf" name="as3bootstrap.fonts.SomeFontName" />
<font url="_ArialBitmap.swf" />
```

   - **localization** – In most cases, projects are updated via the clients. Because of this, localization must be updatable via external resources. Bootstrap can load in external XML files to which the content through a value object in name/value pairs.

```
<localization url="xml/bootstrap/locale.xml" />
```

# Getting Started

Getting the basic setup in standalone is as simple as a few lines of code. PureMVC requires writing two classes. See simple examples below. More robust example projects are coming!

## Standalone Mode

```as3
var bootstrap:IBootstrap = new Bootstrap(new Progress());
bootstrap.bootstrapLoaded.add( onBootstrapLoaded );
bootstrap.start( loaderInfo.parameters );
			
function onBootstrapLoaded():void
{
	// All bootstrap loading has completed
}
```

## PureMVC AS3 Mode

### Main Application

```as3
package org.puremvc.as3.multicore.utilities.as3bootstrap.demos.as3
{
	import org.puremvc.as3.multicore.utilities.as3bootstrap.demos.as3.controller.FlStartupCommand;
	import org.puremvc.as3.multicore.utilities.fabrication.components.FlashApplication;
	
	public class Main 
		extends FlashApplication
	{
		override public function getStartupCommand():Class
		{
			return FlStartupCommand;
		}
	}
}
```

### Startup Command

```as3
package org.puremvc.as3.multicore.utilities.as3bootstrap.demos.as3.controller
{
	import org.puremvc.as3.multicore.utilities.as3bootstrap.demos.as3.view.ApplicationMediator;
	import org.puremvc.as3.multicore.utilities.as3bootstrap.flash.controller.BootstrapFlashStartupCommand;
	
	public class FlStartupCommand 
		extends BootstrapFlashStartupCommand
	{
		override protected function getApplicationMediator():Class
		{
			return ApplicationMediator;
		}
	}
}
```

### Application Mediator

```as3
package org.puremvc.as3.multicore.utilities.as3bootstrap.demos.as3.view
{
	import as3bootstrap.common.progress.IProgress;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.as3bootstrap.flash.view.mediators.BootstrapFlashMediator;
	
	public class ApplicationMediator 
		extends BootstrapFlashMediator
	{
		public static const NAME : String = "ApplicationMediator";
		
		public function ApplicationMediator( name:String, viewComponent:Object, progress:IProgress=null )
		{
			super( name, viewComponent, progress );
		}
		
		override public function respondToBootstrapLoadComplete(notification:INotification):void
		{
			// All bootstrap loading has completed
		}
	}
}
```

## PureMVC Flex4 Mode

### Main Application

```as3
<?xml version="1.0" encoding="utf-8"?>
<components:FlexHaloApplication
	xmlns:components="org.puremvc.as3.multicore.utilities.fabrication.components.*"
	xmlns:fx="http://ns.adobe.com/mxml/2009" 
	xmlns:s="library://ns.adobe.com/flex/spark" 
	xmlns:mx="library://ns.adobe.com/flex/mx"
	minWidth="955" minHeight="600">
	
	<fx:Declarations>
		<!-- Place non-visual elements (e.g., services, value objects) here -->
	</fx:Declarations>
	
	<fx:Script>
		<![CDATA[
			import as3bootstrap.demo.flex4.controller.FxStartupCommand;
			
			override public function getStartupCommand():Class
			{
				return FxStartupCommand;
			}
		]]>
	</fx:Script>
	
</components:FlexHaloApplication>
```

### Startup Command

```as3
package as3bootstrap.demo.flex4.controller
{
	import org.puremvc.as3.multicore.utilities.as3bootstrap.flex.spark.controller.BootstrapFlexSparkStartupCommand;
	
	import as3bootstrap.demo.flex4.view.ApplicationMediator;
	
	public class FxStartupCommand 
		extends BootstrapFlexSparkStartupCommand
	{
		override protected function getApplicationMediator():Class
		{
			return ApplicationMediator;
		}
	}
}
```

### Application Mediator

```as3
package as3bootstrap.demo.flex4.view
{
	import as3bootstrap.common.progress.IProgress;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.as3bootstrap.flex.common.view.mediators.BootstrapFlexMediator;
	
	public class ApplicationMediator 
		extends BootstrapFlexMediator
	{
		public static const NAME : String = "ApplicationMediator";
		
		public function ApplicationMediator( name:String, viewComponent:Object, progress:IProgress=null )
		{
			super( name, viewComponent, progress );
		}
		
		override public function respondToBootstrapLoadComplete( notification:INotification ):void
		{
			// All bootstrap loading has completed
		}
	}
}
```

