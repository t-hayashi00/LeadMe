package anime;

//アニメーションを生成します。生成したら各オブジェクトが持つアニメーターに渡して動かしてもらいます。

//改良の余地としてはインスタンス生成時のオーバーヘッドを軽減するためにアニメのインスタンスをあらかじめ生成しておくなどがあるだろう。
class Factory{
	static public function getAnimation(animationName:String):Animation{
		switch (animationName){
		case "surprised":
			return new Surprised();
		case "slash_l":
			return new Slash(0);
		case "slash_r":
			return new Slash(1);
		default:
		//ここに生成するアニメーションを追加していく
			return new TestAnime();
		}
	}
}