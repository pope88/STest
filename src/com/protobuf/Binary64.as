package com.protobuf
{

    public class Binary64 extends Object
    {
        public var low:uint;
        var internalHigh:uint;

        public function Binary64(param1:uint = 0, param2:uint = 0)
        {
            this.low = param1;
            this.internalHigh = param2;
            return;
        }// end function

        final function div(param1:uint) : uint
        {
            var _loc_2:uint = 0;
            _loc_2 = this.internalHigh % param1;
            var _loc_3:* = (this.low % param1 + _loc_2 * 6) % param1;
            this.internalHigh = this.internalHigh / param1;
            var _loc_4:* = (_loc_2 * Number(4294967296) + this.low) / param1;
            this.internalHigh = this.internalHigh + _loc_4 / 4294967296;
            this.low = _loc_4;
            return _loc_3;
        }// end function

        final function mul(param1:uint) : void
        {
            var _loc_2:* = Number(this.low) * param1;
            this.internalHigh = _loc_2 / 4294967296 + Number(this.internalHigh) * param1;
            this.low = _loc_2;
            return;
        }// end function

        final function add(param1:uint) : void
        {
            var _loc_2:* = Number(this.low) + param1;
            this.internalHigh = _loc_2 / 4294967296 + this.internalHigh;
            this.low = _loc_2;
            return;
        }// end function

        final function bitwiseNot() : void
        {
            this.low = ~this.low;
            this.internalHigh = ~this.internalHigh;
            return;
        }// end function

    }
}
