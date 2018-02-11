package anime;

import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.geom.Rectangle;
import openfl.Assets;

class TestAnime implements Animation{
	public var container:Sprite = new Sprite();
	private var lifeTime:Int;
	
	private var image:Bitmap;
	private	var drawArea:Rectangle;
	
	public function new(){
		image = new Bitmap(Assets.getBitmapData("assets/c_cursor.png"));
		drawArea = new Rectangle (0,0,32,32);
		image.scrollRect = drawArea;
		image.alpha = 1.0;
		image.y -= 16;
		container.addChild(image);
		lifeTime = 60;
	}
	
	public function draw():Void{
		var anime:Float = lifeTime;
		anime %=6;
		
		drawArea.x = 32*(anime);

		lifeTime--;
	}
	
	public function isEnd():Bool{
		return (lifeTime <= 0);
	}
}