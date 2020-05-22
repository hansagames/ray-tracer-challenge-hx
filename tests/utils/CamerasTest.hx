package utils;

import utils.Cameras.rayForPixel;
import utils.Cameras.render;
import utils.CameraCreator.createCamera;
import utils.TuplesCreator.createVector;
import utils.TuplesCreator.createPoint;
import utils.TuplesCreator.createColor;
import utils.Transformation.rotationY;
import utils.Transformation.translation;
import utils.Transformation.viewTransformation;
import utils.WorldCreator.createDefaultWorld;

class CamerasTest extends BuddySuite {
	public function new() {
		describe("CamerasTest", {
			describe("rayForPixel", {
				it("should construct ray through center of canvas", {
					final c = createCamera(201, 101, Math.PI * 0.5);
					final r = rayForPixel(c, 100, 50);
					r.origin.should.equal(createPoint(0, 0, 0));
					r.direction.should.equal(createVector(0, 0, -1));
				});
				it("should construct ray through corner of canvas", {
					final c = createCamera(201, 101, Math.PI * 0.5);
					final r = rayForPixel(c, 0, 0);
					r.origin.should.equal(createPoint(0, 0, 0));
					r.direction.should.equal(createVector(0.66519, 0.33259, -0.66851));
				});
				it("should construct ray with transformed camera", {
					final c = createCamera(201, 101, Math.PI * 0.5);
					c.transform = rotationY(Math.PI / 4) * translation(0, -2, 5);
					final r = rayForPixel(c, 100, 50);
					r.origin.should.equal(createPoint(0, 2, -5));
					r.direction.should.equal(createVector(Math.sqrt(2) / 2, 0, -Math.sqrt(2) / 2));
				});
			});
			describe("render", {
				it("should render world with camera", {
					final w = createDefaultWorld();
					final c = createCamera(11, 11, Math.PI * 0.5);
					final from = createPoint(0, 0, -5);
					final to = createPoint(0, 0, 0);
					final up = createVector(0, 1, 0);
					c.transform = viewTransformation(from, to, up);
					final image = render(c, w);
					image.pixelAt(5, 5).should.equal(createColor(0.38066, 0.47583, 0.2855));
				});
			});
		});
	}
}
