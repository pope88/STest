package com.protobuf
{

    final public class UInt64 extends Binary64
    {

        public function UInt64(param1:uint = 0, param2:uint = 0)
        {
            super(param1, param2);
            return;
        }// end function

        final public function set high(param1:uint) : void
        {
            internalHigh = param1;
            return;
        }// end function

        final public function get high() : uint
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
            if (this.high == 0)
            {
                return low.toString(param1);
            }
            var _loc_2:Array = [];
            var _loc_3:* = new UInt64(low, this.high);
            do
            {
                
                _loc_4 = _loc_3.div(param1);
                _loc_2.push((_loc_4 < 10 ? ("0") : ("a")).charCodeAt() + _loc_4);
            }while (_loc_3.high != 0)
            return _loc_3.low.toString(param1) + String.fromCharCode.apply(String, _loc_2.reverse());
        }// end function

        public static function parseUInt64(param1:String, param2:uint = 0) : UInt64
        {
            var _loc_5:uint = 0;
            var _loc_3:uint = 0;
            if (param2 == 0)
            {
                if (param1.search(/^0x""^0x/) == 0)
                {
                    param2 = 16;
                    _loc_3 = 2;
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
            var _loc_4:* = new UInt64;
            while (_loc_3 < param1.length)
            {
                
                _loc_5 = param1.charCodeAt(_loc_3);
                if (_loc_5 >= "0".charCodeAt() && _loc_5 <= "9".charCodeAt())
                {
                    _loc_5 = _loc_5 - "0".charCodeAt();
                }
                else if (_loc_5 >= "a".charCodeAt() && _loc_5 <= "z".charCodeAt())
                {
                    _loc_5 = _loc_5 - "a".charCodeAt();
                }
                else
                {
                    throw new ArgumentError();
                }
                if (_loc_5 >= param2)
                {
                    throw new ArgumentError();
                }
                _loc_4.mul(param2);
                _loc_4.add(_loc_5);
                _loc_3 = _loc_3 + 1;
            }
            return _loc_4;
        }// end function

    }
}
