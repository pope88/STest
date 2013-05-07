package game.net.core
{
    import com.protobuf.*;
    
    import flash.utils.*;
    
    import log4a.*;
    
    import utils.*;

    public class RequestData extends Object
    {
        public function RequestData(cmd:int, obj:Object)
        {
            this._msgCmd = cmd;
            this._args = obj;
            return;
        }// end function

        public function get method() : int
        {
            return this._msgCmd;
        }// end function

        public function get args()
        {
            return this._args;
        }// end function

        public function toString() : String
        {
            return "MsgCmd=" + this._msgCmd + "ByteArray=" + String(this._args);
        }// end function

        public function merge(rdata:RequestData) : Boolean
        {
            if (rdata.method != this._msgCmd)
            {
                return false;
            }
            return true;
        }// end function

        public function parse() : void
        {
            var _class:Message;
            var value:* = this._args as ByteArray;
            if (!value)
            {
                return;
            }
            this._msgCmd = value.readUnsignedShort();
            if (this._msgCmd != 32)
            {
                Logger.debug("接收到==>msgCmd=0x" + this._msgCmd.toString(16));
            }
            try
            {
                _class = new ClassUtil.getClass(Common.messageDic[this._msgCmd]) as Message;
            }
            catch (e:Error)
            {
                Logger.error("Request::parse解析消息出错！可能此消息无人监听   0x" + _msgCmd.toString(16));
            }
            if (!_class)
            {
                return;
            }
            _class.readFromSlice(value, 1);
            value.clear();
            this._args = _class;
            return;
        }// end function
		
		private var _msgCmd:int;
		private var _args:Object;

    }
}
