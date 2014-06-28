/**
 * Created with IntelliJ IDEA.
 * User: dkoehler
 * Date: 13.06.13
 * Time: 15:50
 * To change this template use File | Settings | File Templates.
 */
package de.dirkkoehler.horst
{
	import de.dirkkoehler.ticTacToe.views.elements.VProgressBar;

	import flash.desktop.NativeApplication;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;

	import starling.core.Starling;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	import starling.utils.formatString;

	public class MainMobile extends Sprite
	{
		protected var mStarling:Starling;
		protected var scaleFactor:int;
		protected var assets:AssetManager;
		protected var background:Bitmap;

		public function MainMobile( stageWidth:int, stageHeight:int, Background:Class, BackgroundHD:Class )
		{
			addEventListener( flash.events.Event.ADDED_TO_STAGE, onAddedToStage );
			var iOS:Boolean = Capabilities.manufacturer.indexOf( "iOS" ) != -1;

			Starling.multitouchEnabled = true;  // useful on mobile devices
			Starling.handleLostContext = !iOS;  // not necessary on iOS. Saves a lot of memory!

			// create a suitable viewport for the screen size
			//
			// we develop the game in a *fixed* coordinate system of 320x480; the game might
			// then run on a device with a different resolution; for that case, we zoom the
			// viewPort to the optimal size for any display and load the optimal textures.

			var viewPort:Rectangle = RectangleUtil.fit(
					new Rectangle( 0, 0, stageWidth, stageHeight ),
					new Rectangle( 0, 0, stage.fullScreenWidth, stage.fullScreenHeight ),
					ScaleMode.SHOW_ALL, iOS );

			// create the AssetManager, which handles all required assets for this resolution
			var scaleLimit:uint = stageWidth + (stageWidth / 2);
			scaleFactor = viewPort.width < scaleLimit ? 1 : 2; // midway between 320 and 640
			assets = new AssetManager( scaleFactor );
			assets.verbose = Capabilities.isDebugger;

			// While Stage3D is initializing, the screen will be blank. To avoid any flickering,
			// we display a startup image now and remove it below, when Starling is ready to go.
			// This is especially useful on iOS, where "Default.png" (or a variant) is displayed
			// during Startup. You can create an absolute seamless startup that way.
			//
			// These are the only embedded graphics in this app. We can't load them from disk,
			// because that can only be done asynchronously - i.e. flickering would return.
			//
			// Note that we cannot embed "Default.png" (or its siblings), because any embedded
			// files will vanish from the application package, and those are picked up by the OS!

			background = scaleFactor == 1 ? new Background() : new BackgroundHD();
			Background = null;
			BackgroundHD = null; // no longer needed!

			background.x = viewPort.x;
			background.y = viewPort.y;
			background.width = viewPort.width;
			background.height = viewPort.height;
			background.smoothing = true;
			addChild( background );

			//init function for framework user
			init();

			// launch Starling
			mStarling = new Starling( AppContext, stage, viewPort );
			mStarling.stage.stageWidth = stageWidth;  // <- same size on all devices!
			mStarling.stage.stageHeight = stageHeight; // <- same size on all devices!
			mStarling.simulateMultitouch = false;
			mStarling.enableErrorChecking = false;
			mStarling.addEventListener( starling.events.Event.ROOT_CREATED, starlingRootCreated );

			// When the game becomes inactive, we pause Starling; otherwise, the enter frame event
			// would report a very long 'passedTime' when the app is reactivated.
			NativeApplication.nativeApplication.addEventListener( flash.events.Event.ACTIVATE, appActiveHandler );
			NativeApplication.nativeApplication.addEventListener( flash.events.Event.DEACTIVATE, appInactiveHandler );
		}

		private function onAddedToStage( event:flash.events.Event ):void
		{
			removeEventListener( flash.events.Event.ADDED_TO_STAGE, onAddedToStage );
		}

		private function appInactiveHandler( event:flash.events.Event ):void
		{
			mStarling.stop();
		}

		private function appActiveHandler( event:flash.events.Event ):void
		{
			mStarling.start();
		}

		private function starlingRootCreated( event:starling.events.Event ):void
		{
			removeChild( background );

			var game:AppContext = mStarling.root as AppContext;
			var bgTexture:Texture = Texture.fromBitmap( background, false, false, scaleFactor );
			game.start( bgTexture, assets, new VProgressBar() );
			mStarling.start();
		}

		final protected function addAssetPath( _assetPath:String ):void
		{
			var appDir:File = File.applicationDirectory;
			var assetFile:File = appDir.resolvePath( formatString( _assetPath + "/{0}x", scaleFactor ) );
			assets.enqueue( assetFile );
		}

		protected function init():void
		{

		}
	}
}
