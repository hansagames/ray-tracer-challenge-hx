package utils;

import types.Shape;
import types.Intersection;

class IntersectionCreator {
	public static function createIntersection(t:Float, object:Shape):Intersection {
		return new Intersection(t, object);
	}
}
