package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLVariables;
	import flash.system.Capabilities;
	import flash.system.System;
	import flash.text.TextField;

	[SWF(width="300", height="200", backgroundColor="#DDDDDD")]
	public class SWF10DecodingBug extends Sprite {

		public var txt:TextField = new TextField();
		
		public function SWF10DecodingBug() {
			loaderInfo.addEventListener(Event.COMPLETE, onComplete);
		}
		
		public function onComplete(e:Event):void{
			System.useCodePage = true;
			
			txt.width = 200, txt.height = 100;
			txt.border = txt.multiline = txt.wordWrap = true;
			txt.x = 50, txt.y = 50;
			addChild(txt);
			
			txt.appendText("Flash Player Version: " + Capabilities.version + "\n");
			txt.appendText("SWF Version: " + loaderInfo.swfVersion + "\n");
			txt.appendText("ver1=" + new URLVariables("var1=中文").var1);
		}
	}
}
