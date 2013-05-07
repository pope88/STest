package com.protobuf
{
    import flash.utils.*;

    final public class WriteUtils extends Object
    {

        public function WriteUtils()
        {
            return;
        }// end function

        private static function writeVarint64(param1:WritingBuffer, param2:uint, param3:uint) : void
        {
            var _loc_4:uint = 0;
            if (param3 == 0)
            {
                write$TYPE_UINT32(param1, param2);
            }
            else
            {
                _loc_4 = 0;
                while (_loc_4 < 4)
                {
                    
                    param1.writeByte(param2 & 127 | 128);
                    param2 = param2 >>> 7;
                    _loc_4 = _loc_4 + 1;
                }
                if ((param3 & 268435455 << 3) == 0)
                {
                    param1.writeByte(param3 << 4 | param2);
                }
                else
                {
                    param1.writeByte((param3 << 4 | param2) & 127 | 128);
                    write$TYPE_UINT32(param1, param3 >>> 3);
                }
            }
            return;
        }// end function

        public static function writeTag(param1:WritingBuffer, param2:uint, param3:uint) : void
        {
            write$TYPE_UINT32(param1, param3 << 3 | param2);
            return;
        }// end function

        public static function write$TYPE_DOUBLE(param1:WritingBuffer, param2:Number) : void
        {
            param1.writeDouble(param2);
            return;
        }// end function

        public static function write$TYPE_FLOAT(param1:WritingBuffer, param2:Number) : void
        {
            param1.writeFloat(param2);
            return;
        }// end function

        public static function write$TYPE_INT64(param1:WritingBuffer, param2:Int64) : void
        {
            writeVarint64(param1, param2.low, param2.high);
            return;
        }// end function

        public static function write$TYPE_UINT64(param1:WritingBuffer, param2:UInt64) : void
        {
            writeVarint64(param1, param2.low, param2.high);
            return;
        }// end function

        public static function write$TYPE_INT32(param1:WritingBuffer, param2:int) : void
        {
            if (param2 < 0)
            {
                writeVarint64(param1, param2, 4294967295);
            }
            else
            {
                write$TYPE_UINT32(param1, param2);
            }
            return;
        }// end function

        public static function write$TYPE_FIXED64(param1:WritingBuffer, param2:UInt64) : void
        {
            param1.writeUnsignedInt(param2.low);
            param1.writeUnsignedInt(param2.high);
            return;
        }// end function

        public static function write$TYPE_FIXED32(param1:WritingBuffer, param2:uint) : void
        {
            param1.writeUnsignedInt(param2);
            return;
        }// end function

        public static function write$TYPE_BOOL(param1:WritingBuffer, param2:Boolean) : void
        {
            param1.writeByte(param2 ? (1) : (0));
            return;
        }// end function

        public static function write$TYPE_STRING(param1:WritingBuffer, param2:String) : void
        {
            var _loc_3:* = param1.beginBlock();
            param1.writeUTFBytes(param2);
            param1.endBlock(_loc_3);
            return;
        }// end function

        public static function write$TYPE_BYTES(param1:WritingBuffer, param2:ByteArray) : void
        {
            write$TYPE_UINT32(param1, param2.length);
            param1.writeBytes(param2);
            return;
        }// end function

        public static function write$TYPE_UINT32(param1:WritingBuffer, param2:uint) : void
        {
            while (true)
            {
                
                if ((param2 & ~127) == 0)
                {
                    param1.writeByte(param2);
                    return;
                }
                param1.writeByte(param2 & 127 | 128);
                param2 = param2 >>> 7;
            }
            return;
        }// end function

        public static function write$TYPE_ENUM(param1:WritingBuffer, param2:int) : void
        {
            write$TYPE_INT32(param1, param2);
            return;
        }// end function

        public static function write$TYPE_SFIXED32(param1:WritingBuffer, param2:int) : void
        {
            param1.writeInt(param2);
            return;
        }// end function

        public static function write$TYPE_SFIXED64(param1:WritingBuffer, param2:Int64) : void
        {
            param1.writeUnsignedInt(param2.low);
            param1.writeInt(param2.high);
            return;
        }// end function

        public static function write$TYPE_SINT32(param1:WritingBuffer, param2:int) : void
        {
            write$TYPE_UINT32(param1, ZigZag.encode32(param2));
            return;
        }// end function

        public static function write$TYPE_SINT64(param1:WritingBuffer, param2:Int64) : void
        {
            writeVarint64(param1, ZigZag.encode64low(param2.low, param2.high), ZigZag.encode64high(param2.low, param2.high));
            return;
        }// end function

        public static function write$TYPE_MESSAGE(param1:WritingBuffer, param2:Message) : void
        {
            var _loc_3:* = param1.beginBlock();
            param2.writeToBuffer(param1);
            param1.endBlock(_loc_3);
            return;
        }// end function

        public static function writePackedRepeated(param1:WritingBuffer, param2:Function, param3) : void
        {
            var _loc_4:* = param1.beginBlock();
            var _loc_5:uint = 0;
            while (_loc_5 < param3.length)
            {
                
                WriteUtils.param2(param1, param3[_loc_5]);
                _loc_5 = _loc_5 + 1;
            }
            param1.endBlock(_loc_4);
            return;
        }// end function

    }
}
