package exercises;

import utils.TuplesCreator.createPoint;
import utils.CanvasCreator.createCanvas;
import utils.TuplesCreator.createColor;
import utils.RayCreator.createRay;
import utils.SphereCreator.createSphere;
import utils.PointLightCreator.createPointLight;
import utils.MaterialsCreator.lighting;
import sys.io.File;
import haxe.io.Path;

using utils.Tuples;
using utils.CanvasPPM;
using utils.Intersections;
using utils.Rays;

class Chapter06 {
	public function new() {
		final canvasSize = 200;
		final canvas = createCanvas(canvasSize, canvasSize);
		final rayOrigin = createPoint(0, 0, -5);
		final wallZ = 10.0;
		final wallSize = 7.0;
		final pixelSize:Float = wallSize / canvasSize;
		final half = wallSize * 0.5;
		final shape = createSphere();
		shape.material.color = createColor(1, 0.2, 1);
		final light = createPointLight(createPoint(-10, 10, -10), createColor(1, 1, 1));

		for (y in 0...(canvasSize - 1)) {
			final worldY = half - pixelSize * y;
			for (x in 0...(canvasSize - 1)) {
				final worldX = -half + pixelSize * x;
				final position = createPoint(worldX, worldY, wallZ);
				final ray = createRay(rayOrigin, (position - rayOrigin).normalize());
				final hit = shape.intersects(ray).hit();
				if (hit != null) {
					final p = ray.position(hit.t);
					final n = hit.object.normalAt(p);
					final eye = ray.direction;
					final color = lighting(hit.object.material, light, p, eye, n, false);
					canvas.writePixel(x, y, color);
				}
			}
		}

		File.saveContent(Path.join(["build", "chapter06.ppm"]), canvas.toPPM());
	}
}
