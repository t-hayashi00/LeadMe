package;

class Stage2 implements Stage_{
	public var terrain:Array<Array<String>>;
	public var initActors:Array<Array<String>>;
	public var objectID:Array<Array<Int>>;

	private function dummy():Void{}

	public function new (){
		terrain=[// y ->
			["H","H","H","H","H","H","H","H","H","H"],
			["H","H","H","H","H","F","F","F","F","H"],
			["H","H","H","H","H","F","H","H","F","H"],
			["H","F","F","F","F","F","F","H","F","H"],
			["H","H","H","H","H","F","H","H","F","H"],
			["H","H","H","H","H","F","F","F","F","H"],
			["H","H","H","H","H","H","H","H","H","H"]];
		initActors=[
			["S","S","S","S","S","S","S","S","S","S"],
			["S","S","S","S","S","S","E","S","B","S"],
			["S","S","S","S","S","B","S","S","S","S"],
			["S","E","S","P","S","S","B","S","G","S"],
			["S","S","S","S","S","B","S","S","S","S"],
			["S","S","S","S","S","S","E","S","S","S"],
			["S","S","S","S","S","S","S","S","S","S"]];
		objectID=[
			[0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0]];
	}
}
