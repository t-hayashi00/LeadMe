package	actor.scene;

import field.Field;
import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.geom.Point;

class Set implements Scene{
	private var container:Sprite;
	private var player:Player;
	private var objects:Map<Int,Object_>;
	private var field:Field;
	private var nextScene_:String = "";

	public function new (container:Sprite,player:Player,objects:Map<Int,Object_>,field:Field){
		this.container = container;
		this.player = player;
		this.objects = objects;
		this.field = field;
		container.alpha = 0.6;
	}
	
	public function update(){
		
		if(container.alpha < 0.6)container.alpha += 0.02;
		player.update();
	}

	public function getNextScene():String{
		return nextScene_;
	}
	
	private function sortContainer(){}
}