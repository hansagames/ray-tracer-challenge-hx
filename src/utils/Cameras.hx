package utils;

import components.Canvas;
import types.World;
import types.Camera;
import types.Ray;
import utils.TuplesCreator.createPoint;
import utils.RayCreator.createRay;
import utils.CanvasCreator.createCanvas;

using utils.Tuples;
using utils.Matrices;
using utils.Worlds;

class Cameras {
	public static function rayForPixel(c:Camera, px:Float, py:Float):Ray {
		final xOffset = (px + 0.5) * c.pixelSize;
		final yOffset = (py + 0.5) * c.pixelSize;

		final worldX = c.halfWidth - xOffset;
		final worldY = c.halfHeight - yOffset;

		final pixel = c.transform.inverse() * createPoint(worldX, worldY, -1);
		final origin = c.transform.inverse() * createPoint(0, 0, 0);
		final direction = (pixel - origin).normalize();

		return createRay(origin, direction);
	}

	public static function render(c:Camera, w:World):Canvas {
		final image = createCanvas(Std.int(c.hSize), Std.int(c.vSize));

		for (y in 0...Std.int(c.vSize) - 1) {
			for (x in 0...Std.int(c.hSize) - 1) {
				final ray = rayForPixel(c, x, y);
				final color = w.colorAt(ray);
				image.writePixel(x, y, color);
			}
		}

		return image;
	}
}
