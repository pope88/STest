package game.net.core
{
    import flash.events.*;
    import flash.utils.*;
 //   import game.net.data.CtoS.*;
    import game.net.socket.*;
  //  import gamedata.*;
    import log4a.*;
   // import ui.*;

    final public class Common extends Object
    {
       // private var _load_lm:CommonLoading;
        public static var game_server:SocketClient = new SocketClient();
        public static var messageDic:Dictionary = new Dictionary(true);
        private static var _instance:Common;
        public static var open:Boolean = false;

        public function Common() : void
        {
            return;
        }// end function

//        public function get loadPanel() : CommonLoading
//        {
//            if (this._load_lm == null)
//            {
//                this._load_lm = new CommonLoading();
//            }
//            return this._load_lm;
//        }// end function

        public function init(param1:String, param2:String, param3:String) : void
        {
            this.initConfing();
            this.initSocketData(param1, param2, param3);
            return;
        }// end function

        public function initConfing() : void
        {
           // ProtoConfig.initConfing();
            return;
        }// end function

        private function initSocketData(param1:String, param2:String, param3:String) : void
        {
//            var _servers:Array;
//            var str:* = param1;
//            var id:* = param2;
//            var key:* = param3;
//           GASignals.gaConnectServer.dispatch();
//            var _arr:* = str.split("|");
//            var i:int;
//            while (i < _arr.length)
//            {
//                
//                _servers = String(_arr[i]).split(":");
//                game_server.connect(new SocketData(i.toString(), _servers[0], Number(_servers[1])));
//                i = (i + 1);
//            }
//            game_server.addEventListener(Event.CONNECT, function (event:Event) : void
//            {
//                GASignals.gaServerConnected.dispatch();
//                var _loc_2:* = new CSUserLogin();
//                _loc_2.id = id;
//                _loc_2.key = key;
//                if (Config.getNumber(Config.ANTI_ADDICTION) != -1)
//                {
//                    _loc_2.wallow = Config.getNumber(Config.ANTI_ADDICTION);
//                }
//                game_server.sendMessage(2, _loc_2);
//                Logger.debug("sendMessage===>" + 2);
//                return;
//            }// end function
            );
            return;
        }// end function

        public static function getInstance() : Common
        {
            if (_instance == null)
            {
                _instance = new Common;
            }
            return _instance as Common;
        }// end function

    }
}
