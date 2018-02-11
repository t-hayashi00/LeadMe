package;


import lime.app.Config;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {
	
	
	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	
	
	public static function init (config:Config):Void {
		
		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();
		
		var rootPath = null;
		
		if (config != null && Reflect.hasField (config, "rootPath")) {
			
			rootPath = Reflect.field (config, "rootPath");
			
		}
		
		if (rootPath == null) {
			
			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif (windows && !cs)
			rootPath = FileSystem.absolutePath (haxe.io.Path.directory (#if (haxe_ver >= 3.3) Sys.programPath () #else Sys.executablePath () #end)) + "/";
			#else
			rootPath = "";
			#end
			
		}
		
		Assets.defaultRootPath = rootPath;
		
		#if (openfl && !flash && !display)
		
		#end
		
		var data, manifest, library;
		
		data = '{"name":null,"assets":"aoy4:pathy22:assets%2Fa_emotion.pngy4:sizei923y4:typey5:IMAGEy2:idR1y7:preloadtgoR0y20:assets%2Fa_slash.pngR2i1092R3R4R5R7R6tgoR0y49:assets%2Fbandicam%202018-01-14%2004-47-16-215.pngR2i41857R3R4R5R8R6tgoR0y21:assets%2Fc_cursor.pngR2i1102R3R4R5R9R6tgoR0y19:assets%2Fc_hero.pngR2i18388R3R4R5R10R6tgoR0y21:assets%2Fc_marika.pngR2i16444R3R4R5R11R6tgoR0y20:assets%2Fc_slime.pngR2i5912R3R4R5R12R6tgoR0y23:assets%2Fc_treasure.pngR2i13491R3R4R5R13R6tgoR0y16:assets%2Fend.pngR2i2246R3R4R5R14R6tgoR0y20:assets%2FmapChip.pngR2i23885R3R4R5R15R6tgoR0y21:assets%2Fpanorama.pngR2i12347R3R4R5R16R6tgoR0y18:assets%2Ftitle.pngR2i44701R3R4R5R17R6tgoR0y20:assets%2Fu_other.pngR2i882R3R4R5R18R6tgoR0y22:assets%2Fu_pointer.pngR2i1102R3R4R5R19R6tgoR0y21:assets%2Fu_window.pngR2i959R3R4R5R20R6tgh","version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		
		
		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		
		
	}
	
	
}


#if !display
#if flash

@:keep @:bind #if display private #end class __ASSET__assets_a_emotion_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_a_slash_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_bandicam_2018_01_14_04_47_16_215_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_c_cursor_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_c_hero_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_c_marika_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_c_slime_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_c_treasure_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_end_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_mapchip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_panorama_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_title_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_u_other_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_u_pointer_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_u_window_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:image("Assets/a_emotion.png") #if display private #end class __ASSET__assets_a_emotion_png extends lime.graphics.Image {}
@:image("Assets/a_slash.png") #if display private #end class __ASSET__assets_a_slash_png extends lime.graphics.Image {}
@:image("Assets/bandicam 2018-01-14 04-47-16-215.png") #if display private #end class __ASSET__assets_bandicam_2018_01_14_04_47_16_215_png extends lime.graphics.Image {}
@:image("Assets/c_cursor.png") #if display private #end class __ASSET__assets_c_cursor_png extends lime.graphics.Image {}
@:image("Assets/c_hero.png") #if display private #end class __ASSET__assets_c_hero_png extends lime.graphics.Image {}
@:image("Assets/c_marika.png") #if display private #end class __ASSET__assets_c_marika_png extends lime.graphics.Image {}
@:image("Assets/c_slime.png") #if display private #end class __ASSET__assets_c_slime_png extends lime.graphics.Image {}
@:image("Assets/c_treasure.png") #if display private #end class __ASSET__assets_c_treasure_png extends lime.graphics.Image {}
@:image("Assets/end.png") #if display private #end class __ASSET__assets_end_png extends lime.graphics.Image {}
@:image("Assets/mapChip.png") #if display private #end class __ASSET__assets_mapchip_png extends lime.graphics.Image {}
@:image("Assets/panorama.png") #if display private #end class __ASSET__assets_panorama_png extends lime.graphics.Image {}
@:image("Assets/title.png") #if display private #end class __ASSET__assets_title_png extends lime.graphics.Image {}
@:image("Assets/u_other.png") #if display private #end class __ASSET__assets_u_other_png extends lime.graphics.Image {}
@:image("Assets/u_pointer.png") #if display private #end class __ASSET__assets_u_pointer_png extends lime.graphics.Image {}
@:image("Assets/u_window.png") #if display private #end class __ASSET__assets_u_window_png extends lime.graphics.Image {}
@:file("") #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else



#end

#if (openfl && !flash)



#end
#end