package field;

import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.geom.Point;

class Field{
	public var container:Sprite=new Sprite();
	public var stage:Stage_;
	public var showX:Float;
	public var showY:Float;

	var fileName:String = "mapChip.png";

	public function new (fileName:String,stage:Stage_){
		var mapchip:MapChip;

		this.fileName = fileName;
		this.stage = stage;

		for(y in 0...stage.terrain[0].length){
			for(x in 0...stage.terrain.length){
				switch(stage.terrain[x][y]){
				case "H":
					mapchip = new MapChip(fileName,0,0);
					container.addChild(mapchip.image);
				case "F":
					if((x+y)%2 == 1)
						mapchip = new MapChip(fileName,0,11);
					else
						mapchip = new MapChip(fileName,4,1);
					container.addChild(mapchip.image);
				default:
					mapchip = new MapChip(fileName,2,2);
					container.addChild(mapchip.image);
				}
//				mapchip.image.x = 32*x;
//				mapchip.image.y = 32*y;
				mapchip.image.x = 16*(x-y)-16;
				mapchip.image.y = 8*(x+y);
				mapchip.image.smoothing = false;
			}
		}
	}
	
	public function update(){		
	}
	
	public function searchActor(search:String):Point{
		var p:Point = new Point(-1,-1);
		for(y in 0...stage.initActors[0].length){
			for(x in 0...stage.initActors.length){
				if(stage.initActors[x][y]==search){
					p = new Point(x,y);
				}
			}
		}
		return p;
	}
	
	public function getTerrainID(grid:Point):String{
		return (stage.terrain[Math.floor(grid.x)][Math.floor(grid.y)]);
	}

	public function getObjectID(grid:Point):Int{
		return (stage.objectID[Math.floor(grid.x)][Math.floor(grid.y)]);
	}
}