package types;

import utils.RayCreator.createRay;
import utils.TuplesCreator.createPoint;
import utils.TuplesCreator.createVector;
import utils.CubeCreator.createCube;

using utils.Tuples;

class CubeTest extends BuddySuite {
	public function new() {
		describe("CubeTest", {
			describe("intersects", {
				final data:Array<Dynamic> = [
					["+x", createPoint(5, 0.5, 0), createVector(-1, 0, 0), 4, 6],
					["-x", createPoint(-5, 0.5, 0), createVector(1, 0, 0), 4, 6],
					["+y", createPoint(0.5, 5, 0), createVector(0, -1, 0), 4, 6],
					["-y", createPoint(0.5, -5, 0), createVector(0, 1, 0), 4, 6],
					["+z", createPoint(0.5, 0, 5), createVector(0, 0, -1), 4, 6],
					["-z", createPoint(0.5, 0, -5), createVector(0, 0, 1), 4, 6],
					["inside", createPoint(0, 0.5, 0), createVector(0, 0, 1), -1, 1]
				];
				for (i in 0...data.length) {
					it('should intersect cube at ${data[i][0]}', {
						final cube = createCube();
						final ray = createRay(data[i][1], data[i][2]);
						final xs = cube.intersects(ray);
						xs.length.should.be(2);
						xs[0].t.should.be(data[i][3]);
						xs[1].t.should.be(data[i][4]);
					});
				}
			});
			describe("intersect when ray misses the cube", {
				final data:Array<Dynamic> = [
					[createPoint(-2, 0, 0), createVector(0.2673, 0.5345, 0.8018)],
					[createPoint(0, -2, 0), createVector(0.8018, 0.2673, 0.5345)],
					[createPoint(0, 0, -2), createVector(0.5345, 0.8018, 0.2673)],
					[createPoint(2, 0, 2), createVector(0, 0, -1)],
					[createPoint(0, 2, 2), createVector(0, -1, 0)],
					[createPoint(2, 2, 0), createVector(-1, 0, 0)]
				];
				for (i in 0...data.length) {
					it("should have no intersection", {
						final cube = createCube();
						final ray = createRay(data[i][0], data[i][1]);
						final xs = cube.intersects(ray);
						xs.length.should.be(0);
					});
				}
			});
			describe("normalAt", {
				final data:Array<Dynamic> = [
					[createPoint(1, 0.5, -0.8), createVector(1, 0, 0)],
					[createPoint(-1, -0.2, 0.9), createVector(-1, 0, 0)],
					[createPoint(-0.4, 1, -0.1), createVector(0, 1, 0)],
					[createPoint(0.3, -1, -0.7), createVector(0, -1, 0)],
					[createPoint(-0.6, 0.3, 1), createVector(0, 0, 1)],
					[createPoint(0.4, 0.4, -1), createVector(0, 0, -1)],
					[createPoint(1, 1, 1), createVector(1, 0, 0)],
					[createPoint(-1, -1, -1), createVector(-1, 0, 0)]
				];
				for (i in 0...data.length) {
					it("should have no intersection", {
						final cube = createCube();
						final normal = cube.normalAt(data[i][0]);
						normal.should.equal(data[i][1]);
					});
				}
			});
		});
	}
}
