package exercises;

import utils.TuplesCreator.createPoint;
import utils.TuplesCreator.createColor;
import utils.TuplesCreator.createVector;
import utils.SphereCreator.createSphere;
import utils.CylinderCreator.createCylinder;
import utils.GroupCreator.createGroup;
import utils.Transformation.scaling;
import utils.Transformation.translation;
import utils.Transformation.rotationY;
import utils.Transformation.rotationZ;
import utils.Transformation.viewTransformation;
import utils.WorldCreator.createWorld;
import utils.PointLightCreator.createPointLight;
import utils.CameraCreator.createCamera;
import sys.io.File;
import haxe.io.Path;

using utils.CanvasPPM;
using utils.Cameras;

class Chapter14 {
	public function new() {
		final world = createWorld().addLight(createPointLight(createPoint(-10, 10, -10), createColor(1, 1, 1))).addMesh(hexagon());
		final camera = createCamera(600, 300, Math.PI / 2);
		camera.transform = viewTransformation(createPoint(0, 2.5, -5), createPoint(0, 1, 0), createVector(0, 1, 0));
		File.saveContent(Path.join(["build", "chapter14.ppm"]), camera.render(world).toPPM());
	}

	function corner() {
		final corner = createSphere();
		corner.transform = translation(0, 0, -1) * scaling(0.25, 0.25, 0.25);
		return corner;
	}

	function edge() {
		final edge = createCylinder();
		edge.minimum = 0;
		edge.maximum = 1;
		edge.transform = translation(0, 0, -1) * rotationY(-Math.PI / 6) * rotationZ(-Math.PI * 0.5) * scaling(0.25, 1, 0.25);
		return edge;
	}

	function side() {
		final side = createGroup();
		side.addChild(corner());
		side.addChild(edge());
		return side;
	}

	function hexagon() {
		final hexagon = createGroup();
		for (i in 0...5) {
			final s = side();
			s.transform = rotationY(i * Math.PI / 3);
			hexagon.addChild(s);
		}
		return hexagon;
	}
}
