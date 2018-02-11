package actor;

import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.geom.Rectangle;
import openfl.geom.Point;
import openfl.Assets;
import openfl.events.Event;
import openfl.events.MouseEvent;

class Block implements Object_{
	private var image:Bitmap;
	private var ID:Int;
	public var container:Sprite = new Sprite();
	public var logical:Point = new Point();
	public var frame:Int = 0;
	private var drawArea:Rectangle;
	private var fileName:String = "mapChip.png";
	private var GRID_SIZE:Int = 32;
	private var isThrough:Bool = false;
	public var removeThis:Bool = false;
	public var moveFrequency:Int = 0;
	
	private var direction:Direction = new Direction("UP");

	public var tips:Window;

	public function new (grid:Point,ID:Int){
		this.ID = ID;
		logical.x = 32*grid.x;
		logical.y = 32*grid.y;
		drawArea = new Rectangle (7*GRID_SIZE,15*GRID_SIZE,GRID_SIZE,GRID_SIZE);
		image = new Bitmap(Assets.getBitmapData("assets/"+fileName));
		image.y -= 16;
		image.smoothing = false;
		image.scrollRect = drawArea;
		container.addChild(image);
		update();
		container.addEventListener(MouseEvent.CLICK, removeThisFromField);
		tips = new Window(container.x, container.y, 100, 14, true);
		tips.textField.text = "Click To Remove";
		container.addEventListener(MouseEvent.MOUSE_OVER, showTips);
		container.addEventListener(MouseEvent.MOUSE_OUT, hideTips);
//		draw();
	}

	private function showTips( e:MouseEvent ):Void{
		container.parent.parent.addChild(tips.container);
	}
	private function hideTips( e:MouseEvent ):Void{
		container.parent.parent.removeChild(tips.container);
	}
	
	public function getID():Int{return ID;}
	public function getActorType():ActorType{return BLOCK;}
	public function getPriority():String{return "middle";}
	public function getThrough():Bool{return isThrough;}
	public function getDir():String{return direction.getDir();}

	public function actionToPlayer(player:Player):Void{
	}

	public function draw(){
		var anime:Float = frame++;
		if(removeThis){
			container.removeEventListener(MouseEvent.MOUSE_OUT, hideTips);
			container.removeEventListener(MouseEvent.MOUSE_OVER, showTips);
			container.x -= 8;
			container.y -= 10;
		}else{
			tips.setX(container.x);
			tips.setY(container.y);
			container.x = Draw.convertQuaterViewX(logical.x,logical.y);
			container.y = Draw.convertQuaterViewY(logical.x,logical.y);
		}
	}	

	public function grid():Point{
		return new Point(Math.floor(logical.x/32),Math.floor(logical.y/32));
	}

	public function fightPower():Int{
		return 0;
	}
	
	public function checkDest():Point{
		return null;
	}
	
	public function setDest():Point{
		return null;
	}

	public function turn():Void{
	}

	public function move():Bool{
		return false;
	}
	
	public function update(){
	}

	public function removeThisEventListener():Void{
		container.removeEventListener(MouseEvent.CLICK, removeThisFromField);
		trace("removeEventListener");
	}
	
	private function removeThisFromField( e:MouseEvent ):Void{
		container.parent.parent.removeChild(tips.container);
		removeThis = true;
		container.removeEventListener(MouseEvent.CLICK, removeThisFromField);
	}
}