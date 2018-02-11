package;

class StageGenerator{
	public static function getStage (stageNum:Int):Stage_{
		switch (stageNum){
		default:
			return new Stage1();
		case 2:
			return new Stage2();
		case 3:
			return new Stage3();
		case 4:
			return new Stage4();
		}
	}
}