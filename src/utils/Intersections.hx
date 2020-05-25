package utils;

import types.IntersectionData;
import types.Ray;
import types.Intersection;
import types.Consts.Epsilon;

using utils.Rays;
using utils.Tuples;

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

	public static function prepeareComputation(intersection:Intersection, ray:Ray):IntersectionData {
		final data = new IntersectionData();
		data.t = intersection.t;
		data.object = intersection.object;
		data.point = ray.position(data.t);
		data.eyeView = -ray.direction;
		data.normal = data.object.normalAt(data.point);

		if (data.normal.dot(data.eyeView) <= 0) {
			data.inside = true;
			data.normal = -data.normal;
		} else {
			data.inside = false;
		}

		data.overPoint = data.point + data.normal * Epsilon;
		return data;
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
