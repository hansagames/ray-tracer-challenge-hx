package utils;

import types.Intersection;
import types.Sphere;
import types.Ray;
import utils.TuplesCreator.createPoint;
import utils.IntersectionCreator.createIntersection;

using utils.Tuples;
using utils.Intersections;
using utils.Rays;
using utils.Matrices;

class Spheres {
	public static function intersects(sphere:Sphere, ray:Ray):Array<Intersection> {
		final transformedRay = ray.transform(sphere.transform.inverse());
		final sphereToRay = transformedRay.origin - createPoint(0, 0, 0);
		final a = transformedRay.direction.dot(transformedRay.direction);
		final b = 2 * transformedRay.direction.dot(sphereToRay);
		final c = sphereToRay.dot(sphereToRay) - 1;
		final discriminant = b * b - 4 * a * c;
		if (discriminant < 0) {
			return [];
		}
		return [
			createIntersection((-b - Math.sqrt(discriminant)) / (2 * a), sphere),
			createIntersection((-b + Math.sqrt(discriminant)) / (2 * a), sphere)
		].groupIntersections();
	}
}
