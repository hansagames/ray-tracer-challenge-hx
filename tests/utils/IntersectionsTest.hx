package utils;

import utils.IntersectionCreator.createIntersection;
import utils.SphereCreator.createSphere;
import utils.RayCreator.createRay;
import utils.TuplesCreator.createVector;
import utils.TuplesCreator.createPoint;

using utils.Intersections;

class IntersectionsTest extends BuddySuite {
	public function new() {
		describe("IntersectionsTest", {
			describe("groupIntersections", {
				it("should aggregate intersections", {
					final sphere = createSphere();
					final i1 = createIntersection(1, sphere);
					final i2 = createIntersection(2, sphere);
					final xs = [i1, i2].groupIntersections();
					xs.length.should.be(2);
					xs[0].t.should.be(1);
					xs[1].t.should.be(2);
				});
			});
			describe("hit", {
				it("should calculate hit when all intersections have positive t", {
					final sphere = createSphere();
					final i1 = createIntersection(1, sphere);
					final i2 = createIntersection(2, sphere);
					final xs = [i2, i1].groupIntersections();
					xs.hit().should.be(i1);
				});
				it("should calculate hit when some intersections have negative t", {
					final sphere = createSphere();
					final i1 = createIntersection(-1, sphere);
					final i2 = createIntersection(1, sphere);
					final xs = [i2, i1].groupIntersections();
					xs.hit().should.be(i2);
				});
				it("should calculate hit when all intersections have negative t", {
					final sphere = createSphere();
					final i1 = createIntersection(-2, sphere);
					final i2 = createIntersection(-1, sphere);
					final xs = [i2, i1].groupIntersections();
					xs.hit().should.be(null);
				});
				it("should always return lowest non negative intersection", {
					final sphere = createSphere();
					final i1 = createIntersection(5, sphere);
					final i2 = createIntersection(7, sphere);
					final i3 = createIntersection(-3, sphere);
					final i4 = createIntersection(2, sphere);
					final xs = [i1, i2, i3, i4].groupIntersections();
					xs.hit().should.be(i4);
				});
			});
			describe("prepeareComputation", {
				it("should precompute state of intersection", {
					final ray = createRay(createPoint(0, 0, -5), createVector(0, 0, 1));
					final shape = createSphere();
					final i = createIntersection(4, shape);
					final comps = i.prepeareComputation(ray);
					comps.t.should.be(i.t);
					comps.object.should.be(shape);
					comps.point.should.equal(createPoint(0, 0, -1));
					comps.eyeView.should.equal(createVector(0, 0, -1));
					comps.normal.should.equal(createVector(0, 0, -1));
				});
				it("should hit when an intersection occurs on the outside", {
					final ray = createRay(createPoint(0, 0, -5), createVector(0, 0, 1));
					final shape = createSphere();
					final i = createIntersection(4, shape);
					final comps = i.prepeareComputation(ray);
					comps.inside.should.be(false);
				});
				it("should hit when an intersection occurs on the inside", {
					final ray = createRay(createPoint(0, 0, 0), createVector(0, 0, 1));
					final shape = createSphere();
					final i = createIntersection(1, shape);
					final comps = i.prepeareComputation(ray);
					comps.point.should.equal(createPoint(0, 0, 1));
					comps.eyeView.should.equal(createVector(0, 0, -1));
					comps.inside.should.be(true);
					comps.normal.should.equal(createVector(0, 0, -1));
				});
			});
		});
	}
}
