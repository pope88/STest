package com.protobuf
{
    import __AS3__.vec.*;
    import flash.errors.*;
    import flash.utils.*;

    final public class WritingBuffer extends ByteArray
    {
        private const slices:Vector.<uint>;

        public function WritingBuffer()
        {
            this.slices = new Vector.<uint>;
            endian = Endian.LITTLE_ENDIAN;
            return;
        }// end function

        public function beginBlock() : uint
        {
            this.slices.push(position);
            var _loc_1:* = this.slices.length;
            this.slices.length = this.slices.length + 2;
            this.slices.push(position);
            return _loc_1;
        }// end function

        public function endBlock(param1:uint) : void
        {
            this.slices.push(position);
            var _loc_2:* = this.slices[param1 + 2];
            this.slices[param1] = position;
            WriteUtils.write$TYPE_UINT32(this, position - _loc_2);
            this.slices[(param1 + 1)] = position;
            this.slices.push(position);
            return;
        }// end function

        public function toNormal(param1:IDataOutput) : void
        {
            var _loc_4:uint = 0;
            var _loc_2:uint = 0;
            var _loc_3:uint = 0;
            while (_loc_2 < this.slices.length)
            {
                
                _loc_4 = this.slices[_loc_2];
                _loc_2 = _loc_2 + 1;
                if (_loc_4 > _loc_3)
                {
                    param1.writeBytes(this, _loc_3, _loc_4 - _loc_3);
                }
                else if (_loc_4 < _loc_3)
                {
                    throw new IllegalOperationError();
                }
                _loc_3 = this.slices[_loc_2];
                _loc_2 = _loc_2 + 1;
            }
            param1.writeBytes(this, _loc_3);
            return;
        }// end function

    }
}
