package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.system.Capabilities;
	import flash.system.System;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	import com.ticore.utils.URLVariableUtils;

	[SWF(width="300", height="200")]
	public class URLDencodingTest extends Sprite {

		public var urlLdr1:URLLoader = new URLLoader();
		public var urlLdr2:URLLoader = new URLLoader();
		public var txt:TextField = new TextField();
		
		public function URLDencodingTest() {
			loaderInfo.addEventListener(Event.COMPLETE, onComplete);
		}
		
		public function onComplete(e:Event):void{
			System.useCodePage = false;
			
			txt.width = 200, txt.height = 160;
			txt.border = txt.multiline = txt.wordWrap = true;
			txt.x = 50, txt.y = 20;
			addChild(txt);
			
			txt.appendText("Flash Player Version: " + Capabilities.version + "\n");
			txt.appendText("SWF Version: " + loaderInfo.swfVersion + "\n");
			
			urlLdr1.dataFormat = URLLoaderDataFormat.BINARY;
			urlLdr1.addEventListener(Event.COMPLETE, loadCompleteHandler1);
			urlLdr1.load(new URLRequest("data_big5.txt"));
			
			urlLdr2.dataFormat = URLLoaderDataFormat.BINARY;
			urlLdr2.addEventListener(Event.COMPLETE, loadCompleteHandler2);
			urlLdr2.load(new URLRequest("data_gb.txt"));
		}

		private function loadCompleteHandler1(e:Event):void {
			urlLdr1.data = URLVariableUtils.parseBinaryData(urlLdr1.data, "big5");
			urlLdr1.dataFormat = URLLoaderDataFormat.VARIABLES;
			
			txt.appendText("[data_big5.txt]\n");
			for (var i:String in urlLdr1.data) {
				txt.appendText(i + ": " + urlLdr1.data[i] + "\n");
			}
		}

		private function loadCompleteHandler2(e:Event):void {
			urlLdr2.data = URLVariableUtils.parseBinaryData(urlLdr2.data, "gb2312");
			urlLdr2.dataFormat = URLLoaderDataFormat.VARIABLES;
			
			txt.appendText("[data_gb.txt]\n");
			for (var i:String in urlLdr2.data) {
				txt.appendText(i + ": " + urlLdr2.data[i] + "\n");
			}
		}
	}
}
