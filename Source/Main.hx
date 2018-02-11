package;
import openfl.display.Sprite;

class Main extends Sprite {
	var game:Game;
	public function new () {
		super ();
		// スプライトを引数として動くループ
		game = new Game(this);		
	}
	
	
}