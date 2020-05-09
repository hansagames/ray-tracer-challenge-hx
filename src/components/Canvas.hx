package components;

import types.Tuple;
import utils.TuplesCreator.createColor;

class Canvas {
	public var width(default, null):Int;
	public var height(default, null):Int;

	public var pixels(default, null):Array<Array<Tuple>>;

	public function new(width:Int, height:Int) {
		this.width = width;
		this.height = height;
		fillPixels(createColor(0, 0, 0));
	}

	public function writePixel(x:Int, y:Int, color:Tuple):Void {
		pixels[y][x] = color;
	}

	public function pixelAt(x:Int, y:Int):Tuple {
		return pixels[y][x];
	}

	public function fillPixels(color:Tuple):Void {
		pixels = [];
		var row:Array<Tuple>;
		for (y in 0...height) {
			row = pixels[y] = [];
			for (x in 0...width) {
				row.push(color);
			}
		}
	}
}
