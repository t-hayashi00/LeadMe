package field;

import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.display.BlendMode;
import openfl.geom.Rectangle;
import openfl.Assets;

class MapChip {
	public var image:Bitmap;
	private var drawArea:Rectangle;
	private var fileName:String;
	private var gridSize:Int=32;

	public function new (fileName:String, x:Int, y:Int) {
		this.fileName = fileName;
		image = new Bitmap(Assets.getBitmapData("assets/"+fileName));
		drawArea = new Rectangle (0,0,gridSize,gridSize);
		drawArea.x = gridSize*x;
		drawArea.y = gridSize*y;
		image.scrollRect = drawArea;
	}
}