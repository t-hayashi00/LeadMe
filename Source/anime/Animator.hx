package anime;

import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.geom.Rectangle;
import openfl.geom.Point;
import openfl.Assets;

class Animator{
	private var container:Sprite = new Sprite();	
	private var animeList:List<Animation> = new List();
	
	public function new (masterContainer:Sprite){
		masterContainer.addChild(container);
	}
	
	//Factoryから生成されたアニメがパラメータ
	public function addAnimation(animeNum:String):Void{
		var animation:Animation = Factory.getAnimation(animeNum);
		animeList.add(animation);
		container.addChild(animation.container);
	}
	
	public function draw():Void{
		var It:Iterator<Animation> = animeList.iterator();
		while(It.hasNext()){
			var animation:Animation = It.next();
			if(animation.isEnd()){
				animeList.remove(animation);
				container.removeChild(animation.container);
			}
			animation.draw();
		}
	}
	public function removeAll():Void{
		var It:Iterator<Animation> = animeList.iterator();
		while(It.hasNext()){
			var animation:Animation = It.next();
			animeList.remove(animation);
			container.removeChild(animation.container);
		}	
	}
}