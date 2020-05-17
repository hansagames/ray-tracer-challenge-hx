package utils;

import types.Intersection;

class Intersections {
	public static function groupIntersections(source:Array<Intersection>):Array<Intersection> {
		final copy = source.slice(0);
		copy.sort(sortIntersections);
		return copy;
	}

	public static function hit(source:Array<Intersection>):Null<Intersection> {
		for (hit in source) {
			if (hit.t >= 0) {
				return hit;
			}
		}
		return null;
	}

	private static function sortIntersections(a:Intersection, b:Intersection):Int {
		if (a.t < b.t) {
			return -1;
		} else if (a.t > b.t) {
			return 1;
		}
		return 0;
	}
}
