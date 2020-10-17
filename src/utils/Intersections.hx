package utils;

import types.Shape;
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
		for (i in source) {
			if (isHit(i)) {
				return i;
			}
		}
		return null;
	}

	private static function isHit(i:Intersection):Bool {
		return i.t >= 0.0;
	}

	public static function prepeareComputation(intersection:Intersection, ray:Ray, intersections:Array<Intersection>):IntersectionData {
		final data = new IntersectionData();
		data.t = intersection.t;
		data.object = intersection.object;
		data.point = ray.position(data.t);
		data.eyeView = -ray.direction;
		data.normal = data.object.normalAt(data.point, intersection);

		if (data.normal.dot(data.eyeView) <= 0) {
			data.inside = true;
			data.normal = -data.normal;
		} else {
			data.inside = false;
		}

		data.overPoint = data.point + data.normal * Epsilon;
		data.underPoint = data.point - data.normal * Epsilon;
		data.reflect = ray.direction.reflect(data.normal);

		calculateN1AndN2(intersection, intersections, data);
		return data;
	}

	private static function calculateN1AndN2(current:Intersection, source:Array<Intersection>, data:IntersectionData):Void {
		final container:Array<Shape> = [];

		for (i in source) {
			if (i == current) {
				if (container.length == 0) {
					data.n1 = 1.0;
				} else {
					data.n1 = container[container.length - 1].material.refractiveIndex;
				}
			}
			if (container.indexOf(i.object) >= 0) {
				container.splice(container.indexOf(i.object), 1);
			} else {
				container.push(i.object);
			}
			if (i == current) {
				if (container.length == 0) {
					data.n2 = 1.0;
				} else {
					data.n2 = container[container.length - 1].material.refractiveIndex;
				}
			}
		}
	}

	private static function sortIntersections(a:Intersection, b:Intersection):Int {
		if (a.t < b.t) {
			return -1;
		} else if (a.t > b.t) {
			return 1;
		}
		return 0;
	}

	public static function shlick(data:IntersectionData):Float {
		var cos = data.eyeView.dot(data.normal);
		if (data.n1 > data.n2) {
			final n = data.n1 / data.n2;
			final sin2_t = n * n * (1.0 - cos * cos);
			if (sin2_t > 1) {
				return 1.0;
			}
			cos = Math.sqrt(1 - sin2_t);
		}
		final r0 = Math.pow((data.n1 - data.n2) / (data.n1 + data.n2), 2);
		return r0 + (1 - r0) * Math.pow(1 - cos, 5);
	}
}
