package utils;

import utils.TuplesCreator.createVector;
import utils.TuplesCreator.createPoint;
import utils.RayCreator.createRay;
import utils.Transformation.translation;
import utils.Transformation.scaling;

using utils.Rays;

class RaysTest extends BuddySuite {
	public function new() {
		describe("RaysTest", {
			describe("position", {
				it("should compute point from a distance", {
					final ray = createRay(createPoint(2, 3, 4), createVector(1, 0, 0));
					ray.position(0).should.equal(createPoint(2, 3, 4));
					ray.position(1).should.equal(createPoint(3, 3, 4));
					ray.position(-1).should.equal(createPoint(1, 3, 4));
					ray.position(2.5).should.equal(createPoint(4.5, 3, 4));
				});
			});
			describe("transform", {
				it("should translate ray", {
					final ray = createRay(createPoint(1, 2, 3), createVector(0, 1, 0));
					final m = translation(3, 4, 5);
					final transformedRay = ray.transform(m);
					transformedRay.origin.should.equal(createPoint(4, 6, 8));
					transformedRay.direction.should.equal(createVector(0, 1, 0));
				});
				it("should scale ray", {
					final ray = createRay(createPoint(1, 2, 3), createVector(0, 1, 0));
					final m = scaling(2, 3, 4);
					final transformedRay = ray.transform(m);
					transformedRay.origin.should.equal(createPoint(2, 6, 12));
					transformedRay.direction.should.equal(createVector(0, 3, 0));
				});
			});
		});
	}
}
