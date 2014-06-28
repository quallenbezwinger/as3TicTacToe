/**
 * Created with IntelliJ IDEA.
 * User: dkoehler
 * Date: 13.06.13
 * Time: 13:11
 * To change this template use File | Settings | File Templates.
 */
package de.dirkkoehler.ticTacToe.views.scenes
{
	import de.dirkkoehler.horst.views.SimpleScene;
	import de.dirkkoehler.ticTacToe.data.Constants;
	import de.dirkkoehler.ticTacToe.models.playfield.MPlayfield;
	import de.dirkkoehler.ticTacToe.views.playfield.VPlayfield;

	public class SPlayfield extends SimpleScene
	{

		private var vPlayfield:VPlayfield;

		public function SPlayfield()
		{
			backButton.x = Constants.CenterX - backButton.width / 2;
			backButton.y = Constants.GameHeight - backButton.height + 1;
			vPlayfield = new VPlayfield( new MPlayfield() );
			addChild( vPlayfield );
		}

		override public function dispose():void
		{
			removeChild( vPlayfield, true );
			vPlayfield = null;
			super.dispose();
		}
	}
}
