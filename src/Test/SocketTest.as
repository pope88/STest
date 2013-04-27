package Test
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;

	public class SocketTest
	{
		public function SocketTest()
		{
		}
		public function init():void
		{
			if(_socket == null)
			{
				_socket = new Socket();
			}
		}
		public function testClient(ip:String, port:int):void
		{
			init();
			connect(ip, port);
		}
		
		private function addSocketEvents(_socket : Socket) : void
		{
//			_socket.addEventListener(IOErrorEvent.IO_ERROR,socket_ioErrorHandler);
//			_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,socket_securityErrorHandler);
//			_socket.addEventListener(Event.CONNECT,socket_connectHandler);
//			_socket.addEventListener(ProgressEvent.SOCKET_DATA,socket_dataHandler);
//			_socket.addEventListener(Event.CLOSE,socket_closeHandler);
		}
		
		private function removeSocketEvents(_socket : Socket) : void
		{
//			_socket.removeEventListener(IOErrorEvent.IO_ERROR,socket_ioErrorHandler);
//			_socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,socket_securityErrorHandler);
//			_socket.removeEventListener(Event.CONNECT,socket_connectHandler);
//			_socket.removeEventListener(ProgressEvent.SOCKET_DATA,socket_dataHandler);
//			_socket.removeEventListener(Event.CLOSE,socket_closeHandler);
		}
		
		public function connect(ip:String, port:int):void
		{
			_socket.connect(ip, port);
			_socket.addEventListener(Event.CONNECT, OnConnected);
		}
		public function OnConnected(evt:Event):void
		{
			var b:ByteArray = new ByteArray();
			b.writeInt(12345);
			_socket.writeBytes(b, 0, b.length);
			_socket.flush();
		}
		private var _socket:Socket;
	}
}