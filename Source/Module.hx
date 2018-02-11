package;

class Module{
	static public var width:Float;
	static public var height:Float;

	static var frame:Int = 0;
	static var gameSpeed:Int = 0;
	static public function getFrameCount():Int{
		return frame;
	}
	static public function frameCount():Void{
		frame++;
	}
	static public function speedControll():Void{
		frame++;
	}
}