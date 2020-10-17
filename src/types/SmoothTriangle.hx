package types;

import utils.TuplesCreator.createPoint;
import utils.IntersectionCreator.createIntersectionWithUV;
import types.Consts.Epsilon;

using utils.Tuples;
using utils.Intersections;
using utils.Rays;
using utils.Matrices;

class SmoothTriangle extends Shape {
	public var p1: Tuple;
	public var p2: Tuple;
	public var p3: Tuple;
	public var n1: Tuple;
	public var n2: Tuple;
	public var n3: Tuple;
	public var e1: Tuple;
	public var e2: Tuple;
	public function new(p1: Tuple, p2: Tuple, p3: Tuple, n1: Tuple, n2: Tuple, n3: Tuple) {
		super();
		this.p1 = p1;
		this.p2 = p2;
		this.p3 = p3;
		this.n1 = n1;
		this.n2 = n2;
		this.n3 = n3;
		e1 = p2 - p1;
		e2 = p3 - p1;
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
		if (v < 0 || u + v > 1) {
			return [];
		}
		final t = f * e2.dot(originCrossE1);
		return [
			createIntersectionWithUV(t, this, u, v)
		].groupIntersections();
	}

	override function normalAt(point:Tuple, ?i: Intersection):Tuple {
		if (i != null) {
			return normalToWorld(n2 * i.u + n3 * i.v + n1 * (1 - i.u - i.v));
		} 
		return super.normalAt(point, i);
	}
}
