package types;

import utils.TuplesCreator.createPoint;
import utils.IntersectionCreator.createIntersection;
import types.Consts.Epsilon;

using utils.Tuples;
using utils.Intersections;
using utils.Rays;
using utils.Matrices;

class Triangle extends Shape {
	public var p1: Tuple;
	public var p2: Tuple;
	public var p3: Tuple;
	public var e1: Tuple;
	public var e2: Tuple;
	public var normal: Tuple;
	public function new(p1: Tuple, p2: Tuple, p3: Tuple) {
		super();
		this.p1 = p1;
		this.p2 = p2;
		this.p3 = p3;
		e1 = p2 - p1;
		e2 = p3 - p1;
		normal = e2.cross(e1).normalize();
	}
	override function intersects(ray:Ray):Array<Intersection> {
		final transformedRay = ray.transform(transform.inverse());
		final dirCrossE2 = transformedRay.direction.cross(e2);
		final det = e1.dot(dirCrossE2);
		if (Math.abs(det) < Epsilon) {
			return [];
		}
		final f = 1 / det;
		final p1ToOrigin = transformedRay.origin - p1;
		final u  = f * p1ToOrigin.dot(dirCrossE2);
		if (u < 0 || u > 1) {
			return [];
		}
		final originCrossE1 = p1ToOrigin.cross(e1);
		final v = f * transformedRay.direction.dot(originCrossE1);
		if (v < 0 || v + u > 1) {
			return [];
		}
		final t = f * e2.dot(originCrossE1);
		return [
			createIntersection(t, this)
		].groupIntersections();
	}

	override function normalAt(point:Tuple, ?i: Intersection):Tuple {
		return normalToWorld(normal);
	}
}
