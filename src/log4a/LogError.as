package log4a
{

    public class LogError extends Error
    {

        public function LogError(... args)
        {
            super(LoggingData.toCode(args));
            Logger.forcedLog(Level.ERROR, args);
            return;
        }// end function

    }
}
