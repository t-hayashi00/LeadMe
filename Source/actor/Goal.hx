package actor;

import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.geom.Rectangle;
import openfl.geom.Point;
import openfl.Assets;
import openfl.events.Event;
import openfl.events.MouseEvent;

class Goal implements Object_{
	private var image:Bitmap;
	private var ID:Int;
	public var container:Sprite = new Sprite();
	public var logical:Point = new Point();
	public var frame:Int = 0;
	public var next:Point = new Point();
	private var drawArea:Rectangle;
	private var fileName:String = "c_cursor.png";
	private var GRID_SIZE:Int = 32;
	private var isThrough:Bool = true;
	public var removeThis:Bool = false;
	public var moveFrequency:Int = 0;
	
	private var direction:Direction = new Direction("UP");

	public var tips:Window;
		private var toggle:Bool = false;

	public function new (grid:Point,ID:Int){
		this.ID = ID;
		logical.x = 32*grid.x;
		logical.y = 32*grid.y;
		image = new Bitmap(Assets.getBitmapData("assets/"+fileName));
		image.y -= 16;
		image.smoothing = false;
		container.addChild(image);
		update();
		drawArea = new Rectangle (0,0,GRID_SIZE-1,GRID_SIZE);
		image.scrollRect = drawArea;
		tips = new Window(container.x, container.y, 100, 14, true);
		tips.textField.text = "DESTINATION";
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
	public function getActorType():ActorType{return GOAL;}
	public function getPriority():String{return "low";}
	public function getThrough():Bool{return isThrough;}
	public function removeThisEventListener():Void{}
	public function getDir():String{return "";}
	public function fightPower():Int{return 0;}

	public function actionToPlayer(player:Player):Void{
	}

	public function draw():Void{
		var anime:Float = frame++;
		var anime:Float = frame++;
		if(removeThis){
			if(tips.container.parent != null)container.parent.parent.removeChild(tips.container);
			container.removeEventListener(MouseEvent.MOUSE_OUT, hideTips);
			container.removeEventListener(MouseEvent.MOUSE_OVER, showTips);
			anime /= 2;
			anime %= 6;
			anime = Math.floor(anime);

			drawArea.x = GRID_SIZE*(anime);
			drawArea.y = 0;
			if(image.alpha > 0.0)image.alpha -= 0.01;
			container.y -= 0.5;
			return ;
		}else{
			tips.setX(container.x);
			tips.setY(container.y);
		}
		anime /= 6;
		anime %= 6;
		anime = Math.floor(anime);

		drawArea.x = GRID_SIZE*(anime);
		drawArea.y = 0;
		
		container.x = Draw.convertQuaterViewX(logical.x,logical.y);
		container.y = Draw.convertQuaterViewY(logical.x,logical.y);
	}	

	public function grid():Point{
		return new Point(Math.floor(logical.x/32),Math.floor(logical.y/32));
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
}