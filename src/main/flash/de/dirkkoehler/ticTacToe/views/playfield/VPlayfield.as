/**
 * Created with IntelliJ IDEA.
 * User: dkoehler
 * Date: 26.05.13
 * Time: 13:00
 * To change this template use File | Settings | File Templates.
 */
package de.dirkkoehler.ticTacToe.views.playfield
{
	import de.dirkkoehler.ticTacToe.data.Constants;
	import de.dirkkoehler.ticTacToe.events.GameEvent;
	import de.dirkkoehler.horst.AppContext;
	import de.dirkkoehler.ticTacToe.models.playfield.MPlayfield;

	import flash.display.BitmapData;
	import flash.display.Sprite;

	import starling.core.Starling;

	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;

	public class VPlayfield extends starling.display.Sprite
	{
		public var rows:Vector.<Vector.<VSingleField>>;
		private var fieldHeight:int;
		private var fieldWidth:int;
		private var model:MPlayfield;

		public function VPlayfield( model:MPlayfield )
		{
			this.model = model;
			this.addEventListener( Event.ADDED_TO_STAGE, handleAddeddToStage );
			model.addEventListener( GameEvent.END_GAME, handleEndGame );
		}



		private function handleEndGame( event:GameEvent ):void
		{
			//this.mouseChildren = false;
			//this.mouseEnabled = false;
		}

		private function handleAddeddToStage( event:Event ):void
		{

			this.removeEventListener( Event.ADDED_TO_STAGE, handleAddeddToStage );

			fieldWidth = this.stage.stageWidth / Constants.FIELDSIZE;
			fieldHeight = this.stage.stageHeight / Constants.FIELDSIZE-20;
			var gfx:flash.display.Sprite = new flash.display.Sprite();
			gfx.graphics.beginFill( 0x000000 );
			gfx.graphics.drawRect( 0, 0, fieldWidth, fieldHeight );
			gfx.graphics.endFill();
			gfx.graphics.beginFill( 0xFFFFFF );
			gfx.graphics.drawRect( 1, 1, fieldWidth - 1, fieldHeight - 1 );
			gfx.graphics.endFill();

			var bData:BitmapData = new BitmapData( gfx.width, gfx.height, true, 1 );
			bData.draw( gfx );
			var text:Texture = Texture.fromBitmapData( bData );

			rows = new Vector.<Vector.<VSingleField>>( Constants.FIELDSIZE, true );
			for (var yPos:int = 0; yPos < rows.length; yPos++)
			{
				rows[yPos] = new Vector.<VSingleField>( Constants.FIELDSIZE, true );
				for (var xPos:int = 0; xPos < rows[yPos].length; xPos++)
				{
					var field:VSingleField = rows[yPos][xPos] = new VSingleField();
					field.xPos = xPos;
					field.yPos = yPos;
					field.x = xPos * fieldWidth;
					field.y = yPos * fieldHeight;
					field.img = new Image(text);
					addChild( field );
				}
			}
			this.addEventListener( TouchEvent.TOUCH, handleTouch );
		}

		private function handleTouch( event:TouchEvent ):void
		{
			if (event.getTouch( this, TouchPhase.ENDED ))
			{

				var gfx:flash.display.Sprite = new flash.display.Sprite();

				if (model.currentPlayer == 1)
				{
					gfx.graphics.beginFill( 0xFF0000 );
				}
				else
				{
					gfx.graphics.beginFill( 0xFFFF00 );
				}

				gfx.graphics.drawRect( 1, 1, fieldWidth - 1, fieldHeight - 1 );
				gfx.graphics.endFill();

				var bData:BitmapData = new BitmapData( gfx.width, gfx.height, true, 1 );
				bData.draw( gfx );
				var texture:Texture = Texture.fromBitmapData( bData );
				var image:Image = new Image( texture );
//				image.pivotX = image.width / 2;
//				image.pivotY = image.height / 2;

				var img:Image = event.target as Image;
				var field:VSingleField = img.parent as VSingleField;
				field.img = image;



				var frames:Vector.<Texture> = AppContext.assets.getTextures("flight");
				var mMovie:MovieClip = new MovieClip(frames, 15);
				field.mclip = mMovie;
				model.playerPressed( field.xPos, field.yPos );
			}
		}

		override public function dispose():void
		{
			for (var yPos:int = 0; yPos < rows.length; yPos++)
			{
				for (var xPos:int = 0; xPos < rows[yPos].length; xPos++)
				{
					rows[yPos][xPos].dispose();
				}
			}
			this.removeEventListener( TouchEvent.TOUCH, handleTouch );
			model.removeEventListener( GameEvent.END_GAME, handleEndGame );
			model.dispose();
			super.dispose();
		}
	}
}
