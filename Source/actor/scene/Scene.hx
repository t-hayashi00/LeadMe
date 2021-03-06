package	actor.scene;

import field.Field;
import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.geom.Point;

interface Scene{
	private var container:Sprite;
	private var player:Player;
	private var objects:Map<Int,Object_>;
	private var field:Field;
	private var nextScene_:String;
	public function getNextScene():String;
	public function update():Void;	
}