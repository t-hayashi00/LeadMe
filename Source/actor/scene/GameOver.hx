package	actor.scene;

import field.Field;
import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.geom.Point;

class GameOver implements Scene{
	private var container:Sprite;
	private var player:Player;
	private var objects:Map<Int,Object_>;
	private var field:Field;
	private var nextScene_:String = "";

	
	public function new (container:Sprite,player:Player,objects:Map<Int,Object_>,field:Field){
		this.container = container;
		this.player = player;
		this.ontoObjects = ontoObjects;
		this.onObjects = onObjects;
		this.field = field;
	}
	
	public function update(){
	}

	public function getNextScene():String{
		return nextScene_;
	}
	
}