package types;

import utils.TuplesCreator.createPoint;
import utils.TuplesCreator.createVector;
import utils.IntersectionCreator.createIntersection;
import types.Consts.Epsilon;

using utils.Tuples;
using utils.Intersections;
using utils.Rays;
using utils.Matrices;

private typedef MinMax = {
	var min:Float;
	var max:Float;
}

class Cube extends Shape {
	override function intersects(originalRay:Ray):Array<Intersection> {
		final ray = originalRay.transform(transform.inverse());
		final xMinMax:MinMax = checkAxis(ray.origin.x, ray.direction.x);
		final yMinMax:MinMax = checkAxis(ray.origin.y, ray.direction.y);
		final zMinMax:MinMax = checkAxis(ray.origin.z, ray.direction.z);
		final tMin = Math.max(Math.max(xMinMax.min, yMinMax.min), zMinMax.min);
		final tMax = Math.min(Math.min(xMinMax.max, yMinMax.max), zMinMax.max);
		if (tMin > tMax) {
			return [];
		}
		return [createIntersection(tMin, this), createIntersection(tMax, this)].groupIntersections();
	}

	override function normalAt(point:Tuple):Tuple {
		final maxc = Math.max(Math.max(Math.abs(point.x), Math.abs(point.y)), Math.abs(point.z));
		if (maxc == Math.abs(point.x)) {
			return createVector(point.x, 0, 0);
		} else if (maxc == Math.abs(point.y)) {
			return createVector(0, point.y, 0);
		}
		return return createVector(0, 0, point.z);
	}

	private function checkAxis(origin:Float, direction:Float):MinMax {
		final tMinNumerator = -1 - origin;
		final tMaxNumerator = 1 - origin;

		var tMin = 0.0;
		var tMax = 0.0;

		if (Math.abs(direction) >= Epsilon) {
			tMin = tMinNumerator / direction;
			tMax = tMaxNumerator / direction;
		} else {
			tMin = tMinNumerator * Math.POSITIVE_INFINITY;
			tMax = tMaxNumerator * Math.POSITIVE_INFINITY;
		}

		if (tMin > tMax) {
			final temp = tMin;
			tMin = tMax;
			tMax = temp;
		}

		return {
			min: tMin,
			max: tMax
		}
	}
}
