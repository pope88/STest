package log4a
{

    public interface ILogFormatter
    {

        public function ILogFormatter();

        function format(param1:LoggingData, param2:String = "\n") : String;

        function getColor(param1:String) : uint;

    }
}
