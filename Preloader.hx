package ;
 
import flixel.system.FlxBasePreloader;
import openfl.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.BlendMode;
import flash.display.Sprite;
import flash.Lib;
import flixel.FlxG;
 
@:bitmap("art/preloaderArt.png") class LogoImage extends BitmapData { }
 
class Preloader extends FlxBasePreloader
{
    public function new(MinDisplayTime:Float=3, ?AllowedURLs:Array<String>) 
    {
        super(MinDisplayTime, AllowedURLs);
    }
     
    var logo:Sprite;
    var logoScale:Float = 1.0;
     
    override function create():Void 
    {
        this._width = Lib.current.stage.stageWidth;
        this._height = Lib.current.stage.stageHeight;
         
        var bitmap = new Bitmap(new LogoImage(0,0));
        logo = new Sprite();
        logo.addChild(bitmap);

        // Keep the preloader artwork centered and fully visible on HTML5.
        // The old code enlarged it to width / 1280 at the end of loading,
        // which made the 2560px artwork overflow the browser.
        logoScale = this._width / 2560;
        if (this._height / bitmap.height < logoScale)
            logoScale = this._height / bitmap.height;
        logoScale = Math.min(logoScale, 1.0);
         
        logo.scaleX = logo.scaleY = logoScale;
        logo.x = (this._width - logo.width) / 2;
        logo.y = (this._height - logo.height) / 2;
        addChild(logo);
         
        super.create();
    }
     
    override function update(Percent:Float):Void 
    {
        // Do not animate the artwork based on loading percentage.
        // This prevents the HTML5 preloader from growing/cropping at the
        // 60-80% range while assets are still being fetched.
        logo.scaleX = logo.scaleY = logoScale;
        logo.x = (this._width - logo.width) / 2;
        logo.y = (this._height - logo.height) / 2;
         
        super.update(Percent);
    }
}
