package log4a
{

    public class Level extends Object
    {
        private var _value:int;
        private var _name:String;
        public static var ALL:Level = new Level(0, "ALL");
        public static var DEBUG:Level = new Level(1, "DEBUG");
        public static var INFO:Level = new Level(2, "INFO");
        public static var WARN:Level = new Level(3, "WARN");
        public static var ERROR:Level = new Level(4, "ERROR");
        public static var FATAL:Level = new Level(5, "FATAL");
        public static var OFF:Level = new Level(6, "OFF");

        public function Level(param1:int = 1, param2:String = "DEBUG")
        {
            this._value = param1;
            this._name = param2;
            return;
        }// end function

        public function get value() : int
        {
            return this._value;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function compareTo(param1:Level) : Boolean
        {
            return this._value < param1.value;
        }// end function

    }
}
