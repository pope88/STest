package com.protobuf
{
    import flash.errors.*;
    import flash.utils.*;

    public class BaseFieldDescriptor extends Object
    {
        public var fullName:String;
        public var name:String;
        public var tag:uint;
        private static const ACTIONSCRIPT_KEYWORDS:Object = {as:true, break:true, case:true, catch:true, class:true, const:true, continue:true, default:true, delete:true, do:true, else:true, extends:true, false:true, finally:true, for:true, function:true, if:true, implements:true, import:true, in:true, instanceof:true, interface:true, internal:true, is:true, native:true, new:true, null:true, package:true, private:true, protected:true, public:true, return:true, super:true, switch:true, this:true, throw:true, to:true, true:true, try:true, typeof:true, use:true, var:true, void:true, while:true, with:true};

        public function BaseFieldDescriptor()
        {
            return;
        }// end function

        public function get type() : Class
        {
            throw new IllegalOperationError("Not Implemented!");
        }// end function

        public function readSingleField(param1:IDataInput)
        {
            throw new IllegalOperationError("Not Implemented!");
        }// end function

        public function writeSingleField(param1:WritingBuffer, param2) : void
        {
            throw new IllegalOperationError("Not Implemented!");
        }// end function

        public function write(param1:WritingBuffer, param2:Message) : void
        {
            throw new IllegalOperationError("Not Implemented!");
        }// end function

        public function toString() : String
        {
            return this.name;
        }// end function

        public static function getExtensionByName(param1:String) : BaseFieldDescriptor
        {
            var _loc_2:* = param1.lastIndexOf("/");
            if (_loc_2 == -1)
            {
                return BaseFieldDescriptor.BaseFieldDescriptor(getDefinitionByName(param1));
            }
            return getDefinitionByName(param1.substring(0, _loc_2))[param1.substring((_loc_2 + 1))];
        }// end function

    }
}
