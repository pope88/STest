package game.net.socket
{
    import com.protobuf.*;
    import flash.utils.*;
    import game.net.core.*;
    import gameui.manager.*;
    import log4a.*;

    final public class SocketParser extends Object
    {

        public function SocketParser()
        {
            return;
        }// end function

        public function readObject(param1:int) : void
        {
            switch(param1)
            {
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public static function writeObject(param1:ByteArray, param2:uint, param3:Object) : void
        {
            if (!param1)
            {
                return;
            }
            var _loc_4:* = getStyle(param3);
            param1.writeShort(param2);
            switch(_loc_4)
            {
                case 1:
                {
                    try
                    {
                        if (Message(param3))
                        {
                            Message(param3).writeTo(param1);
                            ;
                        }
                        break;
                    }
                    catch (e:Error)
                    {
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public static function parse(param1:ByteArray) : RequestData
        {
            var msgCmd:uint;
            var _class:Message;
            var value:* = param1;
            if (value == null)
            {
                return null;
            }
            msgCmd = value.readUnsignedShort();
            if (msgCmd != 32)
            {
                Logger.debug("接收到==>msgCmd=0x" + msgCmd.toString(16));
            }
            try
            {
                _class = new (StaticVar.appDomain.getDefinition(Common.messageDic[msgCmd]) as Class)() as Message;
            }
            catch (e:Error)
            {
                Logger.error("Request::parse解析消息出错！0x" + msgCmd.toString(16));
            }
            if (!_class)
            {
                return null;
            }
            _class.readFromSlice(value, 1);
            return new RequestData(msgCmd, _class);
        }// end function

        private static function getStyle(param1:Object) : int
        {
            if (param1 == null)
            {
                return 0;
            }
            if (param1 is Message)
            {
                return 1;
            }
            if (param1 is int)
            {
                return 2;
            }
            if (param1 is String)
            {
                return 3;
            }
            return 0;
        }// end function

    }
}
