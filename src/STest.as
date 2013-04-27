package
{
	import Test.SocketTest;
	
	import flash.display.Sprite;
	
	public class STest extends Sprite
	{
		public function STest()
		{
			var _test:SocketTest = new SocketTest();
			_test.testClient("127.0.0.1", 8880);
		}
	}
}