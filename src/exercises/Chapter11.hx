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
import utils.Transformation.rotationZ;
import utils.Transformation.viewTransformation;
import utils.WorldCreator.createWorld;
import utils.PointLightCreator.createPointLight;
import utils.CameraCreator.createCamera;
import utils.PlaneCreator.createPlane;
import utils.Paterns.checkerPattern;
import utils.Paterns.ringPattern;
import utils.Paterns.stripePattern;
import utils.Paterns.gradientPattern;
import sys.io.File;
import haxe.io.Path;

using utils.CanvasPPM;
using utils.Cameras;

class Chapter11 {
	public function new() {
		final world = createWorld().addLight(createPointLight(createPoint(-10, 10, -10), createColor(1, 1, 1))) // .addMesh(createFloor())
			.addMesh(createFloor())
			.addMesh(createLeftWall())
			.addMesh(createRightWall())
			.addMesh(createMiddleSphere())
			.addMesh(createRightSphere())
			.addMesh(createLeftSphere());
		final camera = createCamera(600, 300, Math.PI / 3);
		camera.transform = viewTransformation(createPoint(0, 1.5, -5), createPoint(0, 1, 0), createVector(0, 1, 0));
		File.saveContent(Path.join(["build", "chapter11.ppm"]), camera.render(world).toPPM());
	}

	function createFloor() {
		final floor = createPlane();
		floor.material = createMaterial();
		floor.material.color = createColor(1, 0.9, 0.9);
		floor.material.specular = 0;
		floor.material.reflective = 0.9;

		final pattern = checkerPattern(createColor(1, 0, 0), createColor(0, 0, 1));
		pattern.transform = rotationY(Math.PI * 0.25);
		floor.material.pattern = pattern;
		return floor;
	}

	function createLeftWall() {
		final wall = createPlane();
		wall.transform = translation(0, 0, 5) * rotationY(-Math.PI / 4) * rotationX(Math.PI * 0.5);
		wall.material = createMaterial();
		wall.material.color = createColor(1, 0.9, 0.9);
		wall.material.specular = 0;
		wall.material.reflective = 0;
		final pattern = ringPattern(createColor(1, 0, 0), createColor(0, 1, 0));
		wall.material.pattern = pattern;
		pattern.transform = rotationY(Math.PI * 0.25);
		return wall;
	}

	function createRightWall() {
		final wall = createPlane();
		wall.transform = translation(0, 0, 5) * rotationY(Math.PI / 4) * rotationX(Math.PI * 0.5);
		wall.material = createMaterial();
		wall.material.color = createColor(1, 0.9, 0.9);
		wall.material.specular = 0;
		wall.material.reflective = 0;
		return wall;
	}

	function createMiddleSphere() {
		final sphere = createSphere();
		sphere.transform = translation(-0.5, 1, 0.5);
		sphere.material = createMaterial();
		sphere.material.color = createColor(0.1, 1, 0.5);
		sphere.material.diffuse = 0.2;
		sphere.material.ambient = 0.2;
		sphere.material.specular = 0.9;
		sphere.material.reflective = 0.9;
		sphere.material.transparency = 0.9;
		return sphere;
	}

	function createRightSphere() {
		final sphere = createSphere();
		sphere.transform = translation(1.5, 0.5, -0.5) * scaling(0.5, 0.5, 0.5);
		sphere.material = createMaterial();
		sphere.material.color = createColor(0.5, 1, 0.1);
		sphere.material.diffuse = 0.2;
		sphere.material.ambient = 0.2;
		sphere.material.specular = 0.9;
		sphere.material.reflective = 0.9;
		sphere.material.transparency = 0.9;
		return sphere;
	}

	function createLeftSphere() {
		final sphere = createSphere();
		sphere.transform = translation(-1.5, 0.33, -0.75) * scaling(0.33, 0.33, 0.33);
		sphere.material = createMaterial();
		sphere.material.color = createColor(1, 0.8, 0.1);
		sphere.material.diffuse = 0.2;
		sphere.material.ambient = 0.2;
		sphere.material.specular = 0.9;
		sphere.material.reflective = 0.9;
		sphere.material.transparency = 0.9;
		return sphere;
	}
}
