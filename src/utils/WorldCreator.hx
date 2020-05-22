package utils;

import types.World;
import utils.PointLightCreator.createPointLight;
import utils.TuplesCreator.createPoint;
import utils.TuplesCreator.createColor;
import utils.SphereCreator.createSphere;
import utils.Transformation.scaling;
import utils.MaterialsCreator.createMaterial;

class WorldCreator {
	public static function createWorld():World {
		return new World();
	}

	public static function createDefaultWorld():World {
		final w = createWorld();
		final light = createPointLight(createPoint(-10, 10, -10), createColor(1, 1, 1));
		final s1 = createSphere();
		final s2 = createSphere();
		final s1Material = createMaterial();
		s1Material.color = createColor(0.8, 1.0, 0.6);
		s1Material.diffuse = 0.7;
		s1Material.specular = 0.2;
		s1.material = s1Material;
		s2.transform = scaling(0.5, 0.5, 0.5);
		return w.addLight(light).addMesh(s1).addMesh(s2);
	}
}
