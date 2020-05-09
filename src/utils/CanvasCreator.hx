package utils;

import components.Canvas;

class CanvasCreator {
	public static function createCanvas(width:Int, height:Int):Canvas {
		return new Canvas(width, height);
	}
}
