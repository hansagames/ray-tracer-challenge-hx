package types;

import types.Consts.Epsilon;
import utils.IntersectionCreator.createIntersection;
import utils.TuplesCreator.createVector;

using utils.Tuples;
using utils.Intersections;
using utils.Rays;
using utils.Matrices;

class Cylinder extends Shape {
	public var minimum:Float = Math.NEGATIVE_INFINITY;
	public var maximum:Float = Math.POSITIVE_INFINITY;

	public var closed = false;

	override function intersects(originalRay:Ray):Array<Intersection> {
		final ray = originalRay.transform(transform.inverse());
		final a = ray.direction.x * ray.direction.x + ray.direction.z * ray.direction.z;
		final xs:Array<Intersection> = [];
		if (a >= Epsilon || a <= -Epsilon) {
			final b = 2 * ray.origin.x * ray.direction.x + 2 * ray.origin.z * ray.direction.z;
			final c = (ray.origin.x * ray.origin.x + ray.origin.z * ray.origin.z) - 1;
			final disc = b * b - 4 * a * c;

			if (disc < 0) {
				return xs;
			}
			var t0 = (-b - Math.sqrt(disc)) / (2 * a);
			var t1 = (-b + Math.sqrt(disc)) / (2 * a);

			if (t0 > t1) {
				final tempT0 = t0;
				t0 = t1;
				t1 = tempT0;
			}

			final y0 = ray.origin.y + t0 * ray.direction.y;
			final y1 = ray.origin.y + t1 * ray.direction.y;

			if (this.minimum < y0 && y0 < this.maximum) {
				xs.push(createIntersection(t0, this));
			}
			if (this.minimum < y1 && y1 < this.maximum) {
				xs.push(createIntersection(t1, this));
			}
		}

		intersectCaps(ray, xs);

		return xs;
	}

	override function normalAt(point:Tuple):Tuple {
		final dist = point.x * point.x + point.z * point.z;
		if (dist < 1 && point.y >= maximum - Epsilon) {
			return createVector(0, 1, 0);
		} else if (dist < 1 && point.y <= minimum + Epsilon) {
			return createVector(0, -1, 0);
		}
		return createVector(point.x, 0, point.z);
	}

	private function checkCap(ray:Ray, t:Float):Bool {
		final x = ray.origin.x + t * ray.direction.x;
		final z = ray.origin.z + t * ray.direction.z;
		return (x * x + z * z) <= 1;
	}

	private function intersectCaps(ray:Ray, xs:Array<Intersection>) {
		if (closed) {
			var t = (minimum - ray.origin.y) / ray.direction.y;
			if (checkCap(ray, t)) {
				xs.push(createIntersection(t, this));
			}
			t = (maximum - ray.origin.y) / ray.direction.y;
			if (checkCap(ray, t)) {
				xs.push(createIntersection(t, this));
			}
		}
	}
}
