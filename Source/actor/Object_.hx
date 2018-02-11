package actor;

import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.geom.Point;

interface Object_ extends Actor{
	private var ID:Int;
	public var tips:Window;

	public function getID():Int;
	public function getActorType():ActorType;
	public function fightPower():Int;
	public function actionToPlayer(player:Player):Void;
	public function removeThisEventListener():Void;
}