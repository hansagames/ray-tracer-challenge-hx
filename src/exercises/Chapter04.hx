package exercises;

import components.Canvas;
import utils.TuplesCreator.createPoint;
import utils.CanvasCreator.createCanvas;
import utils.TuplesCreator.createColor;
import utils.Transformation.rotationY;
import sys.io.File;
import haxe.io.Path;

using utils.Tuples;
using utils.CanvasPPM;

class Chapter04 {
	private var canvas:Canvas;

	public function new() {
		canvas = createCanvas(400, 400);
		var p = createPoint(0, 0, 1);
		final transform = rotationY(Math.PI / 6);
		final radius = 400 * 0.3;
		for (i in 0...12) {
			canvas.writePixel(Std.int(p.x * radius) + 200, Std.int(p.z * radius) + 200, createColor(1, 0, 1));
			p = transform * p;
		}
		File.saveContent(Path.join(["build", "chapter04.ppm"]), canvas.toPPM());
	}
}
