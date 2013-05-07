package game.net.pool
{
    import __AS3__.vec.*;
    import com.protobuf.*;
    import flash.events.*;
    import flash.utils.*;
    import game.net.core.*;
    import log4a.*;

    public class CallPool extends Object
    {
        private var _callbacks:Dictionary;
        private var _delay:int = 20;
        private var _signalDic:Dictionary;
        private var _blocks:Array;
        private var _current:SignalElement;
        private var _requestList:Vector.<RequestData>;
        protected var _timer:Timer;
        private var _max:int;
        private var i:int = 0;

        public function CallPool()
        {
            this._signalDic = new Dictionary();
            this._blocks = [];
            this._requestList = new Vector.<RequestData>;
            this._callbacks = new Dictionary();
            this._timer = new Timer(this._delay);
            this._timer.addEventListener(TimerEvent.TIMER, this.timerHandler);
            return;
        }// end function

        public function addReqestData(param1:RequestData) : void
        {
            this._requestList.push(param1);
            if (!this._timer.running)
            {
                this._timer.reset();
                this._timer.start();
            }
            return;
        }// end function

        public function addCallback(param1:uint, param2:Function) : void
        {
            if (this._callbacks[param1] == null)
            {
                this._callbacks[param1] = new PoolElement();
            }
            PoolElement(this._callbacks[param1]).addFunction(param2);
            return;
        }// end function

        public function removeCallback(param1:uint, param2:Function = null) : void
        {
            if (!this._callbacks[param1])
            {
                Logger.error("删除回调函数出错!原因:没有此回调函数    cmd=" + param1);
                return;
            }
            if (param2 != null)
            {
                PoolElement(this._callbacks[param1]).removeFunction(param2);
            }
            if (PoolElement(this._callbacks[param1]).size() <= 0 || param2 == null)
            {
                delete this._callbacks[param1];
            }
            return;
        }// end function

        public function executeCCRequest(param1:RequestData) : void
        {
            if (!param1 || !this._callbacks[param1.method])
            {
                if (!param1)
                {
                    return;
                }
                Logger.error("执行executeCCRequest出错!原因:没有此回调函数    cmd=" + param1.method);
                return;
            }
            PoolElement(this._callbacks[param1.method]).execute(param1.args);
            return;
        }// end function

        private function timerHandler(event:TimerEvent) : void
        {
            this._max = this._requestList.length * 0.1;
            this._max = this._max < 1 ? (1) : (this._max);
            this.i = 0;
            while (this.i < this._max)
            {
                
                this.execute(this._requestList.shift());
                var _loc_2:String = this;
                var _loc_3:* = this.i + 1;
                _loc_2.i = _loc_3;
            }
            if (this._requestList.length <= 0 && this._timer.running)
            {
                this._timer.stop();
            }
            return;
        }// end function

        public function addSignal(param1:uint, param2:Vector.<uint>, param3:uint) : void
        {
            this._signalDic[param1] = new SignalElement(param1, param2, param3);
            return;
        }// end function

        public function setCurrent(param1:uint) : void
        {
            this._current = this._signalDic[param1];
            Logger.debug("setCurrent  cmd===>" + param1);
            return;
        }// end function

        public function executeBlock(param1:uint) : void
        {
            var _loc_3:RequestData = null;
            if (!this._current || param1 != this._current.exitCmd)
            {
                return;
            }
            Logger.debug("executeBlock  cmd===>" + param1);
            this._current = null;
            var _loc_2:* = this._blocks.slice();
            this._blocks = [];
            if (!_loc_2)
            {
                return;
            }
            for each (_loc_3 in _loc_2)
            {
                
                this.runRequest(_loc_3);
            }
            return;
        }// end function

        private function execute(param1:RequestData) : void
        {
            if (!param1 || !this._callbacks[param1.method])
            {
                Logger.error("执行回调函数出错!原因:没有此回调函数    cmd=" + param1 ? (param1.method) : (null));
                return;
            }
            param1.parse();
            this.runRequest(param1);
            return;
        }// end function

        private function runRequest(param1:RequestData) : void
        {
            if (this._current && this._current.isConflict(param1.method))
            {
                this._blocks.push(param1);
                return;
            }
            if (this._signalDic[param1.method])
            {
                this._current = this._signalDic[param1.method];
            }
            var _loc_2:* = PoolElement(this._callbacks[param1.method]);
            if (!_loc_2 || !(param1.args is Message))
            {
                return;
            }
            _loc_2.execute(param1.args);
            return;
        }// end function

    }
}

class PoolElement extends Object
{
    private var _elements:Vector.<Function>;

    function PoolElement()
    {
        this._elements = new Vector.<Function>;
        return;
    }// end function

    public function execute(param1:Message) : void
    {
        var _loc_3:Function = null;
        if (!this._elements)
        {
            return;
        }
        var _loc_2:* = this._elements.slice();
        for each (_loc_3 in _loc_2)
        {
            
            _loc_3.apply(null, [param1]);
        }
        return;
    }// end function

    public function addFunction(param1:Function) : void
    {
        if (this.findAt(param1) == -1)
        {
            this._elements.push(param1);
        }
        return;
    }// end function

    public function removeFunction(param1:Function) : void
    {
        var _loc_2:* = this.findAt(param1);
        if (_loc_2 >= 0)
        {
            this._elements.splice(_loc_2, 1);
        }
        return;
    }// end function

    public function getFunctions() : Vector.<Function>
    {
        return this._elements;
    }// end function

    public function findAt(param1:Function) : int
    {
        return this._elements.indexOf(param1);
    }// end function

    public function reset() : void
    {
        this._elements = new Vector.<Function>;
        return;
    }// end function

    public function size() : int
    {
        return this._elements ? (this._elements.length) : (-1);
    }// end function

    public function clean() : void
    {
        this._elements = null;
        return;
    }// end function

}

