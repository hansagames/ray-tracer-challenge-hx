package utils;

using StringTools;

class Lines {
	public static function readLine(source:String, line:Int):String {
		return ~/\r?\n/g.split(source)[line - 1].trim();
	}

	public static function limitLineLength(source:String, length:Int):String {
		if (source.length <= length) {
			return source.trim();
		}
		var words = source.trim().split(" ");
		var currentLength = 0;
		var result = "";
		for (word in words) {
			if (word.length + 1 + currentLength > length) {
				currentLength = 0;
				result += "\n";
			}
			result += '${word} ';
			currentLength += word.length + 1;
		}
		return result.trim();
	}
}
