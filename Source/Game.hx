package;
import actor.*;
import field.*;
import anime.*;

import openfl.display.Graphics;
import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.text.TextField;
import openfl.display.BlendMode;
import openfl.geom.Rectangle;
import openfl.Assets;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.ui.Mouse;
import openfl.events.KeyboardEvent;
import openfl.geom.Point;
import openfl.ui.Keyboard;
/**
 * ...
 * @author　Sigmal00
 */
class Game {
	var UI:Sprite;
	var game:Sprite = new Sprite();
	var drawArea:Rectangle;
	var panorama:Bitmap = new Bitmap(Assets.getBitmapData("assets/panorama.png"));
	var field:Field;
	var player:Player;
	var inGame:InGame;
	var observer:TextField = new TextField();	
	var retry:TextField = new TextField();
	var gameClear:Bool = false;
	var alert:Bitmap;
	var frameCount:Int;

	var stageNum:Int = 1;
	var test:Int = 0;

	// MainでこいつにMainのスプライトを突っ込んでやることでメインループが成立する
	public function new (UI:Sprite) {
		this.UI = UI;
		UI.addChild(game);
		game.addChild(panorama);
		setup(1.0);
		game.stage.addEventListener(Event.ENTER_FRAME,update);
	}
	
	private function setup(scale:Float){
		field = new Field("mapChip.png",StageGenerator.getStage(stageNum));
		field.container.scaleX = scale;
		field.container.scaleY = scale;
		field.container.x = panorama.width/2;
		field.container.y = 200;
		field.showX = field.container.x;
		field.showY = field.container.y;
		game.addChild(field.container);
		
		Module.width = panorama.width;
		Module.height = panorama.height;
		UI.scrollRect = new Rectangle (0,0,Module.width,Module.height);
		game.scrollRect = new Rectangle (0,0,Module.width,Module.height);

		UI.stage.frameRate = 60;

		frameCount = 0;
		
		player = new Player(field.searchActor("P"));
	    inGame = new InGame(player,field);
		field.container.addChild(inGame.container);
		observer;
		UI.addChild(observer);
		UI.addChild(retry);
		retry.y = 15;
		trace(retry.textWidth);
		trace(retry.textHeight);
		retry.addEventListener(MouseEvent.CLICK, retryButton);
	}

	private function retryButton( e:MouseEvent ){
		game.removeChildren(1,game.numChildren);
		setup(1.0);
	}

	private function deathRuler(){
		game.removeChildren(1,game.numChildren);
		setup(2.0);
		player.state = "RESPAWN";
	}

	private function nextStage(){
		game.removeChildren(1,game.numChildren);
		setup(1.0);
		player.state = "WAIT";
	}

	private function draw(){
		inGame.draw();
	}
	
	// ここループ本体
	private function update(event:Event){
		if(!gameClear){
			retry.text = "RETRY";
			observer.text = "" + Module.getFrameCount();

			if(!Draw.animationWait)inGame.update();
			if(inGame.isRetry){
				deathRuler();
			}
			if(inGame.isClear){
				stageNum += 1;
				if(stageNum<5){
					nextStage();
				}else{
					gameClear = true;
					end();
				}
			}
			draw();
			Module.frameCount();
		}
	}
	private function end(){
		var end:Bitmap = new Bitmap(Assets.getBitmapData("assets/title.png"));
		UI.addChild(end);
	}
}