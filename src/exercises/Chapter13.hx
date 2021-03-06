package exercises;

import utils.TuplesCreator.createPoint;
import utils.TuplesCreator.createColor;
import utils.TuplesCreator.createVector;
import utils.SphereCreator.createSphere;
import utils.ConeCreator.createCone;
import utils.CubeCreator.createCube;
import utils.CylinderCreator.createCylinder;
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

class Chapter13 {
	public function new() {
		final world = createWorld().addLight(createPointLight(createPoint(-10, 10, -10), createColor(1, 1, 1))) // .addMesh(createFloor())
			.addMesh(createFloor())
			.addMesh(createLeftWall())
			.addMesh(createRightWall())
			.addMesh(createMiddleShape())
			.addMesh(createRightShape())
			.addMesh(createLeftShape());
		final camera = createCamera(600, 300, Math.PI / 3);
		camera.transform = viewTransformation(createPoint(0, 1.5, -5), createPoint(0, 1, 0), createVector(0, 1, 0));
		File.saveContent(Path.join(["build", "chapter13.ppm"]), camera.render(world).toPPM());
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

	function createMiddleShape() {
		final shape = createCone();
		shape.minimum = 0;
		shape.maximum = 1;
		shape.transform = translation(-0.5, 1, 0.5);
		shape.material = createMaterial();
		shape.material.color = createColor(0.1, 1, 0.5);
		return shape;
	}

	function createRightShape() {
		final shape = createCylinder();
		shape.closed = true;
		shape.minimum = 0;
		shape.maximum = 1;
		shape.transform = translation(1.5, 0.5, -0.5) * scaling(0.5, 0.5, 0.5);
		shape.material = createMaterial();
		shape.material.color = createColor(0.5, 1, 0.1);
		return shape;
	}

	function createLeftShape() {
		final shape = createCylinder();
		shape.minimum = 0;
		shape.maximum = 1;
		shape.transform = translation(-1.5, 0.33, -0.75) * scaling(0.33, 0.33, 0.33);
		shape.material = createMaterial();
		shape.material.color = createColor(1, 0.8, 0.1);
		return shape;
	}
}
