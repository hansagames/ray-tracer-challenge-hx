package types;

import types.Consts.Epsilon;
import utils.TuplesCreator.createVector;
import utils.IntersectionCreator.createIntersection;

using utils.Matrices;
using utils.Rays;
using utils.Tuples;

class Plane extends Shape {
	override function intersects(ray:Ray):Array<Intersection> {
		final transformedRay = ray.transform(transform.inverse());
		if (Math.abs(transformedRay.direction.y) < Epsilon) {
			return [];
		}
		final t = -transformedRay.origin.y / transformedRay.direction.y;
		return [createIntersection(t, this)];
	}

	override function normalAt(point:Tuple):Tuple {
		final objectNormal = createVector(0, 1, 0);
		final worldNormal = normalToWorld(objectNormal);
		return worldNormal;
	}
}
