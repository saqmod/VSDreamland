import flixel.FlxG;
import openfl.utils.Assets;

class Save
{
    public function new(x)
    {
        save(x);
    }
    public static inline function save(x)
    {
        return FlxG.save.data.x;
    }

    public static inline function bind(one:String, two:String)
    {
        FlxG.save.bind(one, two);
    }

    public static inline function saveInFile(name:String, info:String)
    {
        if(!sys.FileSystem.exists((Sys.getCwd() + 'assets/saves/$name.ini')))      
            sys.io.File.saveContent('assets/saves/$name.ini', info);
    }

    public static inline function loadFile(name:String, library:String)
    {
        Paths.file('saves/$name.ini', TEXT, library);
    }
}