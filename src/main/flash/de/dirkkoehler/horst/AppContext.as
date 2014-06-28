package de.dirkkoehler.horst
{
	import de.dirkkoehler.horst.views.SimpleScene;
	import de.dirkkoehler.horst.views.elements.VProgress;
	import de.dirkkoehler.ticTacToe.views.GameMenu;

	import flash.utils.getDefinitionByName;

	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.AssetManager;

	public class AppContext extends Sprite
	{
		private static var _assets:AssetManager;
		private var vProgress:VProgress;
		private var gameMenu:GameMenu;
		private var currentScene:SimpleScene;

		public function AppContext()
		{

		}

		internal function start( background:Texture, assets:AssetManager, _vProgressBar:VProgress ):void
		{

			addChild( new Image( background ) );
			_assets = assets;

			vProgress = _vProgressBar;
			vProgress.x = (background.width - vProgress.width) / 2;
			vProgress.y = (background.height - vProgress.height) / 2;
			vProgress.y = background.height * 0.7;
			addChild( vProgress );
			_assets.loadQueue( updateLoadingPrgress );

		}

		private function updateLoadingPrgress( ratio:Number ):void
		{
			vProgress.ratio = ratio;

			// a progress bar should always show the 100% for a while,
			// so we show the main menu only after a short delay.

			if (ratio == 1)
			{
				Starling.juggler.delayCall( initMenu, 0.15 );
			}
		}

		private function initMenu():void
		{
			vProgress.removeFromParent( true );
			vProgress = null;
			addEventListener( Event.TRIGGERED, onButtonTriggered );
			showMainMenu();
		}

		private function onButtonTriggered( event:Event ):void
		{
			var button:Button = event.target as Button;

			if (button.name == "backButton")
			{
				closeScene();
			}
			else
			{
				showScene( button.name );
			}
		}

		private function closeScene():void
		{
			currentScene.dispose();
			currentScene.removeFromParent( true );
			currentScene = null;
			showMainMenu();
		}

		private function showScene( name:String ):void
		{
			if (currentScene)
			{
				return;
			}

			var sceneClass:Class = getDefinitionByName( name ) as Class;
			currentScene = new sceneClass() as SimpleScene;
			gameMenu.removeFromParent();
			addChild( currentScene );
		}

		private function showMainMenu():void
		{
			if (gameMenu == null)
			{
				gameMenu = new GameMenu();
			}
			addChild( gameMenu );
		}

		public static function get assets():AssetManager
		{
			return _assets;
		}
	}
}