package utils;

import utils.IntersectionCreator.createIntersection;
import utils.SphereCreator.createSphere;
import utils.SphereCreator.glassSphere;
import utils.PlaneCreator.createPlane;
import utils.RayCreator.createRay;
import utils.TuplesCreator.createVector;
import utils.TuplesCreator.createPoint;
import utils.Transformation.translation;
import utils.Transformation.scaling;
import types.Consts.Epsilon;

using utils.Intersections;
using Lambda;
using utils.Numbers;

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
					final comps = i.prepeareComputation(ray, [i]);
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
					final comps = i.prepeareComputation(ray, [i]);
					comps.inside.should.be(false);
				});
				it("should hit when an intersection occurs on the inside", {
					final ray = createRay(createPoint(0, 0, 0), createVector(0, 0, 1));
					final shape = createSphere();
					final i = createIntersection(1, shape);
					final comps = i.prepeareComputation(ray, [i]);
					comps.point.should.equal(createPoint(0, 0, 1));
					comps.eyeView.should.equal(createVector(0, 0, -1));
					comps.inside.should.be(true);
					comps.normal.should.equal(createVector(0, 0, -1));
				});
				it("should offset the point", {
					final ray = createRay(createPoint(0, 0, -5), createVector(0, 0, 1));
					final shape = createSphere();
					shape.transform = translation(0, 0, 1);
					final i = createIntersection(5, shape);
					final comps = i.prepeareComputation(ray, [i]);
					comps.overPoint.z.should.beLessThan(-Epsilon * 0.5);
					comps.point.z.should.beGreaterThan(comps.overPoint.z);
				});
				it("should calculate reflection vector", {
					final shape = createPlane();
					final ray = createRay(createPoint(0, 1, -1), createVector(0, -Math.sqrt(2) * 0.5, Math.sqrt(2) * 0.5));
					final i = createIntersection(Math.sqrt(2), shape);
					final comps = i.prepeareComputation(ray, [i]);
					comps.reflect.should.equal(createVector(0, Math.sqrt(2) * 0.5, Math.sqrt(2) * 0.5));
				});
				[
					[0, 1.0, 1.5],
					[1, 1.5, 2.0],
					[2, 2.0, 2.5],
					[3, 2.5, 2.5],
					[4, 2.5, 1.5],
					[5, 1.5, 1.0]
				]
				.iter(row -> {
					it('should find n1 and n2 for intersection at index ${row[0]}', {
						final a = glassSphere();
						final b = glassSphere();
						final c = glassSphere();

						a.transform = scaling(2, 2, 2);
						b.transform = translation(0, 0, -0.25);
						c.transform = translation(0, 0, 0.25);

						a.material.refractiveIndex = 1.5;
						b.material.refractiveIndex = 2.0;
						c.material.refractiveIndex = 2.5;

						final ray = createRay(createPoint(0, 0, -4), createVector(0, 0, 1));
						final intersections = [
							createIntersection(2, a),
							createIntersection(2.75, b),
							createIntersection(3.25, c),
							createIntersection(4.75, b),
							createIntersection(5.25, c),
							createIntersection(6, a)
						];
						final comps = intersections[Std.int(row[0])].prepeareComputation(ray, intersections);
						comps.n1.should.be(row[1]);
						comps.n2.should.be(row[2]);
					});
				});
				it("should calculate offset below the surface", {
					final ray = createRay(createPoint(0, 0, -5), createVector(0, 0, 1));
					final shape = glassSphere();
					shape.transform = translation(0, 0, 1);
					final i = createIntersection(5, shape);
					final intersections = [i];
					final comps = i.prepeareComputation(ray, intersections);
					comps.underPoint.z.should.beGreaterThan(Epsilon * 0.5);
					comps.point.z.should.beLessThan(comps.underPoint.z);
				});
			});
		});
		describe("shlick", {
			it("should calculate under total internal reflection", {
				final shape = glassSphere();
				final ray = createRay(createPoint(0, 0, Math.sqrt(2) * 0.5), createVector(0, 1, 0));
				final intersections = [
					createIntersection(-Math.sqrt(2) * 0.5, shape),
					createIntersection(Math.sqrt(2) * 0.5, shape)
				];
				final comps = intersections[1].prepeareComputation(ray, intersections);
				final reflection = comps.shlick();
				reflection.should.be(1.0);
			});
			it("should calculate for perpendicular viewing angle", {
				final shape = glassSphere();
				final ray = createRay(createPoint(0, 0, 0), createVector(0, 1, 0));
				final intersections = [createIntersection(-1, shape), createIntersection(1, shape)];
				final comps = intersections[1].prepeareComputation(ray, intersections);
				final reflection = comps.shlick();
				reflection.roundTo(2).should.be(0.04);
			});
			it("should calculate with small viewing angle and n2 > n1", {
				final shape = glassSphere();
				final ray = createRay(createPoint(0, 0.99, -2), createVector(0, 0, 1));
				final intersections = [createIntersection(1.8589, shape)];
				final comps = intersections[0].prepeareComputation(ray, intersections);
				final reflection = comps.shlick();
				reflection.roundTo(5).should.be(0.48873);
			});
		});
	}
}
