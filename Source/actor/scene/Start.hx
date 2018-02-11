package	actor.scene;

import field.Field;
import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.geom.Point;

class Start implements Scene{
	private var container:Sprite;
	private var player:Player;
	private var objects:Map<Int,Object_>;
	private var field:Field;

	private var nextScene_:String = "";
	private var phase:String = "set";
	
	public function new (container:Sprite,container:Sprite,player:Player,objects:Map<Int,Object_>,field:Field){
		this.container = container;
		this.player = player;
		this.objects = objects;
		this.field = field;
	}
	
	public function getNextScene():String{
		return nextScene_;
	}
	
	public function update(){
		if(container.alpha < 1.0)container.alpha += 0.05;
		//イベント呼び出し→次に移動する場所を決める
		if(phase == "set"){
			trace("set");
			checkObject();
			checkTerrain();
			phase = "move";
		}
		if(phase == "move"){
			moveActors();
		}
		player.update();
	}

	private function checkObject(){
		var objectID:Int = field.getObjectID(player.grid());
		if(objectID != 0){
			var object_:Object_ = objects.get(objectID);
			if(object_ != null && object_.getPriority() != "middle")callEvent(object_);
		}
		objectID = field.getObjectID(player.checkDest());
		if(objectID != 0){
			var object_:Object_ = objects.get(objectID);
			if(object_ != null && object_.getPriority() == "middle"){
				callEvent(object_);
				if(!object_.getThrough()){
					player.turn();
					checkObject();
					checkTerrain();
				}
			}
		}
	}
	
	private function checkTerrain():Void{
		switch(field.getTerrainID(player.checkDest())){
		case "F":
			player.setDest();
		default:
			player.turn();
			checkObject();
			checkTerrain();
		}
	}

	private function moveActors(){
//		sortContainer();
		if(player.move()){
			phase = "set";
		}
	}
	
	private function callEvent(object_:Object_):Void{
		switch (object_.getActorType()){
		case BLOCK:
			object_.actionToPlayer(player);
		case ENEMY:
			if(battle(object_)){
				object_.removeThis = true;
			}else{
				player.removeThis = true;
				nextScene_ = "gameOver";
			}
		case GIMMICK:
			object_.actionToPlayer(player);
		case GOAL:
			object_.removeThis = true;
			nextScene_ = "clear";
		}
	}
	
	private function battle(object_:Object_):Bool{
		var playerPower:Int = player.fightPower();

		if(player.getDir() == object_.getDir()){
			playerPower += 1;
		}

		return playerPower > object_.fightPower(); 
	}
	
	private function sortContainer(){
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