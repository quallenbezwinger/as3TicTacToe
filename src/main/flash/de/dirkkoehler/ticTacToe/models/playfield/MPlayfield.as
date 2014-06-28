/**
 * Created with IntelliJ IDEA.
 * User: dkoehler
 * Date: 26.05.13
 * Time: 12:55
 * To change this template use File | Settings | File Templates.
 */
package de.dirkkoehler.ticTacToe.models.playfield
{
	import de.dirkkoehler.ticTacToe.data.Constants;
	import de.dirkkoehler.ticTacToe.events.GameEvent;

	import flash.events.EventDispatcher;

	public class MPlayfield extends EventDispatcher
	{
		public var rows:Vector.<Vector.<MSingleField>>;
		private var playerControlledFields:Vector.<MSingleField>;
		private var _currentPlayer:uint = Constants.PLAYER_1_INDEX;

		public function MPlayfield()
		{
			rows = new Vector.<Vector.<MSingleField>>( Constants.FIELDSIZE, true );
			for (var yPos:int = 0; yPos < rows.length; yPos++)
			{
				rows[yPos] = new Vector.<MSingleField>( Constants.FIELDSIZE, true );
				for (var xPos:int = 0; xPos < rows[yPos].length; xPos++)
				{
					var field:MSingleField = rows[yPos][xPos] = new MSingleField();
					field.xPos = xPos;
					field.yPos = yPos;
				}
			}
			addEventListener( GameEvent.END_TURN, handleEndTurn );
		}

		public function playerPressed( xPos:uint, yPos:uint ):void
		{
			if (_currentPlayer == Constants.PLAYER_1_INDEX)
			{
				rows[yPos][xPos].owner = Constants.PLAYER_1_INDEX;
			}
			else
			{
				rows[yPos][xPos].owner = Constants.PLAYER_2_INDEX;
			}
			var turnEndEvent:GameEvent = new GameEvent( GameEvent.END_TURN );
			dispatchEvent( turnEndEvent );
		}

		private function handleEndTurn( event:GameEvent ):void
		{
			if (hasPlayerCompleteRow() == true)
			{
				trace ("winner is player "+_currentPlayer);
				var gameEndEvent:GameEvent = new GameEvent( GameEvent.END_GAME );
				dispatchEvent( gameEndEvent );
			}
			else
			{
				if (_currentPlayer == Constants.PLAYER_1_INDEX)
				{
					_currentPlayer = Constants.PLAYER_2_INDEX;
				}
				else
				{
					_currentPlayer = Constants.PLAYER_1_INDEX;
				}
			}

		}

		private function hasPlayerCompleteRow():Boolean
		{
			//find all fields controlled by player
			playerControlledFields = new Vector.<MSingleField>();
			for (var yPos:int = 0; yPos < rows.length; yPos++)
			{
				for (var xPos:int = 0; xPos < rows[yPos].length; xPos++)
				{
					var field:MSingleField = rows[yPos][xPos];
					if (field.owner == _currentPlayer)
					{
						playerControlledFields.push( field );
					}
				}
			}

			//check if player has completed horizontal line
			if (hasPlayerCompleteHorLine() || hasPlayerCompleteVertLine() || hasPlayerCompleteCrossedLine())
			{
				return true;
			}

			return false;
		}

		private function hasPlayerCompleteCrossedLine():Boolean
		{
			return false;
		}

		private function hasPlayerCompleteVertLine():Boolean
		{
			for (var i:int = 0; i < playerControlledFields.length; i++)
			{
				var playerControlledField:MSingleField = playerControlledFields[i];
				var fieldCounter:uint = 0;
				for (var j:int = 0; j < Constants.FIELDSIZE; j++)
				{
					var currentFieldInRow:MSingleField = rows[j][playerControlledField.xPos];
					if (currentFieldInRow.owner == _currentPlayer)
					{
						fieldCounter++;
					}
					if (fieldCounter == Constants.FIELDSIZE)
					{
						return true;
					}
				}
			}
			return false;
		}

		private function hasPlayerCompleteHorLine():Boolean
		{
			for (var i:int = 0; i < playerControlledFields.length; i++)
			{
				var playerControlledField:MSingleField = playerControlledFields[i];
				var fieldCounter:uint = 0;
				for (var j:int = 0; j < Constants.FIELDSIZE; j++)
				{
					var currentFieldInRow:MSingleField = rows[playerControlledField.yPos][j];
					if (currentFieldInRow.owner == _currentPlayer)
					{
						fieldCounter++;
					}
					if (fieldCounter == Constants.FIELDSIZE)
					{
						return true;
					}
				}
			}
			return false;
		}

		public function get currentPlayer():uint
		{
			return _currentPlayer;
		}

		public function dispose():void
		{

		}
	}
}
