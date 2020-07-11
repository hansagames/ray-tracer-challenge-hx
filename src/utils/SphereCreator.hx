package utils;

import types.Sphere;

class SphereCreator {
	public static function createSphere():Sphere {
		return new Sphere();
	}

	public static function glassSphere():Sphere {
		final s = createSphere();
		s.material.transparency = 1.0;
		s.material.refractiveIndex = 1.5;
		return s;
	}
}
