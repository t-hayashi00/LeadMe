//
// RIGHT  DOWN
//　　　＼　　／
//　　　　　○
//　　　／　　＼
//  UP    LEFT
//
// LEFT -> x++
// UP -> y++
package actor;
import openfl.geom.Point;

class Direction{
	private var dirStr:String = "UP";
	private var dirNum:Int = 0;
	private var v:Point = new Point(0,1);
	//次に曲がる方向
	public var turnDir:Int = 0;
	//曲がろうとした回数(4以上だと移動不可)
	public var turnCount:Int = 0;
	
	public function new (dirStr:String){
		this.dirStr = dirStr;
		switch (dirStr){
		case "UP":
			this.dirNum = 0;
		case "RIGHT":
			this.dirNum = 1;
		case "DOWN":
			this.dirNum = 2;
		case "LEFT":
			this.dirNum = 3;
		default: //UP
			this.dirStr = "UP";
			this.dirNum = 0;
		}
	}
	
	public function getDirNum():Int{return dirNum;}
	
	public function getDir():String{return dirStr;}

	// + -> turnRight
	public function turnRight(){
		dirNum = (dirNum + 1) % 4;
		updateDir();
	}

	// - -> turnLeft
	public function turnLeft(){
		dirNum = (dirNum + 3) % 4;
		updateDir();
	}

	// ++ -> turnAround
	public function turnAround(){
		turnRight();
		turnRight();
	}

	public function setDir(dirNum:Int){
		this.dirNum = dirNum % 4;
		updateDir();
	}

	public function getNext():Point{
		return v;
	}

	private function updateDir():Void{
		switch (dirNum){
		default: //0
			dirStr = "UP";
			v.x = 0;
			v.y = 1;
		case 1:
			dirStr = "RIGHT";
			v.x = -1;
			v.y = 0;
		case 2:
			dirStr = "DOWN";
			v.x = 0;
			v.y = -1;
		case 3:
			dirStr = "LEFT";
			v.x = 1;
			v.y = 0;
		}
	}
}