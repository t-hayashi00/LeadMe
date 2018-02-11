package actor;

import anime.*;
import field.Field;
import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.geom.Rectangle;
import openfl.geom.Point;
import openfl.Assets;

class Player implements Actor{
	private var image:Bitmap;
	public var animator:Animator;

	public var container:Sprite = new Sprite();
	public var logical:Point = new Point();
	public var frame:Int = 0;
	public var removeThis:Bool;
	public var moveFrequency:Int = 1;
	public var state:String = "WAIT";
		private var preState:String = "WAIT";

	private var dest:Point = new Point();
	private var drawArea:Rectangle;
	private var fileName:String = "c_hero.png";
	private var GRID_SIZE:Int = 32;
	private var isThrough:Bool = false;
	
	private var direction:Direction = new Direction("UP");

	public function new (grid:Point){
		logical.x = 32*grid.x;
		logical.y = 32*grid.y;
		dest.x = grid.x;
		dest.y = grid.y;
		image = new Bitmap(Assets.getBitmapData("assets/"+fileName));
		image.y -= 16;
		image.smoothing = false;
		container.addChild(image);
		update();
		drawArea = new Rectangle (0,0,GRID_SIZE,GRID_SIZE);
		image.scrollRect = drawArea;
		animator = new Animator(container);
		draw();
	}

	public function getPriority():String{return "middle";}
	public function getThrough():Bool{return isThrough;}
	public function getDir():String{return direction.getDir();}

	public function grid():Point{
		return new Point(Math.floor(logical.x/32),Math.floor(logical.y/32));
	}

	public function draw():Void{
		frame++;
		if(removeThis){
			if(Module.getFrameCount()%2==0)
			turn();
			container.x -= 8;
			container.y -= 10;			
		}else{
			container.x = Draw.convertQuaterViewX(logical.x,logical.y);
			container.y = Draw.convertQuaterViewY(logical.x,logical.y);
		}

		var anime:Int = 0;
		animator.draw();
		switch(state){
		case "RESPAWN":
			anime = animeFrame(10,4);
			drawArea.y = GRID_SIZE * 0;		
			Draw.animationWait = respawnAnimation();
		case "WAIT":
			anime = animeFrame(10,4);
			drawArea.y = GRID_SIZE * 0;
		case "MOVE":
			anime = animeFrame(10,4);
			drawArea.y = GRID_SIZE * 2;
		case "ATTACK":
			Draw.animationWait = attackAnimation();
			return;
		}
		
		drawArea.x = GRID_SIZE*(anime) + 4*GRID_SIZE*(direction.getDirNum()%2);
		drawArea.y += GRID_SIZE * Math.floor(direction.getDirNum()/2);
		preState = state;
	}

	private function animeFrame(speed:Int,sheets:Int):Int{
		var anime:Float = frame;
		anime /= speed;
		anime %= sheets;
		return Math.floor(anime);
	}

	private function respawnAnimation():Bool{
		if(frame == 6)animator.addAnimation("surprised");
		if(frame > 6){
			if(frame <= 11){
				image.y -= 3;
			}else if(frame <= 16){
				image.y += 3;
			}else {
				state = "WAIT";
				return false;
			}
		}
		return true;
	}
	private function attackAnimation():Bool{
		if(frame < 16)drawArea.x = GRID_SIZE*(Math.floor(frame/2));
		drawArea.y = GRID_SIZE * 12;
		drawArea.y += GRID_SIZE * Math.floor(direction.getDirNum()/2);
		if(frame == 20){
			state = "MOVE";
			return false;
		}
		return true;
	}
	
	public function fightPower():Int{
		var power:Int = 1;
		return power;
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
		direction.turnDir %= 3;
		if(direction.turnDir < 0) direction.turnDir = 0;
		if(direction.turnDir > 2) direction.turnDir = 2;
		switch(direction.turnDir){
		case 0:
			direction.turnRight();
		case 1:
			direction.turnAround();
		case 2:
			direction.turnLeft();
		}
		direction.turnDir += 1;
	}

	public function move():Bool{
		var moveEnd:Bool = (logical.x == dest.x*32) && (logical.y == dest.y*32);
		if(!moveEnd){
			logical.x += 2*direction.getNext().x;
			logical.y += 2*direction.getNext().y;
		}else{
		}
		return moveEnd;
	}
	
	public function update(){
	}	
}