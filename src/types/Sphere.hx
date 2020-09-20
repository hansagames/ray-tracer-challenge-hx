package types;

import utils.TuplesCreator.createPoint;
import utils.IntersectionCreator.createIntersection;

using utils.Tuples;
using utils.Intersections;
using utils.Rays;
using utils.Matrices;

class Sphere extends Shape {
	override function intersects(ray:Ray):Array<Intersection> {
		final transformedRay = ray.transform(transform.inverse());
		final sphereToRay = transformedRay.origin - createPoint(0, 0, 0);
		final a = transformedRay.direction.dot(transformedRay.direction);
		final b = 2 * transformedRay.direction.dot(sphereToRay);
		final c = sphereToRay.dot(sphereToRay) - 1;
		final discriminant = b * b - 4 * a * c;
		if (discriminant < 0) {
			return [];
		}
		return [
			createIntersection((-b - Math.sqrt(discriminant)) / (2 * a), this),
			createIntersection((-b + Math.sqrt(discriminant)) / (2 * a), this)
		].groupIntersections();
	}

	override function normalAt(point:Tuple):Tuple {
		final objectPoint = worldToObject(point);
		final objectNormal = objectPoint - createPoint(0, 0, 0);
		final worldNormal = normalToWorld(objectNormal);
		return worldNormal;
	}
}
