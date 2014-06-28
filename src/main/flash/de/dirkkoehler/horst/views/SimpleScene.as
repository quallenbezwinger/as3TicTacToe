/**
 * Created with IntelliJ IDEA.
 * User: dkoehler
 * Date: 14.06.13
 * Time: 16:52
 * To change this template use File | Settings | File Templates.
 */
package de.dirkkoehler.horst.views
{
	import de.dirkkoehler.horst.AppContext;

	import starling.display.Button;
	import starling.display.Sprite;

	public class SimpleScene extends Sprite
	{

		protected var backButton:Button;

		public function SimpleScene()
		{
			// the main menu listens for TRIGGERED events, so we just need to add the button.
			// (the event will bubble up when it's dispatched.)

			backButton = new Button( AppContext.assets.getTexture( "button_back" ), "Back" );
			backButton.name = "backButton";
			addChild( backButton );
		}

		override public function dispose ():void
		{
			backButton.dispose();
			super.dispose();
		}
	}
}
