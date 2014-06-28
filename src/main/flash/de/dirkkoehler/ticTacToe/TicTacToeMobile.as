package de.dirkkoehler.ticTacToe
{
	import de.dirkkoehler.horst.MainMobile;

	[SWF(width="320", height="480", frameRate="40", backgroundColor="#000000")]
	public class TicTacToeMobile extends MainMobile
	{
		// Startup image for SD screens
		[Embed(source="../../../../system/startup.jpg")]
		private var Background:Class;

		// Startup image for HD screens
		[Embed(source="../../../../system/startupHD.jpg")]
		private var BackgroundHD:Class;

		public function TicTacToeMobile()
		{
			super( 320, 480, Background, BackgroundHD );
		}

		override protected function init():void
		{
		   addAssetPath("textures");
		}
	}
}