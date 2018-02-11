package anime;

import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.geom.Rectangle;
import openfl.Assets;

class Slash implements Animation{
	public var container:Sprite = new Sprite();
	private var lifeTime:Int;
	
	private var image:Bitmap;
	private	var drawArea:Rectangle;
	private	var dir:Int;
	
	public function new(dir:Int){
		this.dir = dir;
		image = new Bitmap(Assets.getBitmapData("assets/a_slash.png"));
		drawArea = new Rectangle (0,dir*32,32,32);
		image.scrollRect = drawArea;
		image.alpha = 1.0;
		image.x = -16 + dir*32;
		image.y = -12;
		container.addChild(image);
		lifeTime = 10;
	}
	
	public function draw():Void{
		var anime:Float = 10 - lifeTime;
		anime/=2;
		
		drawArea.x = 32*(Math.floor(anime));

		lifeTime--;
	}
	
	public function isEnd():Bool{
		return (lifeTime <= 0);
	}
}