import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
using Toybox.Time;
using Toybox.Time.Gregorian;

var myfont = null;
var lfont = null;
var mfont = null;

class wf1View extends WatchUi.WatchFace {

    function onTimer() {WatchUi.requestUpdate();}
    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        //setLayout(Rez.Layouts.WatchFace(dc));
        myfont = Toybox.WatchUi.loadResource(Rez.Fonts.myfont);
        lfont = Toybox.WatchUi.loadResource(Rez.Fonts.lfont);
        mfont = Toybox.WatchUi.loadResource(Rez.Fonts.mfont);
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {

         dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
         dc.clear();

        var clockTime = System.getClockTime();
        var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]);
        dc.drawText(88, 68, lfont, timeString, Graphics.TEXT_JUSTIFY_CENTER);

        var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        var todayLong = Gregorian.info(Time.now(), Time.FORMAT_LONG);
        var dateString = Lang.format(
        "$1$$2$$3$",
        [
            today.year,
            today.month.format("%02d"),
            today.day.format("%02d"),
        ]
        );
        
        dc.drawText(87, 50, myfont, todayLong.day_of_week.toUpper(), Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(88, 120, mfont, dateString, Graphics.TEXT_JUSTIFY_CENTER);
        var myStats = System.getSystemStats();
        dc.drawText(144, 15, myfont, myStats.battery.format("%02d") + "%", Graphics.TEXT_JUSTIFY_CENTER);
    }

    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

}
