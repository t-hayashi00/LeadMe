package field;
import openfl.display.DisplayObject;

class FieldCamera{
	private var container:DisplayObject;
	private var field:Field;
	private var scale:Float;
	
	public function new (container:DisplayObject,field:Field,scale:Float){
		this.container = container;
		this.field = field;
		this.scale = scale;
	}

	public function setContainer(container:DisplayObject){
		this.container = container;
	}
		
	public function setScale(scale:Float){
		if(scale < 0)scale = 0;
		this.scale = scale;
	}

	public function getScale():Float{
		return scale;
	}
	
	private function inRange(value:Float,minimum:Float,maximum:Float):Bool{
		return (maximum > value && value > minimum);
	}
	
	private function scrollManipulate():Bool{
		var isScrolledX:Bool = true;
		var tmp:Float = field.showX+(container.x+16)-(225);

		if(!inRange(tmp,-0.5,0.5)){
			field.showX -= tmp*0.05*scale;
			field.container.x -= tmp*0.05*scale*scale;
			isScrolledX = false;
		}else{
			field.showX = (225-(container.x+16));
			field.container.x = 225-(container.x+16)*scale;
		}

		var isScrolledY:Bool = true;
		var tmp:Float = field.showY+(container.y-16)-200;

		if(!inRange(tmp,-0.5,0.5)){
			field.showY -= tmp*0.05*scale;
			field.container.y -= tmp*0.05*scale*scale;
			isScrolledY = false;
		}else{
			field.showY = (200-(container.y-16));
			field.container.y = 200-(container.y-16)*scale;
		}
		return isScrolledX && isScrolledY;
	}
	
	private function scaleManipulate():Bool{
		var isScaled:Bool = true;
		var tmp:Float = field.container.scaleX-scale;
		if(!inRange(tmp,-0.005,0.005)){
			field.container.scaleX -= tmp*0.1;
			field.container.scaleY -= tmp*0.1;
			isScaled = false;
		}else{
			field.container.scaleX = scale;
			field.container.scaleY = scale;
		}
		return isScaled;
	}
	
	public function scaleAdjust():Void{
		field.container.scaleX = scale;
		field.container.scaleY = scale;
	}
	public function scrollAdjust():Void{
		field.showX = (225-(container.x+16));
		field.container.x = 225-(container.x+16)*scale;
		field.showY = (200-(container.y-16));
		field.container.y = 200-(container.y-16)*scale;
	}
	public function update(){
		scaleManipulate();
		scrollManipulate();
	}
	
}

