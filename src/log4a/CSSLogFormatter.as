package log4a
{
    import log4a.*;

    public class CSSLogFormatter extends Object implements ILogFormatter
    {
        public static const cssText:String = ".debug{color:#33FF00}.info{color:#EFEFEF}.warn{color:#00CCFF}.error{color:#FF9900}.fatal{color:#FF66FF}";

        public function CSSLogFormatter()
        {
            return;
        }// end function

        public function format(param1:LoggingData, param2:String = "\n") : String
        {
            var _loc_3:* = "<p class=\'" + param1.level.name.toLowerCase() + "\'>[" + param1.level.name + "]";
            _loc_3 = _loc_3 + (param1.toString() + "</p>");
            return _loc_3;
        }// end function

        public function getColor(param1:String) : uint
        {
            return 0;
        }// end function

    }
}
