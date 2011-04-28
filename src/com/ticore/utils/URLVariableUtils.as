package com.ticore.utils {
	import flash.net.URLVariables;
	import flash.utils.ByteArray;

	public class URLVariableUtils {
		
		public static const KeyValueRegExp:RegExp = /[^&]*=[^&]*/g;
		
		public static function parseBinaryData(data:ByteArray, charSet:String):URLVariables {
			var valuePairs:Array = data.readMultiByte(data.length, charSet).match(KeyValueRegExp);
			var pairAry:Array;
			var urlVars:URLVariables = new URLVariables();
			for each (var pairStr:String in valuePairs) {
				pairAry = pairStr.split("=");
				pairAry[0] = decodeURICompCharset(pairAry[0], charSet);
				pairAry[1] = decodeURICompCharset(pairAry[1], charSet);
				urlVars[pairAry[0]] = pairAry[1];
			}
			return urlVars;
		}
		
		
		public static function decodeURICompCharset(str:String, charSet:String):String{
			var byte:ByteArray = new ByteArray();
			var i:int = 0, charCode:int;
			while (i < str.length) {
				charCode = parseInt(str.substr(i + 1, 2), 16);
				if (str.charAt(i) == "%" && !isNaN(charCode)) {
					byte[byte.length] = charCode;
					i += 3;
				} else {
					byte.position = byte.length;
					byte.writeMultiByte(str.charAt(i), charSet);
					i += 1;
				}
			}
			byte.position = 0;
			return byte.readMultiByte(byte.length, charSet);
		}
	}
}