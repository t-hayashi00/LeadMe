package actor;

import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.geom.Rectangle;
import openfl.geom.Point;

interface Actor{
	private var image:Bitmap;
	public var container:Sprite;
	public var logical:Point;
	public var frame:Int;
	public var removeThis:Bool;
	//1...毎ターン動く 2...二ターンに一回動く
	public var moveFrequency:Int;
	private var isThrough:Bool;
	private var direction:Direction;

	public function getPriority():String;
	public function getThrough():Bool;
	public function getDir():String;
	public function grid():Point;
	public function draw():Void;
	public function checkDest():Point;
	public function setDest():Point;
	public function turn():Void;
	public function move():Bool;
	public function update():Void;
}