package anime;

import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.geom.Rectangle;
import openfl.Assets;

class Surprised implements Animation{
	public var container:Sprite = new Sprite();
	private var lifeTime:Int;
	
	private var image:Bitmap;
	private	var drawArea:Rectangle;
	
	public function new(){
		image = new Bitmap(Assets.getBitmapData("assets/a_emotion.png"));
		drawArea = new Rectangle (0,0,32,32);
		image.scrollRect = drawArea;
		image.alpha = 1.0;
		container.addChild(image);
		container.x = 26;
		container.y = 6;
		image.x -= 30;
		image.y -= 30;
		lifeTime = 31;
	}
	
	public function draw():Void{
		if(lifeTime < 8)container.alpha -= 0.13;
		container.scaleX += 0.02;
		container.scaleY += 0.02;

		lifeTime--;
	}
	
	public function isEnd():Bool{
		return (lifeTime <= 0);
	}
}