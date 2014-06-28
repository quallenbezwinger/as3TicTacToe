package de.dirkkoehler.demo
{
	import de.dirkkoehler.demo.scenes.AnimationScene;
	import de.dirkkoehler.demo.scenes.BenchmarkScene;
	import de.dirkkoehler.demo.scenes.BlendModeScene;
	import de.dirkkoehler.demo.scenes.CustomHitTestScene;
	import de.dirkkoehler.demo.scenes.FilterScene;
	import de.dirkkoehler.demo.scenes.MovieScene;
	import de.dirkkoehler.demo.scenes.RenderTextureScene;
	import de.dirkkoehler.demo.scenes.TextScene;
	import de.dirkkoehler.demo.scenes.TextureScene;
	import de.dirkkoehler.demo.scenes.TouchScene;

	import flash.utils.getQualifiedClassName;

	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.VAlign;

	public class MainMenu extends Sprite
	{
		public function MainMenu()
		{
			init();
		}

		private function init():void
		{
			var logo:Image = new Image( Game.assets.getTexture( "logo" ) );
			addChild( logo );

			var scenesToCreate:Array = [
				["Textures", TextureScene],
				["Multitouch", TouchScene],
				["TextFields", TextScene],
				["Animations", AnimationScene],
				["Custom hit-test", CustomHitTestScene],
				["Movie Clip", MovieScene],
				["Filters", FilterScene],
				["Blend Modes", BlendModeScene],
				["Render Texture", RenderTextureScene],
				["Benchmark", BenchmarkScene]
			];

			var buttonTexture:Texture = Game.assets.getTexture( "button_big" );
			var count:int = 0;

			for each (var sceneToCreate:Array in scenesToCreate)
			{
				var sceneTitle:String = sceneToCreate[0];
				var sceneClass:Class = sceneToCreate[1];

				var button:Button = new Button( buttonTexture, sceneTitle );
				button.x = count % 2 == 0 ? 28 : 167;
				button.y = 160 + int( count / 2 ) * 52;
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