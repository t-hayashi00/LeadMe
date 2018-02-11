package;
import openfl.display.Sprite;
import openfl.display.Graphics;
import openfl.display.BlendMode;
import openfl.display.Bitmap;

class Draw{
	static public var animationWait:Bool = false;
	static var screenEffect:Sprite = null;
	static public function setupScreenEffect():Sprite{
		screenEffect = new Sprite();
		screenEffect.graphics.beginFill (0x000000, 0.0);
		screenEffect.graphics.drawRect (0,0,Module.width,Module.height);
		return screenEffect;
	}
	static public function removeScreenEffect():Void{
		trace(screenEffect.parent);
		if(screenEffect.parent == null)return;
		screenEffect.parent.removeChild(screenEffect);
	}
	static public function trancparancy(alpha:Float):Void{
		if(screenEffect.parent == null)return;
		if(alpha > 1)alpha = 1;
		if(alpha < 0)alpha = 0;
		screenEffect.alpha = alpha;
	}
	static public function tintScreen(color:UInt,alpha:Float):Void{
		if(screenEffect.parent == null)return;
		if(alpha > 1)alpha = 1;
		if(alpha < 0)alpha = 0;
		screenEffect.blendMode = BlendMode.MULTIPLY;
		screenEffect.graphics.beginFill (color, alpha);
		screenEffect.graphics.drawRect (0,0,Module.width,Module.height);
	}
	static public function flashScreen(color:UInt,alpha:Float):Void{
		if(screenEffect.parent == null)return;
		if(alpha > 1)alpha = 1;
		if(alpha < 0)alpha = 0;
		screenEffect.blendMode = BlendMode.ADD;
		screenEffect.graphics.beginFill (color, alpha);
		screenEffect.graphics.drawRect (0,0,Module.width,Module.height);
	}
	

	static public function convertQuaterViewX(x:Float,y:Float):Float{
		return 0.5*(x-y)-16;
	}
	static public function convertQuaterViewY(x:Float,y:Float):Float{
		return 0.25*(x+y);
	}
	
	
	static public function sortContainer(container:Sprite){
		var i:Int = 0;
		while(i < container.numChildren){
			var j:Int = i+1;
			while(j < container.numChildren){
				if(container.getChildAt(i).y > container.getChildAt(j).y && container.getChildAt(i).y - container.getChildAt(j).y < 16){
					container.swapChildren(container.getChildAt(i),container.getChildAt(j));
				}
				j++;
			}
			i++;
		}
	}	
}