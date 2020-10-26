package exercises;

import types.CSG.Operation;
import utils.CSGCreator.csg;
import utils.TuplesCreator.createPoint;
import utils.TuplesCreator.createColor;
import utils.TuplesCreator.createVector;
import utils.SphereCreator.createSphere;
import utils.CubeCreator.createCube;
import utils.Transformation.viewTransformation;
import utils.Transformation.translation;
import utils.WorldCreator.createWorld;
import utils.PointLightCreator.createPointLight;
import utils.CameraCreator.createCamera;
import sys.io.File;
import haxe.io.Path;

using utils.CanvasPPM;
using utils.Cameras;

class Chapter16 {
	public function new() {
		final world = createWorld().addLight(createPointLight(createPoint(-10, 10, -10), createColor(1, 1, 1))).addMesh(testCSG());
		final camera = createCamera(600, 300, Math.PI / 2);
		camera.transform = viewTransformation(createPoint(0, 2.5, -5), createPoint(0, 1, 0), createVector(0, 1, 0));
		File.saveContent(Path.join(["build", "chapter16.ppm"]), camera.render(world).toPPM());
	}
	public function testCSG() {
		final s1 = createCube();
		final s2 = createSphere();
		s1.transform = translation(0.5, 0, 0);
		return csg(Operation.Intersection, s2, s1);
	}
}
