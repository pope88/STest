package com.protobuf
{
    import flash.errors.*;
    import flash.utils.*;

    final public class ReadUtils extends Object
    {

        public function ReadUtils()
        {
            return;
        }// end function

        public static function skip(param1:IDataInput, param2:uint) : void
        {
            var _loc_3:uint = 0;
            switch(param2)
            {
                case WireType.VARINT:
                {
                    while (param1.readUnsignedByte() > 128)
                    {
                        
                    }
                    break;
                }
                case WireType.FIXED_64_BIT:
                {
                    param1.readInt();
                    param1.readInt();
                    break;
                }
                case WireType.LENGTH_DELIMITED:
                {
                    _loc_3 = read$TYPE_UINT32(param1);
                    while (_loc_3 != 0)
                    {
                        
                        param1.readByte();
                        _loc_3 = _loc_3 - 1;
                    }
                    break;
                }
                case WireType.FIXED_32_BIT:
                {
                    param1.readInt();
                    break;
                }
                default:
                {
                    throw new IOError("Invalid wire type: " + param2);
                    break;
                }
            }
            return;
        }// end function

        public static function read$TYPE_DOUBLE(param1:IDataInput) : Number
        {
            return param1.readDouble();
        }// end function

        public static function read$TYPE_FLOAT(param1:IDataInput) : Number
        {
            return param1.readFloat();
        }// end function

        public static function read$TYPE_INT64(param1:IDataInput) : Int64
        {
            var _loc_3:uint = 0;
            var _loc_2:* = new Int64();
            var _loc_4:uint = 0;
            while (true)
            {
                
                _loc_3 = param1.readUnsignedByte();
                if (_loc_4 == 28)
                {
                    break;
                }
                else if (_loc_3 >= 128)
                {
                    _loc_2.low = _loc_2.low | (_loc_3 & 127) << _loc_4;
                }
                else
                {
                    _loc_2.low = _loc_2.low | _loc_3 << _loc_4;
                    return _loc_2;
                }
                _loc_4 = _loc_4 + 7;
            }
            if (_loc_3 >= 128)
            {
                _loc_3 = _loc_3 & 127;
                _loc_2.low = _loc_2.low | _loc_3 << _loc_4;
                _loc_2.high = _loc_3 >>> 4;
            }
            else
            {
                _loc_2.low = _loc_2.low | _loc_3 << _loc_4;
                _loc_2.high = _loc_3 >>> 4;
                return _loc_2;
            }
            _loc_4 = 3;
            while (true)
            {
                
                _loc_3 = param1.readUnsignedByte();
                if (_loc_4 < 32)
                {
                    if (_loc_3 >= 128)
                    {
                        _loc_2.high = _loc_2.high | (_loc_3 & 127) << _loc_4;
                    }
                    else
                    {
                        _loc_2.high = _loc_2.high | _loc_3 << _loc_4;
                        break;
                    }
                }
                _loc_4 = _loc_4 + 7;
            }
            return _loc_2;
        }// end function

        public static function read$TYPE_UINT64(param1:IDataInput) : UInt64
        {
            var _loc_3:uint = 0;
            var _loc_2:* = new UInt64();
            var _loc_4:uint = 0;
            while (true)
            {
                
                _loc_3 = param1.readUnsignedByte();
                if (_loc_4 == 28)
                {
                    break;
                }
                else if (_loc_3 >= 128)
                {
                    _loc_2.low = _loc_2.low | (_loc_3 & 127) << _loc_4;
                }
                else
                {
                    _loc_2.low = _loc_2.low | _loc_3 << _loc_4;
                    return _loc_2;
                }
                _loc_4 = _loc_4 + 7;
            }
            if (_loc_3 >= 128)
            {
                _loc_3 = _loc_3 & 127;
                _loc_2.low = _loc_2.low | _loc_3 << _loc_4;
                _loc_2.high = _loc_3 >>> 4;
            }
            else
            {
                _loc_2.low = _loc_2.low | _loc_3 << _loc_4;
                _loc_2.high = _loc_3 >>> 4;
                return _loc_2;
            }
            _loc_4 = 3;
            while (true)
            {
                
                _loc_3 = param1.readUnsignedByte();
                if (_loc_4 < 32)
                {
                    if (_loc_3 >= 128)
                    {
                        _loc_2.high = _loc_2.high | (_loc_3 & 127) << _loc_4;
                    }
                    else
                    {
                        _loc_2.high = _loc_2.high | _loc_3 << _loc_4;
                        break;
                    }
                }
                _loc_4 = _loc_4 + 7;
            }
            return _loc_2;
        }// end function

        public static function read$TYPE_INT32(param1:IDataInput) : int
        {
            return int(read$TYPE_UINT32(param1));
        }// end function

        public static function read$TYPE_FIXED64(param1:IDataInput) : UInt64
        {
            var _loc_2:* = new UInt64();
            _loc_2.low = param1.readUnsignedInt();
            _loc_2.high = param1.readUnsignedInt();
            return _loc_2;
        }// end function

        public static function read$TYPE_FIXED32(param1:IDataInput) : uint
        {
            return param1.readUnsignedInt();
        }// end function

        public static function read$TYPE_BOOL(param1:IDataInput) : Boolean
        {
            return read$TYPE_UINT32(param1) != 0;
        }// end function

        public static function read$TYPE_STRING(param1:IDataInput) : String
        {
            var _loc_2:* = read$TYPE_UINT32(param1);
            return param1.readUTFBytes(_loc_2);
        }// end function

        public static function read$TYPE_BYTES(param1:IDataInput) : ByteArray
        {
            var _loc_2:* = new ByteArray();
            var _loc_3:* = read$TYPE_UINT32(param1);
            if (_loc_3 > 0)
            {
                param1.readBytes(_loc_2, 0, _loc_3);
            }
            return _loc_2;
        }// end function

        public static function read$TYPE_UINT32(param1:IDataInput) : uint
        {
            var _loc_4:uint = 0;
            var _loc_2:uint = 0;
            var _loc_3:uint = 0;
            while (true)
            {
                
                _loc_4 = param1.readUnsignedByte();
                if (_loc_3 < 32)
                {
                    if (_loc_4 >= 128)
                    {
                        _loc_2 = _loc_2 | (_loc_4 & 127) << _loc_3;
                    }
                    else
                    {
                        _loc_2 = _loc_2 | _loc_4 << _loc_3;
                        break;
                    }
                }
                else
                {
                    while (param1.readUnsignedByte() >= 128)
                    {
                        
                    }
                    break;
                }
                _loc_3 = _loc_3 + 7;
            }
            return _loc_2;
        }// end function

        public static function read$TYPE_ENUM(param1:IDataInput) : int
        {
            return read$TYPE_INT32(param1);
        }// end function

        public static function read$TYPE_SFIXED32(param1:IDataInput) : int
        {
            return param1.readInt();
        }// end function

        public static function read$TYPE_SFIXED64(param1:IDataInput) : Int64
        {
            var _loc_2:* = new Int64();
            _loc_2.low = param1.readUnsignedInt();
            _loc_2.high = param1.readInt();
            return _loc_2;
        }// end function

        public static function read$TYPE_SINT32(param1:IDataInput) : int
        {
            return ZigZag.decode32(read$TYPE_UINT32(param1));
        }// end function

        public static function read$TYPE_SINT64(param1:IDataInput) : Int64
        {
            var _loc_2:Int64 = null;
            _loc_2 = read$TYPE_INT64(param1);
            var _loc_3:* = _loc_2.low;
            var _loc_4:* = _loc_2.high;
            _loc_2.low = ZigZag.decode64low(_loc_3, _loc_4);
            _loc_2.high = ZigZag.decode64high(_loc_3, _loc_4);
            return _loc_2;
        }// end function

        public static function read$TYPE_MESSAGE(param1:IDataInput, param2:Message) : Message
        {
            var _loc_3:* = read$TYPE_UINT32(param1);
            if (param1.bytesAvailable < _loc_3)
            {
                throw new IOError("Invalid message length: " + _loc_3);
            }
            var _loc_4:* = param1.bytesAvailable - _loc_3;
            param2.readFromSlice(param1, _loc_4);
            if (param1.bytesAvailable != _loc_4)
            {
                throw new IOError("Invalid nested message");
            }
            return param2;
        }// end function

        public static function readPackedRepeated(param1:IDataInput, param2:Function, param3) : void
        {
            var _loc_4:* = read$TYPE_UINT32(param1);
            if (param1.bytesAvailable < _loc_4)
            {
                throw new IOError("Invalid message length: " + _loc_4);
            }
            var _loc_5:* = param1.bytesAvailable - _loc_4;
            while (param1.bytesAvailable > _loc_5)
            {
                
                param3.push(ReadUtils.param2(param1));
            }
            if (param1.bytesAvailable != _loc_5)
            {
                throw new IOError("Invalid packed repeated data");
            }
            return;
        }// end function

    }
}
