package com.protobuf
{

    final public class Int64 extends Binary64
    {

        public function Int64(param1:uint = 0, param2:int = 0)
        {
            super(param1, param2);
            return;
        }// end function

        final public function set high(param1:int) : void
        {
            internalHigh = param1;
            return;
        }// end function

        final public function get high() : int
        {
            return internalHigh;
        }// end function

        public function toString(param1:uint = 10) : String
        {
            var _loc_4:uint = 0;
            if (param1 < 2 || param1 > 36)
            {
                throw new ArgumentError();
            }
            switch(this.high)
            {
                case 0:
                {
                    return low.toString(param1);
                }
                case -1:
                {
                    return int(low).toString(param1);
                }
                default:
                {
                    break;
                    break;
                }
            }
            if (low == 0 && this.high == 0)
            {
                return "0";
            }
            var _loc_2:Array = [];
            var _loc_3:* = new UInt64(low, this.high);
            if (this.high < 0)
            {
                _loc_3.bitwiseNot();
                _loc_3.add(1);
            }
            do
            {
                
                _loc_4 = _loc_3.div(param1);
                _loc_2.push((_loc_4 < 10 ? ("0") : ("a")).charCodeAt() + _loc_4);
            }while (_loc_3.high != 0)
            if (this.high < 0)
            {
                return "-" + _loc_3.low.toString(param1) + String.fromCharCode.apply(String, _loc_2.reverse());
            }
            return _loc_3.low.toString(param1) + String.fromCharCode.apply(String, _loc_2.reverse());
        }// end function

        public static function parseInt64(param1:String, param2:uint = 0) : Int64
        {
            var _loc_6:uint = 0;
            var _loc_3:* = param1.search(/^\-""^\-/) == 0;
            var _loc_4:* = _loc_3 ? (1) : (0);
            if (param2 == 0)
            {
                if (param1.search(/^\-?0x""^\-?0x/) == 0)
                {
                    param2 = 16;
                    _loc_4 = _loc_4 + 2;
                }
                else
                {
                    param2 = 10;
                }
            }
            if (param2 < 2 || param2 > 36)
            {
                throw new ArgumentError();
            }
            param1 = param1.toLowerCase();
            var _loc_5:* = new Int64;
            while (_loc_4 < param1.length)
            {
                
                _loc_6 = param1.charCodeAt(_loc_4);
                if (_loc_6 >= "0".charCodeAt() && _loc_6 <= "9".charCodeAt())
                {
                    _loc_6 = _loc_6 - "0".charCodeAt();
                }
                else if (_loc_6 >= "a".charCodeAt() && _loc_6 <= "z".charCodeAt())
                {
                    _loc_6 = _loc_6 - "a".charCodeAt();
                }
                else
                {
                    throw new ArgumentError();
                }
                if (_loc_6 >= param2)
                {
                    throw new ArgumentError();
                }
                _loc_5.mul(param2);
                _loc_5.add(_loc_6);
                _loc_4 = _loc_4 + 1;
            }
            if (_loc_3)
            {
                _loc_5.bitwiseNot();
                _loc_5.add(1);
            }
            return _loc_5;
        }// end function

    }
}
