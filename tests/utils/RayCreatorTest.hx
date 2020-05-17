package utils;

import utils.TuplesCreator.createPoint;
import utils.TuplesCreator.createVector;
import utils.RayCreator.createRay;

class RayCreatorTest extends BuddySuite {
	public function new() {
		describe("RayCreatorTest", {
			describe("createRay", {
				it("should create ray", {
					final origin = createPoint(1, 2, 3);
					final direction = createVector(4, 5, 6);
					final ray = createRay(origin, direction);
					ray.direction.should.equal(direction);
					ray.origin.should.equal(origin);
				});
			});
		});
	}
}
