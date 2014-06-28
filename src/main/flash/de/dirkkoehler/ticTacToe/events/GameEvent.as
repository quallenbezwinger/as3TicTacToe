/**
 * Created with IntelliJ IDEA.
 * User: dkoehler
 * Date: 12.06.13
 * Time: 12:33
 * To change this template use File | Settings | File Templates.
 */
package de.dirkkoehler.ticTacToe.events
{
	import flash.events.Event;

	public class GameEvent extends Event
	{
		public static const END_TURN:String = "END_TURN";
		public static const END_GAME:String = "END_GAME";
		public function GameEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false )
		{
			super( type, bubbles, cancelable );
		}
	}
}
