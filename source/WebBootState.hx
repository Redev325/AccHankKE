package;

#if web
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import openfl.utils.Assets;

class WebBootState extends FlxState
{
    override public function create():Void
    {
        super.create();

        var status = new FlxText(0, FlxG.height / 2 - 20, FlxG.width, "Loading game...", 24);
        status.alignment = CENTER;
        status.color = FlxColor.WHITE;
        add(status);

        Assets.loadLibrary("default").onComplete(function(_)
        {
            FlxG.switchState(new TitleState());
        });
    }
}
#end
