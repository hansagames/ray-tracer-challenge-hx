package utils;

import types.Tuple;

class Colors {
	public static function toRGBString(c:Tuple):String {
		return '${clampRGBColor(c.x)} ${clampRGBColor(c.y)} ${clampRGBColor(c.z)}';
	}

	private static function clampRGBColor(value:Float):Int {
		return Math.round(Math.min(Math.max(value * 255, 0), 255));
	}
}
