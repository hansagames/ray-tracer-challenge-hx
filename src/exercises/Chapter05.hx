package exercises;

import components.Canvas;
import utils.TuplesCreator.createPoint;
import utils.CanvasCreator.createCanvas;
import utils.TuplesCreator.createColor;
import utils.RayCreator.createRay;
import utils.SphereCreator.createSphere;
import sys.io.File;
import haxe.io.Path;

using utils.Tuples;
using utils.CanvasPPM;
using utils.Intersections;

class Chapter05 {
	public function new() {
		final canvasSize = 100;
		final canvas = createCanvas(canvasSize, canvasSize);
		final rayOrigin = createPoint(0, 0, -5);
		final wallZ = 10.0;
		final wallSize = 7.0;
		final pixelSize:Float = wallSize / canvasSize;
		final half = wallSize * 0.5;
		final color = createColor(1, 0, 1);
		final shape = createSphere();

		for (y in 0...(canvasSize - 1)) {
			final worldY = half - pixelSize * y;
			for (x in 0...(canvasSize - 1)) {
				final worldX = -half + pixelSize * x;
				final position = createPoint(worldX, worldY, wallZ);
				final ray = createRay(rayOrigin, (position - rayOrigin).normalize());
				final hit = shape.intersects(ray).hit();
				if (hit != null) {
					canvas.writePixel(x, canvasSize - y, color);
				}
			}
		}

		File.saveContent(Path.join(["build", "chapter05.ppm"]), canvas.toPPM());
	}
}
