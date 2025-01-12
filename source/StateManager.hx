package;

import sys.FileSystem;

class StateManager
{
    // returns true for oncreate bs.
    public static function check(name:String):Bool
    {
        WeekData.loadTheFirstEnabledMod();
        if (FileSystem.exists(Paths.getModFile("states/" + name + ".hxs")))
        {
            MusicBeatState.switchState(new CustomState(Paths.getModFile("states/" + name + ".hxs")));
            return true;
        }

        return false;
    }
}