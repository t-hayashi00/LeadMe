package	;


import field.Field;
import field.FieldCamera;
import actor.*;
import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.display.DisplayObject;
import openfl.geom.Point;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.events.KeyboardEvent;
import openfl.text.TextField;

/*
 * ゲームのメインの動作部分を管理するクラス
 */
class InGame{
	static public var focusSp:DisplayObject = null;
	private var start:Window;

	public var sprite:Sprite = new Sprite();
	public var container:Sprite = new Sprite();
		private var low:Sprite = new Sprite();
		private var middle:Sprite = new Sprite();
		private var high:Sprite = new Sprite();
	
	public var isRetry:Bool = false;
	public var isClear:Bool = false;
	//経過ターン数
	public var turnCount:Int = 0;

	private var player:Player;
		private var pos:Point = new Point();
	private var field:Field;
	private var camera:FieldCamera;
	private var objects:Map<Int,Object_> = new Map<Int,Object_>();

	private var sceneName:String = "set";
	private var midDown:Bool = false;
	
	public function new (player:Player,field:Field){
		this.field = field;
		this.player = player;
		sprite.x = player.container.x;
		sprite.y = player.container.y;
		focusSp = sprite;
		camera = new FieldCamera(focusSp,field,2.0);
		container.alpha = 1.0;
		container.addChild(low);
		container.addChild(middle);
		container.addChild(high);
		middle.addChild(player.container);
		var id:Int = 1;
		for(x in 0...field.stage.initActors.length){
			for(y in 0...field.stage.initActors[0].length){
				var object_:Object_ = null;
				switch(field.stage.initActors[x][y]){
				case "E":
					object_ = new ShellPlant(new Point(x,y),id);
				case "W":
					object_ = new Walker(new Point(x,y),id,"UP");
				case "WR":
					object_ = new Walker(new Point(x,y),id,"RIGHT");
				case "B":
					object_ = new Block(new Point(x,y),id);
				case "G":
					object_ = new Goal(new Point(x,y),id);
				default:
				}
				if(object_ != null){
					field.stage.objectID[x][y] = id;
					trace(id);
					addObject_(id,object_);
					id++;
				}
			}
		}
		for(i in 0...field.stage.objectID[0].length)
			trace(field.stage.objectID[i]);
		middle.alpha = 0.7;

		start = new Window(player.container.x, player.container.y, 100,30,true);
		start.textField.text = "Click Him \nTo Start The March!";
		player.container.addEventListener(MouseEvent.CLICK, startButton);
		field.container.parent.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, startCamera);
		field.container.parent.addEventListener(MouseEvent.RIGHT_MOUSE_UP, stopCamera);
		high.addChild(start.container);
	}

	private function startCamera( e:MouseEvent ):Void{
		pos.x = container.mouseX;
		pos.y = container.mouseY;
		field.container.parent.addEventListener(MouseEvent.MOUSE_MOVE, moveCamera);
		
		trace("DONW");
	}
	private function moveCamera( e:MouseEvent ):Void{
		sprite.x += pos.x - container.mouseX;
		sprite.y += pos.y - container.mouseY;
		trace("x:"+sprite.x);
		trace("y:"+sprite.y);
	}
	private function stopCamera( e:MouseEvent ):Void{
		if(sprite.x > 176)sprite.x = 176;
		if(sprite.x < -208)sprite.x = -208;
		if(sprite.y > 230)sprite.y = 230;
		if(sprite.y < -150)sprite.y = -250;
		field.container.parent.removeEventListener(MouseEvent.MOUSE_MOVE, moveCamera);
		trace("UP");
	}

	public function update(){
		switch(this.sceneName){
		case "set":
			camera.setContainer(focusSp);
		case "start":
			if(middle.alpha < 1){
				middle.alpha += 0.01;
			} else {
				moveActors();
			}
		case "clear":
			clear();
		case "gameOver":
			gameOver();
			//			camera.setContainer(field.container);
		default:
		}
	}
	
	public function draw(){
		// オブジェクトを描画する際に画面のオブジェクトを走査するのでこのタイミングでObjectIDも更新
		for(x in 0...field.stage.objectID.length){
			for(y in 0...field.stage.objectID[0].length){
				field.stage.objectID[x][y] = 0;
			}
		}
		var It:Iterator<Object_> = objects.iterator();
		while(It.hasNext()){
			var object_:Object_ = It.next();
			if(!object_.removeThis){
				field.stage.objectID[Math.floor((object_.grid().x))][Math.floor((object_.grid().y))] = object_.getID();
			}
			if(object_.removeThis && object_.container.x < -250){
				objects.remove(object_.getID());
				object_.container.parent.removeChild(object_.container);
			}
			object_.draw();
		}
		if(InGame.focusSp == null)camera.setContainer(player.container);
		camera.update();
		player.draw();
	}
	
	// "set"
	private function startButton( e:MouseEvent ){
		field.container.parent.removeEventListener(MouseEvent.RIGHT_MOUSE_DOWN, startCamera);
		field.container.parent.removeEventListener(MouseEvent.MOUSE_MOVE, moveCamera);
		field.container.parent.removeEventListener(MouseEvent.RIGHT_MOUSE_UP, stopCamera);
		camera.setContainer(player.container);
		high.removeChild(start.container);
		var obejectIt:Iterator<Object_> = objects.iterator();
		while(obejectIt.hasNext()){
			obejectIt.next().removeThisEventListener();
		}
		sceneName = "start";
		player.state = "MOVE";
	}

	// "start"
	private function moveActors():Void{
		var turnChange:Int = turnCount;
		if(moveCheck(player.moveFrequency)){
			if(player.move()){
				checkObject(0);
				checkTerrain(0);
				turnCount++;
				player.update();
			}else{
				sortContainer(middle);
			}
		}
		var It:Iterator<Object_> = objects.iterator();
		while(It.hasNext()){
			var o:Object_ = It.next();
			if(moveCheck(o.moveFrequency)){
				if(o.move()){
					checkSomething(o,0);
					if(turnChange != turnCount){
						o.update();
					}
				}
			}
		}
	}
	
	private function moveCheck(mf:Int):Bool{
		return (mf != 0 && turnCount%mf == 0);
	}
	
	private function checkSomething(actor:Object_,cnt:Int):Void{
		if(cnt>3)return;
		var result:Bool = true;
		var objectID:Int = field.getObjectID(actor.checkDest());
		if(objectID != 0){
			var object_:Object_ = objects.get(objectID);
			if(object_ != null && object_.getPriority() == actor.getPriority())result = false;
		}
		if(field.getTerrainID(actor.checkDest()) != "F")result = false;

		if(result){
			actor.setDest();			
		}else{
			actor.turn();
			checkSomething(actor,cnt+1);
		}
	}
	
	private function checkObject(cnt:Int){
		if(cnt>3)return;
		var objectID:Int = field.getObjectID(player.grid());
		if(objectID != 0){
			var object_:Object_ = objects.get(objectID);
			if(object_ != null)callEvent(object_);
		}
		objectID = field.getObjectID(player.checkDest());
		if(objectID != 0){
			var object_:Object_ = objects.get(objectID);
			if(object_ != null && object_.getPriority() == "middle"){
				callEvent(object_);
				if(!object_.getThrough()){
					player.turn();
					checkObject(cnt+1);
					checkTerrain(cnt+1);
				}
			}
		}
	}
	
	private function checkTerrain(cnt:Int):Void{
		if(cnt>3)return;
		switch(field.getTerrainID(player.checkDest())){
		case "F":
			player.setDest();
		default:
			player.turn();
			checkObject(cnt+1);
			checkTerrain(cnt+1);
		}
	}
	
	private function callEvent(object_:Object_):Void{
		switch (object_.getActorType()){
		case BLOCK:
			object_.actionToPlayer(player);
		case ENEMY:
			player.frame = 0;
			if(battle(object_)){
				player.state = "ATTACK";
				if(player.getDir() == "UP" || player.getDir() == "RIGHT"){
					player.animator.addAnimation("slash_l");
				}else{
					player.animator.addAnimation("slash_r");
				}
				object_.removeThis = true;
			}else{
				pos.x = player.container.x;
				pos.y = player.container.y;
				player.removeThis = true;
				sceneName = "gameOver";
				field.container.parent.addChild(Draw.setupScreenEffect());
			}
		case GIMMICK:
			object_.actionToPlayer(player);
		case GOAL:
			trace(":"+player.frame);
			player.frame = 0;
			camera.setContainer(object_.container);
			field.container.parent.addChild(Draw.setupScreenEffect());
			Draw.flashScreen(0xFFFFFF,1);
			Draw.trancparancy(0);
			object_.removeThis = true;
			sceneName = "clear";
		}
	}
	
	private function battle(object_:Object_):Bool{
		var playerPower:Int = player.fightPower();

		if(player.getDir() == object_.getDir()){
			playerPower += 1;
		}

		return playerPower > object_.fightPower(); 
	}
	
	//GameOver
	private function gameOver(){
		if(player.frame <= 100 && player.frame%25==0){
			player.container.x = pos.x;
			player.container.y = pos.y;
			camera.setContainer(player.container);
			camera.scrollAdjust();
		}
		switch(player.frame){
		case 1:
			Draw.tintScreen(0xFF00FF,1.0);
		case 25:
			camera.setScale(3);
			camera.scaleAdjust();
			Draw.tintScreen(0x00FFFF,1.0);
		case 50:
			camera.setScale(3.2);
			camera.scaleAdjust();
			Draw.tintScreen(0x00FF00,1.0);
		case 75:
			camera.setScale(3.4);
			camera.scaleAdjust();
			Draw.tintScreen(0x0000FF,1.0);
		case 100:
			camera.setScale(3.6);
			camera.scaleAdjust();
			Draw.tintScreen(0xFF0000,1.0);
			field.container.parent.stage.frameRate *= 0.3;
		case 125:
			camera.setScale(3.8);
			camera.scaleAdjust();
			field.container.parent.stage.frameRate = 60;
			Draw.tintScreen(0x000000,1.0);			
		case 140:
			camera.setScale(4);
			camera.scaleAdjust();
			Draw.tintScreen(0x000000,0.0);
			Draw.removeScreenEffect();
			isRetry = true;
		}
	}

	// clear
	private function clear():Void{
			trace("a:"+player.frame);
		if(player.frame >= 180){
			Draw.removeScreenEffect();
			isClear = true;
		}else if(player.frame >= 60){
			Draw.trancparancy((player.frame-60)/90);
		}
	}
	
	// 以下汎用的に使うメソッド
	
	private function sortContainer(container:Sprite){
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

	private function addObject_(id:Int,object_:Object_){
		objects.set(id,object_);
		switch(object_.getPriority()){
		case "low":
			low.addChild(object_.container);
		case "middle":
			middle.addChild(object_.container);
		case "high":
			high.addChild(object_.container);
		default:
			high.addChild(object_.container);
		}
	}	
}