package types;

import utils.PlaneCreator.createPlane;
import utils.TuplesCreator.createPoint;
import utils.TuplesCreator.createVector;
import utils.RayCreator.createRay;

class PlaneTest extends BuddySuite {
	public function new() {
		describe("PlaneTest", {
			describe("normalAt", {
				it("should have same normal everywhere", {
					final plane = createPlane();
					final normal = createVector(0, 1, 0);
					plane.normalAt(createPoint(0, 0, 0)).should.equal(normal);
					plane.normalAt(createPoint(10, 0, -10)).should.equal(normal);
					plane.normalAt(createPoint(-5, 0, 150)).should.equal(normal);
				});
			});
			describe("intersects", {
				it("should intersect with paralel ray", {
					final plane = createPlane();
					final ray = createRay(createPoint(0, 10, 0), createVector(0, 0, 1));
					final xs = plane.intersects(ray);
					xs.length.should.be(0);
				});
				it("should intersect with coplanar ray", {
					final plane = createPlane();
					final ray = createRay(createPoint(0, 0, 0), createVector(0, 0, 1));
					final xs = plane.intersects(ray);
					xs.length.should.be(0);
				});
				it("should intersect plane from above", {
					final plane = createPlane();
					final ray = createRay(createPoint(0, 1, 0), createVector(0, -1, 0));
					final xs = plane.intersects(ray);
					xs.length.should.be(1);
					xs[0].t.should.be(1);
					xs[0].object.should.be(plane);
				});
				it("should intersect plane from below", {
					final plane = createPlane();
					final ray = createRay(createPoint(0, -1, 0), createVector(0, 1, 0));
					final xs = plane.intersects(ray);
					xs.length.should.be(1);
					xs[0].t.should.be(1);
					xs[0].object.should.be(plane);
				});
			});
		});
	}
}
