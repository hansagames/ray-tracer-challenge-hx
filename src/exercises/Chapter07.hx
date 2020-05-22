package exercises;

import utils.TuplesCreator.createPoint;
import utils.TuplesCreator.createColor;
import utils.TuplesCreator.createVector;
import utils.SphereCreator.createSphere;
import utils.MaterialsCreator.createMaterial;
import utils.Transformation.scaling;
import utils.Transformation.translation;
import utils.Transformation.rotationY;
import utils.Transformation.rotationX;
import utils.Transformation.viewTransformation;
import utils.WorldCreator.createWorld;
import utils.PointLightCreator.createPointLight;
import utils.CameraCreator.createCamera;
import sys.io.File;
import haxe.io.Path;

using utils.CanvasPPM;
using utils.Cameras;

class Chapter07 {
	public function new() {
		final world = createWorld().addLight(createPointLight(createPoint(-10, 10, -10), createColor(1, 1, 1)))
			.addMesh(createFloor())
			.addMesh(createLeftWall())
			.addMesh(createRightWall())
			.addMesh(createMiddleSphere())
			.addMesh(createRightSphere())
			.addMesh(createLeftSphere());
		final camera = createCamera(600, 300, Math.PI / 3);
		camera.transform = viewTransformation(createPoint(0, 1.5, -5), createPoint(0, 1, 0), createVector(0, 1, 0));
		File.saveContent(Path.join(["build", "chapter07.ppm"]), camera.render(world).toPPM());
	}

	function createFloor() {
		final sphere = createSphere();
		sphere.transform = scaling(10, 0.01, 10);
		sphere.material = createMaterial();
		sphere.material.color = createColor(1, 0.9, 0.9);
		sphere.material.specular = 0;
		return sphere;
	}

	function createLeftWall() {
		final sphere = createSphere();
		sphere.transform = translation(0, 0, 5) * rotationY(-Math.PI / 4) * rotationX(Math.PI * 0.5) * scaling(10, 0.01, 10);
		sphere.material = createMaterial();
		sphere.material.color = createColor(1, 0.9, 0.9);
		sphere.material.specular = 0;
		return sphere;
	}

	function createRightWall() {
		final sphere = createSphere();
		sphere.transform = translation(0, 0, 5) * rotationY(Math.PI / 4) * rotationX(Math.PI * 0.5) * scaling(10, 0.01, 10);
		sphere.material = createMaterial();
		sphere.material.color = createColor(1, 0.9, 0.9);
		sphere.material.specular = 0;
		return sphere;
	}

	function createMiddleSphere() {
		final sphere = createSphere();
		sphere.transform = translation(-0.5, 1, 0.5);
		sphere.material = createMaterial();
		sphere.material.color = createColor(0.1, 1, 0.5);
		sphere.material.diffuse = 0.7;
		sphere.material.specular = 0.3;
		return sphere;
	}

	function createRightSphere() {
		final sphere = createSphere();
		sphere.transform = translation(1.5, 0.5, -0.5) * scaling(0.5, 0.5, 0.5);
		sphere.material = createMaterial();
		sphere.material.color = createColor(0.5, 1, 0.1);
		sphere.material.diffuse = 0.7;
		sphere.material.specular = 0.3;
		return sphere;
	}

	function createLeftSphere() {
		final sphere = createSphere();
		sphere.transform = translation(-1.5, 0.33, -0.75) * scaling(0.33, 0.33, 0.33);
		sphere.material = createMaterial();
		sphere.material.color = createColor(1, 0.8, 0.1);
		sphere.material.diffuse = 0.7;
		sphere.material.specular = 0.3;
		return sphere;
	}
}
