package actor;

import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.geom.Rectangle;
import openfl.geom.Point;
import openfl.Assets;

class Cursor {
	private var image:Bitmap;
	public var container:Sprite = new Sprite();

	private var drawArea:Rectangle;
	private var fileName:String = "c_cursor.png";
	private var GRID_SIZE:Int = 32;
	private var quarterView:Bool = false;
	
	private var base:Sprite;
	
	public function new (base:Sprite){
		this.base = base;
		image = new Bitmap(Assets.getBitmapData("assets/"+fileName));
		image.y -= 16;
		image.smoothing = false;
		container.addChild(image);
		update();
		drawArea = new Rectangle (0,0,GRID_SIZE,GRID_SIZE);
		draw(0);
	}

	public function draw(anime:Float){
		anime /= 30;
		anime %= 3;
		anime = Math.floor(anime);
				
		drawArea.x = GRID_SIZE*(anime);
		drawArea.y = 0;

		image.scrollRect = drawArea;
		container.x = base.stage.mouseX -225*0.5;
		container.y = base.stage.mouseY -200*0.5;
	}
	
	public function grid():Point{
		var x:Float = base.stage.mouseY*2 + base.stage.mouseX*0.5 + 16;
		var y:Float = base.stage.mouseY*2 - base.stage.mouseX*0.5 - 16;
		return new Point(Math.floor(x/32),Math.floor(y/32));
	}	
	
	public function update(){
/*		switch(state){
		case WAIT:

		case MOVE:

		case DEAD:
			
		case DAMAGE:
			
		case CLEAR:
			
		}
*/	}	
}