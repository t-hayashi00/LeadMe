package anime;

import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.geom.Rectangle;
import openfl.geom.Point;
import openfl.Assets;

//アニメーションの基底
interface Animation{
	public var container:Sprite = new Sprite();
	//こいつが0になったら所持されてるオブジェクトからリムーブされて消滅する
	private var lifeTime:Int;
	
	//この中にアニメーションの詳細をガリガリ書けばいい
	public function draw():Void;
	public function isEnd():Bool;
}