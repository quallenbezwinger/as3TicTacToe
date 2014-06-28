/**
 * Created with IntelliJ IDEA.
 * User: dkoehler
 * Date: 26.05.13
 * Time: 14:50
 * To change this template use File | Settings | File Templates.
 */
package de.dirkkoehler.ticTacToe.views.playfield
{
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;

	public class VSingleField extends Sprite
	{
		public var xPos:uint = 0;
		public var yPos:uint = 0;
		private var _img:Image;
		private var _mclip:MovieClip;

		public function VSingleField()
		{

		}

		public function set img( value:Image ):void
		{
			_img = value;
			addChild(_img);
		}

		public function set mclip( value:MovieClip ):void
		{
			_mclip = value;
			_mclip.scaleX = 0.5;
			_mclip.scaleY = 0.5;
			_mclip.x = this.width/2 - int(_mclip.width / 2);
			_mclip.y = this.height/2 - int(_mclip.height / 2);
			addChild(_mclip);
			Starling.juggler.add( _mclip );
		}

		override public function dispose():void
		{
			if (_mclip)
			{
				Starling.juggler.remove( _mclip );
				_mclip.dispose();
				_mclip = null;
			}
			if (_img)
			{
				_img.dispose();
				_img = null;
			}
			super.dispose();
		}
	}
}
