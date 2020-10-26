package types;

import types.CSG.Operation;
import types.CSG.intersectionAllowed;
import types.CSG.filterIntersections;
import utils.IntersectionCreator.createIntersection;
import utils.SphereCreator.createSphere;
import utils.CubeCreator.createCube;
import utils.CSGCreator.csg;
import utils.TuplesCreator.createVector;
import utils.TuplesCreator.createPoint;
import utils.RayCreator.createRay;
import utils.Transformation.translation;
import types.Tuple;

using Lambda;
using utils.Tuples;
using utils.Numbers;

class CSGTest extends BuddySuite {
	public function new() {
		describe("CSGTest", {
			it("should create csg", {
                final s1 = createSphere();
                final s2 = createCube();
                final c = csg(Operation.Union, s1, s2);
                c.left.should.be(s1);
                c.right.should.be(s2);
                c.operation.should.equal(Operation.Union);
                s1.parent.should.be(c);
                s2.parent.should.be(c);
            });
            describe("intersectionAllowed", {
                describe("union", {
                    final data: Array<Array<Dynamic>> = [
                        [Operation.Union, true, true, true, false],
                        [Operation.Union, true, true, false, true],
                        [Operation.Union, true, false, true, false],
                        [Operation.Union, true, false, false, true],
                        [Operation.Union, false, true, true, false],
                        [Operation.Union, false, true, false, false],
                        [Operation.Union, false, false, true, true],
                        [Operation.Union, false, false, false, true]
                    ];
                    data.iter(s -> {
                        it('should work for ${s}', {
                            final result = intersectionAllowed(s[0], s[1], s[2], s[3]);
                            result.should.be(s[4]);
                        });
                    });
                });
                describe("intersection", {
                    final data: Array<Array<Dynamic>> = [
                        [Operation.Intersection, true, true, true, true],
                        [Operation.Intersection, true, true, false, false],
                        [Operation.Intersection, true, false, true, true],
                        [Operation.Intersection, true, false, false, false],
                        [Operation.Intersection, false, true, true, true],
                        [Operation.Intersection, false, true, false, true],
                        [Operation.Intersection, false, false, true, false],
                        [Operation.Intersection, false, false, false, false]
                    ];
                    data.iter(s -> {
                        it('should work for ${s}', {
                            final result = intersectionAllowed(s[0], s[1], s[2], s[3]);
                            result.should.be(s[4]);
                        });
                    });
                });
                describe("difference", {
                    final data: Array<Array<Dynamic>> = [
                        [Operation.Difference, true, true, true, false],
                        [Operation.Difference, true, true, false, true],
                        [Operation.Difference, true, false, true, false],
                        [Operation.Difference, true, false, false, true],
                        [Operation.Difference, false, true, true, true],
                        [Operation.Difference, false, true, false, true],
                        [Operation.Difference, false, false, true, false],
                        [Operation.Difference, false, false, false, false]
                    ];
                    data.iter(s -> {
                        it('should work for ${s}', {
                            final result = intersectionAllowed(s[0], s[1], s[2], s[3]);
                            result.should.be(s[4]);
                        });
                    });
                });
            });
            describe("filter intersections", {
                final data: Array<Array<Dynamic>> = [
                    [Operation.Union, 0, 3],
                    [Operation.Intersection, 1, 2],
                    [Operation.Difference, 0, 1]
                ];
                data.iter(s -> {
                    it('should work for ${s}', {
                        final s1 = createSphere();
                        final s2 = createCube();
                        final c = csg(s[0], s1, s2);
                        final xs = [
                            createIntersection(1, s1),
                            createIntersection(2, s2),
                            createIntersection(3, s1),
                            createIntersection(4, s2)
                        ];

                        final result = filterIntersections(c, xs);
                        result.length.should.be(2);
                        result[0] = xs[s[1]];
                        result[1] = xs[s[2]];
                    });
                });
            });
            describe("intersects", {
                it("ray misses csg", {
                    final c = csg(Operation.Union, createSphere(), createCube());
                    final ray = createRay(createPoint(0, 2, -5), createVector(0, 0, 1));
                    final xs = c.intersects(ray);
                    xs.length.should.be(0);
                });
                it("ray hits csg", {
                    final s1 = createSphere();
                    final s2 = createSphere();
                    s2.transform = translation(0, 0, 0.5);
                    final c = csg(Operation.Union, s1, s2);
                    final ray = createRay(createPoint(0, 0, -5), createVector(0, 0, 1));
                    final xs = c.intersects(ray);
                    xs.length.should.be(2);
                    xs[0].t.should.be(4);
                    xs[0].object.should.be(s1);
                    xs[1].t.should.be(6.5);
                    xs[1].object.should.be(s2);
                });
            });
		});
	}
}
