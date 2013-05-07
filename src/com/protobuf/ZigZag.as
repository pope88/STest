package com.protobuf
{

    final public class ZigZag extends Object
    {

        public function ZigZag()
        {
            return;
        }// end function

        public static function encode32(param1:int) : int
        {
            return param1 << 1 ^ param1 >> 31;
        }// end function

        public static function decode32(param1:int) : int
        {
            return param1 >>> 1 ^ -(param1 & 1);
        }// end function

        public static function encode64low(param1:uint, param2:int) : uint
        {
            return param1 << 1 ^ param2 >> 31;
        }// end function

        public static function encode64high(param1:uint, param2:int) : int
        {
            return param1 >>> 31 ^ param2 << 1 ^ param2 >> 31;
        }// end function

        public static function decode64low(param1:uint, param2:int) : uint
        {
            return param2 << 31 ^ param1 >>> 1 ^ -(param1 & 1);
        }// end function

        public static function decode64high(param1:uint, param2:int) : int
        {
            return param2 >>> 1 ^ -(param1 & 1);
        }// end function

    }
}
