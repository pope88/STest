package game.net.socket
{
	import flash.events.*;
	import flash.net.Socket;
	import flash.system.Security;
	import flash.utils.*;
	
	import game.net.pool.*;
	
	import log4a.Logger;
	
	import mx.events.Request;
	
	import org.osflash.signals.natives.base.*;

	public class SocketClient extends EventDispatcher
	{
		public function SocketClient()
		{
			this._signalDic = new Dictionary();
			this.init();
			return;
		}
		
		private function init():void
		{
			this.reset();
			this._requstPool = new CallPool();
			this._vector = new Vector.<SignalSocket>;
			this._parser = new SocketParser();
			return;
		}
		
		private function reset():void
		{
			this._length = 0;
			return;
		}
		
		public function connect(sdata:SocketData):void
		{
			var data:* = sdata;
			if(this._socket && this._socket.connected)
			{
				return;
			}
			this._data = data;
			try
			{
				this._vector[Number(data.name)] = new SignalSocket();
				this._vector[Number(data.name)].endian = Endian.LITTLE_ENDIAN;
				this.addSocketEvents(this._vector[Number(data.name)]);
				Security.loadPolicyFile("xmlsocket://" + this._data.host + ":" + this._data.port);
				this._vector[Number(data.name)].connect(this._data.host, this._data.port);
				Logger.debug("发送信息！" + "xmlsocket://" + this._data.host + ":" + this._data.port);

			}
			catch(e:Error)
			{
				Logger.debug("连接出错了！" + e.message);			
			}
			
		}
		
		private function addSocketEvents(ssocket:SignalSocket):void
		{
			ssocket.signals.connect.add(this.socket_connectHandler);
			ssocket.signals.close.add(this.socket_closeHandler);
			ssocket.signals.socketData.add(this.socket_dataHandler);
			ssocket.signals.ioError.add(this.socket_ioErrorHandler);
			ssocket.signals.securityError.add(this.socket_securityErrorHandler);
			return;
		}
		
		private function removeSocketEvents(ssocket:SignalSocket):void
		{
			ssocket.signals.removeAll();
			return;
		}
		
		private function socket_connectHandler(event:Event):void
		{
			var _loc_2:SignalSocket = null;
			this._socket = event.currentTarget as SignalSocket;
			Logger.debug("连接成功！");
			for each (_loc_2 in this._vector)
			{
				
				if (event.currentTarget != _loc_2)
				{
					_loc_2.close();
					this.removeSocketEvents(_loc_2);
				}
			}
			this._vector = null;
			dispatchEvent(new Event(Event.CONNECT));
			/*this.addCallback(0x00, this.pingCallBack);*/
			return;
		}
		
		/*private function pingCallBack(mPin:SCPing):void
		{
			this._socketDelay = getTimer() - param1.ping;
			this._pingGap = this._pingGap / ((getTimer() - param1.ping) / 200);
			if (this._socketDelay > this._maxPing)
			{
				this._maxPing = this._socketDelay;
			}
			return;
		}*/
		
		private function socket_closeHandler(event:Event):void
		{
			if (event.currentTarget != this._socket)
			{
				return;
			}
			if (this._socket && this._socket.connected)
			{
				return;
			}
			dispatchEvent(new Event(Event.CLOSE));
			return;
		}
		
		private function socket_dataHandler(event:ProgressEvent):void
		{
			var bytes:ByteArray;
			var event:* = event;
			while(this._socket.bytesAvailable > 5)
			{
				if(this._length == 0)
				{
					this._length = this._socket.readUnsignedInt() + 2;
					if(this._length > this._maxLength)
					{
						this._maxLength = this._length;
					}
				}
				if(this._socket.bytesAvailable < this._length)
				{
					break;
				}
				if (this._socket.bytesAvailable > this._maxBytesAvailable)
				{
					this._maxBytesAvailable = this._socket.bytesAvailable;
				}
				try
				{
					bytes = new ByteArray();
					bytes.endian = Endian.LITTLE_ENDIAN;
					this._socket.readBytes(bytes, 0, this._length);
					this._readBytes += (this._length + 4);
					this._requstPool.addReqestData(new RequestD)
				}
				catch(e:Error)
				{
					Logger.error("解析消息出错！");
				}
				finally
				{
					this._length = 0;
				}
			}
			return;
		}
		
		private function socket_ioErrorHandler(event:Event):void
		{
			if (event.currentTarget != this._socket)
			{
				return;
			}
			dispatchEvent(new Event(IO_ERROR));
			Logger.debug("连接出错了！" + IO_ERROR);
			return;
		}
		
		private function socket_securityErrorHandler(event:Event):void
		{
			if (event.currentTarget != this._socket)
			{
				return;
			}
			dispatchEvent(new Event(SECURITY_ERROR));
			Logger.debug("连接安全出错了！" + SECURITY_ERROR);
			return;
		}
		
		public function addCallback(opCode:uint, mFunc:Function):void
		{
			this._requstPool.addCallback(opCode, mFunc);
			return;
		}
		
		public function sendPingCmd():void
		{
			/*var _loc_1:* = ObjectPool.getObject(CSPing);
			_loc_1.ping = getTimer();
			this.sendMessage(0, _loc_1);*/
			return;
		}
		
		//debug net work
		public function debug() : void
		{
			this.sendPingCmd();
			Logger.debug("[SocketClient]");
			Logger.debug("当前Ping值：" + this._socketDelay);
			Logger.debug("最大Ping值：" + this._maxPing);
			Logger.debug("最大包长度：" + this._maxLength);
			Logger.debug("最大Socket数据长度：" + this._maxBytesAvailable);
			return;
		}// end function
		
		private var _socket:SignalSocket;
		private var _signalDic:Dictionary;
		private var _requstPool:CallPool;
		private var _vector:Vector.<SignalSocket>;
		private var _parser:SocketParser;
		private var _data:SocketData;
		private var _length:uint;
		
		private var _socketDelay:uint = 0;
		private var _maxPing:uint = 0;
		private var _maxLength:uint = 0;
		private var _maxBytesAvailable:uint = 0;
		private var _readBytes:uint = 0;
		public static const IO_ERROR:String = "ioError";
		public static const SECURITY_ERROR:String = "securityError";
	}
}