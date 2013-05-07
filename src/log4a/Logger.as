package log4a
{

    final public class Logger extends Object
    {
        private static var _appenders:Array;
        private static var _level:Level = Level.ALL;
        private static var _creating:Boolean = false;

        public function Logger()
        {
            if (!Logger._creating)
            {
                throw new Error(this, "Class cannot be instantiated.");
            }
            return;
        }// end function

        public static function setLevel(param1:Level) : void
        {
            Logger._level = param1;
            return;
        }// end function

        public static function addAppender(param1:IAppender) : void
        {
            if (Logger._appenders == null)
            {
                Logger._appenders = new Array();
            }
            Logger._appenders.push(param1);
            return;
        }// end function

        public static function removeAppender() : void
        {
            Logger._appenders.pop();
            return;
        }// end function

        public static function forcedLog(param1:Level, param2:Array) : void
        {
            if (param1.compareTo(Logger._level))
            {
                return;
            }
            Logger.callAppenders(new LoggingData(param1, param2));
            return;
        }// end function

        public static function callAppenders(param1:LoggingData) : void
        {
            var _loc_2:IAppender = null;
            for each (_loc_2 in Logger._appenders)
            {
                
                _loc_2.append(param1);
            }
            return;
        }// end function

        public static function fatal(... args) : void
        {
            Logger.forcedLog(Level.FATAL, args);
            return;
        }// end function

        public static function error(... args) : void
        {
            Logger.forcedLog(Level.ERROR, args);
            return;
        }// end function

        public static function warn(... args) : void
        {
            Logger.forcedLog(Level.WARN, args);
            return;
        }// end function

        public static function info(... args) : void
        {
            Logger.forcedLog(Level.INFO, args);
            return;
        }// end function

        public static function debug(... args) : void
        {
            Logger.forcedLog(Level.DEBUG, args);
            return;
        }// end function

    }
}
