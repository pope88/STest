package log4a
{
    import flash.utils.*;

    final public class LoggingData extends Object
    {
        private var _level:Level;
        private var _message:Array;
        private var _timeStamp:String;
        private var _code:String;

        public function LoggingData(param1:Level, param2:Array)
        {
            this._level = param1;
            this._message = param2;
            this._timeStamp = null;
            return;
        }// end function

        public function get level() : Level
        {
            return this._level;
        }// end function

        public function get message() : Array
        {
            return this._message;
        }// end function

        public function toString() : String
        {
            if (!this._code)
            {
                this._code = LoggingData.toCode(this._message);
            }
            return this._code;
        }// end function

        private static function escapeString(param1:String) : String
        {
            return "\"" + param1 + "\"";
        }// end function

        private static function arrayToString(param1:Array) : String
        {
            var _loc_2:String = "";
            var _loc_3:* = param1.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                if (_loc_2.length > 0)
                {
                    _loc_2 = _loc_2 + ",";
                }
                _loc_2 = _loc_2 + LoggingData.encode(param1[_loc_4]);
                _loc_4++;
            }
            return "[" + _loc_2 + "]";
        }// end function

        private static function objectToString(param1:Object) : String
        {
            var _loc_5:Object = null;
            var _loc_6:String = null;
            var _loc_2:String = "";
            var _loc_3:* = describeType(param1);
            var _loc_4:* = String(_loc_3.@name).replace(/::""::/, ".");
            if (String(_loc_3.@name).replace(/::""::/, ".") == "Object")
            {
                for (_loc_6 in param1)
                {
                    
                    _loc_5 = param1[_loc_6];
                    if (_loc_5 is Function)
                    {
                        continue;
                    }
                    if (_loc_2.length > 0)
                    {
                        _loc_2 = _loc_2 + ",";
                    }
                    _loc_2 = _loc_2 + (_loc_6 + ":" + LoggingData.encode(_loc_5));
                }
            }
            else
            {
                return "[" + _loc_4 + "]";
            }
            return "{" + _loc_2 + "}";
        }// end function

        private static function encode(param1) : String
        {
            if (param1 is String)
            {
                return LoggingData.escapeString(param1 as String);
            }
            if (param1 is Number)
            {
                return isFinite(param1 as Number) ? (param1) : ("null");
            }
            else if (param1 is Boolean)
            {
                return param1 ? ("true") : ("false");
            }
            else
            {
                if (param1 is Array)
                {
                    return LoggingData.arrayToString(param1 as Array);
                }
                if (param1 is Object && param1 != null)
                {
                    return LoggingData.objectToString(param1);
                }
            }
            return "null";
        }// end function

        public static function toCode(param1:Array) : String
        {
            var _loc_3:* = undefined;
            var _loc_2:String = "null";
            if (param1 != null)
            {
                _loc_2 = "";
                for each (_loc_3 in param1)
                {
                    
                    if (_loc_2.length > 0)
                    {
                        _loc_2 = _loc_2 + " ";
                    }
                    _loc_2 = _loc_2 + LoggingData.encode(_loc_3);
                }
            }
            return _loc_2;
        }// end function

    }
}
