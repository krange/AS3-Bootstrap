Bootstrap
=======

# Introduction

Bootstrap is a Flex and AS3 utility which accelerates development when loading common startup load processes within an application. It is available currently as either integrated into multi-core PureMVC application or as a standalone utility. Robotlegs is intended to be fully supported but is not quite completed as of this writing. 

The PureMVC version is built upton the Fabrication utility which adds many useful features to typical PureMVC programming syntax as well as simpler integration when building modular applications.

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

# Standalone Mode

Getting the basic setup in standalone is as simple as a few lines of code.

```as3
var bootstrap:IBootstrap = new Bootstrap(new Progress());
bootstrap.bootstrapLoaded.add( onBootstrapLoaded );
bootstrap.start( loaderInfo.parameters );
			
function onBootstrapLoaded():void
{
	// All bootstrap loading has completed
}
```