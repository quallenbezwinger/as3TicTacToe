package de.dirkkoehler.horst.views.elements
{
    import flash.display.BitmapData;
    import flash.display.Shape;
    
    import starling.core.Starling;
    import starling.display.Image;
    import starling.display.Quad;
    import starling.display.Sprite;
    import starling.textures.Texture;

    public class VProgress extends Sprite
    {
        private var mBar:Quad;
        private var mBackground:Image;
        
        public function VProgress(width:int, height:int)
        {
			var scale:Number = Starling.contentScaleFactor;
			var padding:Number = height * 0.2;
			var cornerRadius:Number = padding * scale * 2;

			// create black rounded box for background

			var bgShape:Shape = new Shape();
			bgShape.graphics.beginFill(0x0, 0.5);
			bgShape.graphics.drawRoundRect(0, 0, width*scale, height*scale, cornerRadius, cornerRadius);
			bgShape.graphics.endFill();

			var bgBitmapData:BitmapData = new BitmapData(width*scale, height*scale, true, 0x0);
			bgBitmapData.draw(bgShape);
			var bgTexture:Texture = Texture.fromBitmapData(bgBitmapData, false, false, scale);

			mBackground = new Image(bgTexture);
			addChild(mBackground);

			// create progress bar quad

			mBar = new Quad(width - 2*padding, height - 2*padding, 0xeeeeee);
			mBar.setVertexColor(2, 0xaaaaaa);
			mBar.setVertexColor(3, 0xaaaaaa);
			mBar.x = padding;
			mBar.y = padding;
			mBar.scaleX = 0;
			addChild(mBar);
        }
        
        public function get ratio():Number { return mBar.scaleX; }
        public function set ratio(value:Number):void 
        { 
            mBar.scaleX = Math.max(0.0, Math.min(1.0, value)); 
        }
    }
}