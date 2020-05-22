package utils;

import types.IntersectionData;
import types.Tuple;
import types.Intersection;
import types.Ray;
import types.World;
import utils.MaterialsCreator.lighting;
import utils.TuplesCreator.createColor;

using utils.Spheres;
using utils.Intersections;

class Worlds {
	public static function intersects(w:World, ray:Ray) {
		var intersections:Array<Intersection> = [];
		for (mesh in w.meshes) {
			intersections = intersections.concat(mesh.intersects(ray));
		}
		return intersections.groupIntersections();
	}

	public static function shadeHit(w:World, data:IntersectionData):Tuple {
		return lighting(data.object.material, w.lights[0], data.point, data.eyeView, data.normal);
	}

	public static function colorAt(w:World, ray:Ray):Tuple {
		final hit = intersects(w, ray).hit();
		if (hit == null) {
			return createColor(0, 0, 0);
		} else {
			return shadeHit(w, hit.prepeareComputation(ray));
		}
	}
}
