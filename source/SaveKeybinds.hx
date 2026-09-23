package;

import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import openfl.Assets;

class SaveKeybinds extends MusicBeatState
{
    var holdTimer:Float = 0;
    var loadingShared:Bool = false;

    override function create()
    {
        var warning:FlxText = new FlxText(0, 0, FlxG.width, 'Make sure to edit your keybinds. Press ENTER to continue.', 42);
        warning.setFormat(Paths.font("vcr.ttf"), 42, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
        warning.screenCenter();
        add(warning);
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.ENTER && !loadingShared)
        {
            loadingShared = true;

            var loadingText:FlxText = new FlxText(
                0,
                FlxG.height - 80,
                FlxG.width,
                'Loading game assets...',
                28
            );
            loadingText.setFormat(
                Paths.font("vcr.ttf"),
                28,
                FlxColor.WHITE,
                CENTER,
                FlxTextBorderStyle.OUTLINE,
                FlxColor.BLACK
            );
            add(loadingText);

            Assets.loadLibrary("shared")
                .onComplete(function(_)
                {
                    FlxG.switchState(new MainMenuState());
                })
                .onError(function(error)
                {
                    loadingShared = false;
                    loadingText.text = 'Failed to load game assets. Check the browser console.';
                    trace(error);
                });
        }
    }
}