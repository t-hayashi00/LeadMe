package actor;

import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.geom.Rectangle;
import openfl.geom.Point;
import openfl.Assets;
import openfl.events.Event;
import openfl.events.MouseEvent;


//武器を持っていない場合、後ろから接触した場合のみ撃破できる。
class ShellPlant implements Object_{
	private var image:Bitmap;
	private var ID:Int;

	public var container:Sprite = new Sprite();
	public var logical:Point = new Point();
	public var frame:Int = 0;
	public var dest:Point = new Point();
	public var removeThis:Bool = false;
	public var moveFrequency:Int = 0;

	private var drawArea:Rectangle;
	private var fileName:String = "mapChip.png";
	private var GRID_SIZE:Int = 32;
	private var isThrough:Bool = true;
	
	private var direction:Direction = new Direction("UP");
	private var state:States = MOVE;

	public var tips:Window;

	public function new (grid:Point,ID:Int){
		this.ID = ID;
		logical.x = 32*grid.x;
		logical.y = 32*grid.y;
		dest.x = grid.x;
		dest.y = grid.y;
		drawArea = new Rectangle (0,0,GRID_SIZE-1,GRID_SIZE);
		image = new Bitmap(Assets.getBitmapData("assets/"+fileName));
		image.scrollRect = drawArea;
		image.y -= 16;
		image.smoothing = false;
		container.addChild(image);
		update();
		tips = new Window(container.x, container.y, 100, 25, true);
		tips.textField.text = "STR: 1\nWEEK: BACK";
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
	public function getActorType():ActorType{return ENEMY;}
	public function getPriority():String{return "middle";}
	public function getThrough():Bool{return isThrough;}
	public function getDir():String{return direction.getDir();}
	public function grid():Point{
		return new Point(Math.floor(logical.x/32),Math.floor(logical.y/32));
	}

	public function actionToPlayer(player:Player):Void{
		
	}
	
	public function fightPower():Int{
		var power:Int = 1;
		return power;
	}

	public function draw(){
		var anime:Float = frame++;
		anime /= 25;
		anime %= 4;
		anime = Math.floor(anime);

		switch (direction.getDir()){
		case "UP":
			drawArea.x = 1 + GRID_SIZE*(anime);
			drawArea.y = 8*GRID_SIZE;
		case "RIGHT":
//			direction.turnDir = 2;
//			turn();
			drawArea.x = 1 + GRID_SIZE*(anime);
			drawArea.y = 8*GRID_SIZE;
		case "DOWN":
//			direction.turnDir = 0;
//			turn();
			drawArea.x = 1 + 4*GRID_SIZE + GRID_SIZE*(anime);
			drawArea.y = 8*GRID_SIZE;
		case "LEFT":
			drawArea.x = 1 + 4*GRID_SIZE + GRID_SIZE*(anime);
			drawArea.y = 8*GRID_SIZE;
		}
		if(removeThis){
			if(tips.container.parent != null)container.parent.parent.removeChild(tips.container);
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
	
	public function checkDest():Point{
		var pos:Point = new Point();
		pos.x = grid().x + direction.getNext().x;
		pos.y = grid().y + direction.getNext().y;
		return pos;
	}
	
	public function setDest():Point{
		dest.x = grid().x + direction.getNext().x;
		dest.y = grid().y + direction.getNext().y;
		direction.turnDir = 0;
		return dest;
	}

	public function turn():Void{
		direction.turnAround();
	}

	public function move():Bool{
		var moveEnd:Bool = (logical.x == dest.x*32) && (logical.y == dest.y*32);
		if(!moveEnd){
			logical.x += 2*direction.getNext().x;
			logical.y += 2*direction.getNext().y;
		}
		return moveEnd;
	}
	
	public function update(){
	}	

	public function removeThisEventListener():Void{}
	
}