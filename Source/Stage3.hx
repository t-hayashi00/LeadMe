package;

class Stage3 implements Stage_{
	public var terrain:Array<Array<String>>;
	public var initActors:Array<Array<String>>;
	public var objectID:Array<Array<Int>>;
	private function dummy():Void{}

	public function new (){
		terrain=[// y ->
			["H","H","H","H","H","H","H","H","H"],
			["H","F","F","F","H","F","F","F","H"],
			["H","F","H","F","H","F","H","F","H"],//x
			["H","F","F","F","F","F","F","F","H"],//|
			["H","H","H","F","H","F","H","H","H"],//v
			["H","F","F","F","F","F","F","F","H"],
			["H","F","H","F","H","F","H","F","H"],
			["H","F","F","F","F","F","F","F","H"],
			["H","H","H","H","H","H","H","H","H"]];
		initActors=[
			["S","S","S","S","S","S","S","S","S"],
			["S","P","S","B","S","S","E","G","S"],
			["S","S","S","S","S","S","S","S","S"],
			["S","S","S","W","B","S","S","B","S"],
			["S","S","S","S","S","S","S","S","S"],
			["S","S","S","S","B","S","B","E","S"],
			["S","S","S","B","S","S","S","S","S"],
			["S","W","S","S","B","S","B","S","S"],
			["S","S","S","S","S","S","S","S","S"]];
		objectID=[
			[0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0]];
	}
}
