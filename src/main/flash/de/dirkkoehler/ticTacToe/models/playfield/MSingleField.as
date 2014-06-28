/**
 * Created with IntelliJ IDEA.
 * User: dkoehler
 * Date: 26.05.13
 * Time: 14:58
 * To change this template use File | Settings | File Templates.
 */
package de.dirkkoehler.ticTacToe.models.playfield
{
	import de.dirkkoehler.ticTacToe.data.Constants;

	public class MSingleField
	{
		public var xPos:uint;
		public var yPos:uint;
		public var owner:int = Constants.FREE_INDEX;
		public function MSingleField()
		{
		}
	}
}
