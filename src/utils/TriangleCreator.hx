package utils;

import types.SmoothTriangle;
import types.Tuple;
import types.Triangle;

class TriangleCreator {
	public static function createTriangle(p1: Tuple, p2: Tuple, p3: Tuple):Triangle {
		return new Triangle(p1, p2, p3);
	}
	public static function createSmoothTriangle(p1: Tuple, p2: Tuple, p3: Tuple, n1: Tuple, n2: Tuple, n3: Tuple):SmoothTriangle {
		return new SmoothTriangle(p1, p2, p3, n1, n2, n3);
	}
}
