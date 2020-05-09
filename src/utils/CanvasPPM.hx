package utils;

import types.Tuple;
import components.Canvas;

using utils.Colors;
using utils.Lines;
using StringTools;

class CanvasPPM {
	private static final ColorRange = 255;

	public static function toPPM(c:Canvas):String {
		return 'P3\n${c.width} ${c.height}\n${ColorRange}\n${writePixels(c.pixels)}';
	}

	private static function writePixels(pixels:Array<Array<Tuple>>):String {
		var stringifiedPixels = "";
		for (row in pixels) {
			var rowPixels = "";
			for (color in row) {
				rowPixels += '${color.toRGBString()} ';
			}
			rowPixels = '${rowPixels.trim().limitLineLength(70)}\n';
			stringifiedPixels += rowPixels;
		}
		return stringifiedPixels;
	}
}
