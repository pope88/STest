package utils
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;
    import gameui.manager.*;

    public class ClassUtil extends Object
    {
        private static var _varStringDic:Dictionary = new Dictionary(true);

        public function ClassUtil()
        {
            return;
        }// end function

        public static function getClassVariable(param1) : Vector.<String>
        {
            var _loc_7:XML = null;
            var _loc_8:Object = null;
            var _loc_2:* = getQualifiedClassName(param1);
            if (_varStringDic[_loc_2] != null)
            {
                return _varStringDic[_loc_2];
            }
            var _loc_3:* = describeType(param1);
            var _loc_4:* = _loc_3.descendants("variable");
            var _loc_5:* = new Vector.<Object>;
            var _loc_6:* = new Vector.<String>;
            for each (_loc_7 in _loc_4)
            {
                
                _loc_5.push({name:_loc_7.attribute("name"), value:_loc_7["metadata"]["arg"].@value});
            }
            _loc_5.sort(fun);
            for each (_loc_8 in _loc_5)
            {
                
                _loc_6.push(_loc_8["name"]);
            }
            _varStringDic[_loc_2] = _loc_6;
            return _loc_6;
        }// end function

        public static function getClassMethod(param1) : Vector.<Object>
        {
            var _loc_5:XML = null;
            var _loc_6:Array = null;
            var _loc_7:XMLList = null;
            var _loc_8:XML = null;
            var _loc_9:* = undefined;
            var _loc_2:* = describeType(param1);
            var _loc_3:* = _loc_2.descendants("method");
            var _loc_4:* = new Vector.<Object>;
            for each (_loc_5 in _loc_3)
            {
                
                _loc_6 = [];
                _loc_7 = _loc_5["parameter"];
                for each (_loc_8 in _loc_7)
                {
                    
                    param1 = _loc_8["index"];
                    _loc_9 = _loc_8["type"];
                    _loc_6[int(_loc_8.attribute["index"])] = String(_loc_8.attribute["type"]);
                }
                _loc_4.push({name:_loc_5.attribute("name"), value:_loc_6});
            }
            return _loc_4;
        }// end function

        public static function baseClone(param1)
        {
            var _loc_2:* = getQualifiedClassName(param1);
            var _loc_3:* = _loc_2.split("::")[1];
            if (_loc_3 != null)
            {
                registerClassAlias(_loc_3, getClass(_loc_2));
            }
            var _loc_4:* = new ByteArray();
            new ByteArray().writeObject(param1);
            _loc_4.position = 0;
            return _loc_4.readObject();
        }// end function

        public static function arrayToClass(param1, param2:Array)
        {
            if (!param1 || !param2)
            {
                return param1;
            }
            var _loc_3:* = getClassVariable(param1);
            var _loc_4:* = param2.length;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_4)
            {
                
                if (!_loc_3[_loc_5])
                {
                    return param1;
                }
                param1[_loc_3[_loc_5]] = param2[_loc_5];
                _loc_5++;
            }
            return param1;
        }// end function

        public static function xmlToClass(param1, param2:XML)
        {
            if (!param1 || !param2)
            {
                return param1;
            }
            var _loc_3:* = getClassVariable(param1);
            var _loc_4:* = _loc_3.length;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_4)
            {
                
                param1[_loc_3[_loc_5]] = param2[_loc_3[_loc_5]];
                _loc_5++;
            }
            return param1;
        }// end function

        public static function createDisplayObjectInstance(param1:String, param2:ApplicationDomain = null) : DisplayObject
        {
            return createInstance(param1, param2) as DisplayObject;
        }// end function

        public static function createInstance(param1:String, param2:ApplicationDomain = null)
        {
            var _loc_3:* = getClass(param1, param2);
            if (_loc_3 != null)
            {
                return new _loc_3;
            }
            return null;
        }// end function

        public static function getClass(param1:String, param2:ApplicationDomain = null) : Class
        {
            if (param2 == null)
            {
                param2 = StaticVar.appDomain;
            }
            var _loc_3:* = param2.getDefinition(param1) as Class;
            return _loc_3;
        }// end function

        public static function getFullClassName(param1) : String
        {
            return getQualifiedClassName(param1);
        }// end function

        public static function getClassName(param1) : String
        {
            var _loc_2:* = getFullClassName(param1);
            var _loc_3:* = _loc_2.lastIndexOf(".");
            if (_loc_3 >= 0)
            {
                _loc_2 = _loc_2.substr((_loc_3 + 1));
            }
            return _loc_2;
        }// end function

        public static function getPackageName(param1) : String
        {
            var _loc_2:* = getFullClassName(param1);
            var _loc_3:* = _loc_2.lastIndexOf(".");
            if (_loc_3 >= 0)
            {
                return _loc_2.substring(0, _loc_3);
            }
            return "";
        }// end function

        private static function fun(param1:Object, param2:Object) : int
        {
            return param1["value"] - param2["value"];
        }// end function

    }
}
