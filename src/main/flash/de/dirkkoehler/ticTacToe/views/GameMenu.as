package de.dirkkoehler.ticTacToe.views
{
	import de.dirkkoehler.horst.AppContext;
	import de.dirkkoehler.ticTacToe.data.Constants;
	import de.dirkkoehler.ticTacToe.views.scenes.SPlayfield;

	import flash.utils.getQualifiedClassName;

	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.VAlign;

	public class GameMenu extends Sprite
	{
		public function GameMenu()
		{
			init();
		}

		private function init():void
		{

			var scenesToCreate:Array = [
				["New Game", SPlayfield]
			];

			var buttonTexture:Texture = AppContext.assets.getTexture( "button_big" );
			var count:int = 0;

			for each (var sceneToCreate:Array in scenesToCreate)
			{
				var sceneTitle:String = sceneToCreate[0];
				var sceneClass:Class = sceneToCreate[1];

				var button:Button = new Button( buttonTexture, sceneTitle );
				button.x = Constants.CenterX;
				button.y = Constants.CenterY;
				button.pivotX = button.width/2;
				button.pivotY = button.height/2;
				button.name = getQualifiedClassName( sceneClass );
				addChild( button );
				++count;
			}

			// show information about rendering method (hardware/software)

			var driverInfo:String = Starling.context.driverInfo;
			var infoText:TextField = new TextField( 310, 64, driverInfo, "Verdana", 10 );
			infoText.x = 5;
			infoText.y = 475 - infoText.height;
			infoText.vAlign = VAlign.BOTTOM;
			infoText.addEventListener( TouchEvent.TOUCH, onInfoTextTouched );
			addChildAt( infoText, 0 );
		}

		private function onInfoTextTouched( event:TouchEvent ):void
		{
			if (event.getTouch( this, TouchPhase.ENDED ))
			{
				Starling.current.showStats = !Starling.current.showStats;
			}
		}
	}
}