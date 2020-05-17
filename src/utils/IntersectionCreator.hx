package utils;

import types.Sphere;
import types.Intersection;

class IntersectionCreator {
	public static function createIntersection(t:Float, object:Sphere):Intersection {
		return new Intersection(t, object);
	}
}
