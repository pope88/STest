package game.net.socket
{

    final public class SocketData extends Object
    {
        private var _name:String;
        private var _host:String;
        private var _port:int;
        private var _flag:int;

        public function SocketData(param1:String, param2:String, param3:int, param4:int = 0)
        {
            this._name = param1;
            this._host = param2;
            this._port = param3;
            this._flag = param4;
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function get host() : String
        {
            return this._host;
        }// end function

        public function get port() : int
        {
            return this._port;
        }// end function

        public function get flag() : int
        {
            return this._flag;
        }// end function

        public function equals(param1:SocketData) : Boolean
        {
            return this._name == param1.name && this._host == param1.host && this._port == param1.port;
        }// end function

        public function toString() : String
        {
            return this._name + " .socket://" + this._host + ":" + this._port;
        }// end function

    }
}
