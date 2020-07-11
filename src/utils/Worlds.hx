package utils;

import types.IntersectionData;
import types.Tuple;
import types.Intersection;
import types.Ray;
import types.World;
import utils.MaterialsCreator.lighting;
import utils.TuplesCreator.createColor;
import utils.RayCreator.createRay;

using utils.Intersections;
using utils.Tuples;

class Worlds {
	public static function intersects(w:World, ray:Ray) {
		var intersections:Array<Intersection> = [];
		for (mesh in w.meshes) {
			intersections = intersections.concat(mesh.intersects(ray));
		}
		return intersections.groupIntersections();
	}

	public static function shadeHit(w:World, data:IntersectionData, remaining:UInt = 5):Tuple {
		final surface = lighting(data.object.material, data.object, w.lights[0], data.point, data.eyeView, data.normal, isShadowed(w, data.overPoint));
		final reflected = reflectedColor(w, data, remaining);
		final refracted = refractedColor(w, data, remaining);
		final material = data.object.material;
		if (material.reflective > 0 && material.transparency > 0) {
			final reflectance = data.shlick();
			return surface + reflected * reflectance + refracted * (1 - reflectance);
		}
		return surface + reflected + refracted;
	}

	public static function colorAt(w:World, ray:Ray, remaining:UInt = 5):Tuple {
		final intersections = intersects(w, ray);
		final hit = intersections.hit();
		if (hit == null) {
			return createColor(0, 0, 0);
		} else {
			return shadeHit(w, hit.prepeareComputation(ray, intersections), remaining);
		}
	}

	public static function isShadowed(w:World, p:Tuple):Bool {
		final v = w.lights[0].position - p;
		final distance = v.magnitude();
		final ray = createRay(p, v.normalize());
		final hit = intersects(w, ray).hit();
		return hit != null && hit.t < distance;
	}

	public static function reflectedColor(w:World, data:IntersectionData, remaining:UInt):Tuple {
		if (remaining <= 0 || data.object.material.reflective == 0) {
			return createColor(0, 0, 0);
		}
		final ray = createRay(data.overPoint, data.reflect);
		final color = colorAt(w, ray, remaining - 1);
		return color * data.object.material.reflective;
	}

	public static function refractedColor(w:World, data:IntersectionData, remaining:UInt):Tuple {
		if (data.object.material.transparency == 0 || remaining == 0) {
			return createColor(0, 0, 0);
		}
		final nRatio = data.n1 / data.n2;
		final cosI = data.eyeView.dot(data.normal);
		final sin2t = (nRatio * nRatio) * (1 - cosI * cosI);
		if (sin2t > 1) {
			return createColor(0, 0, 0);
		}

		final costT = Math.sqrt(1 - sin2t);
		final direction = data.normal * (nRatio * cosI - costT) - data.eyeView * nRatio;
		final refractedRay = createRay(data.underPoint, direction);

		return colorAt(w, refractedRay, remaining - 1) * data.object.material.transparency;
	}
}
