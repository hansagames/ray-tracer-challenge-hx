package utils;

import utils.TuplesCreator.createPoint;
import utils.TuplesCreator.createVector;
import utils.Transformation.translation;
import utils.Transformation.scaling;
import utils.Transformation.rotationX;
import utils.Transformation.rotationY;
import utils.Transformation.rotationZ;
import utils.Transformation.shearing;

using utils.Matrices;

class TransformationTest extends BuddySuite {
	public function new() {
		describe("TransformationTest", {
			describe("translate", {
				it("should multiplay by translation matrix", {
					final transform = translation(5, -3, 2);
					final p = createPoint(-3, 4, 5);
					final output = createPoint(2, 1, 7);
					final result = transform * p;
					result.should.equal(output);
				});
				it("should multiplay by inverse of translation matrix", {
					final transform = translation(5, -3, 2);
					final inverse = transform.inverse();
					final p = createPoint(-3, 4, 5);
					final output = createPoint(-8, 7, 3);
					final result = inverse * p;
					result.should.equal(output);
				});
				it("should not affect vectors", {
					final transform = translation(5, -3, 2);
					final v = createVector(-3, 4, 5);
					final result = transform * v;
					result.should.equal(v);
				});
			});
			describe("scale", {
				it("should scale point", {
					final transform = scaling(2, 3, 4);
					final p = createPoint(-4, 6, 8);
					final output = createPoint(-8, 18, 32);
					final result = transform * p;
					result.should.equal(output);
				});
				it("should scale point", {
					final transform = scaling(2, 3, 4);
					final v = createVector(-4, 6, 8);
					final output = createVector(-8, 18, 32);
					final result = transform * v;
					result.should.equal(output);
				});
				it("should scale by inverse of scaling matrix", {
					final transform = scaling(2, 3, 4);
					final inverse = transform.inverse();
					final v = createVector(-4, 6, 8);
					final output = createVector(-2, 2, 2);
					final result = inverse * v;
					result.should.equal(output);
				});
				it("should reflect point", {
					final transform = scaling(-1, 1, 1);
					final p = createPoint(2, 3, 4);
					final output = createPoint(-2, 3, 4);
					final result = transform * p;
					result.should.equal(output);
				});
			});
			describe("rotation on x axis", {
				it("should rotate point around x axis", {
					final p = createPoint(0, 1, 0);
					final halfQuarter = rotationX(Math.PI / 4);
					final fullQuarter = rotationX(Math.PI / 2);
					(halfQuarter * p).should.equal(createPoint(0, Math.sqrt(2) / 2, Math.sqrt(2) / 2));
					(fullQuarter * p).should.equal(createPoint(0, 0, 1));
				});
				it("should rotate by inverse matrix", {
					final p = createPoint(0, 1, 0);
					final halfQuarter = rotationX(Math.PI / 4);
					final inverse = halfQuarter.inverse();
					(inverse * p).should.equal(createPoint(0, Math.sqrt(2) / 2, -Math.sqrt(2) / 2));
				});
			});
			describe("rotation on y axis", {
				it("should rotate point around y axis", {
					final p = createPoint(0, 0, 1);
					final halfQuarter = rotationY(Math.PI / 4);
					final fullQuarter = rotationY(Math.PI / 2);
					(halfQuarter * p).should.equal(createPoint(Math.sqrt(2) / 2, 0, Math.sqrt(2) / 2));
					(fullQuarter * p).should.equal(createPoint(1, 0, 0));
				});
			});
			describe("rotation on z axis", {
				it("should rotate point around z axis", {
					final p = createPoint(0, 1, 0);
					final halfQuarter = rotationZ(Math.PI / 4);
					final fullQuarter = rotationZ(Math.PI / 2);
					(halfQuarter * p).should.equal(createPoint(-Math.sqrt(2) / 2, Math.sqrt(2) / 2, 0));
					(fullQuarter * p).should.equal(createPoint(-1, 0, 0));
				});
			});
			describe("shearing", {
				it("should shear x in proportion to y", {
					final transform = shearing(1, 0, 0, 0, 0, 0);
					final p = createPoint(2, 3, 4);
					(transform * p).should.equal(createPoint(5, 3, 4));
				});
				it("should shear x in proportion to z", {
					final transform = shearing(0, 1, 0, 0, 0, 0);
					final p = createPoint(2, 3, 4);
					(transform * p).should.equal(createPoint(6, 3, 4));
				});
				it("should shear y in proportion to x", {
					final transform = shearing(0, 0, 1, 0, 0, 0);
					final p = createPoint(2, 3, 4);
					(transform * p).should.equal(createPoint(2, 5, 4));
				});
				it("should shear y in proportion to z", {
					final transform = shearing(0, 0, 0, 1, 0, 0);
					final p = createPoint(2, 3, 4);
					(transform * p).should.equal(createPoint(2, 7, 4));
				});
				it("should shear z in proportion to x", {
					final transform = shearing(0, 0, 0, 0, 1, 0);
					final p = createPoint(2, 3, 4);
					(transform * p).should.equal(createPoint(2, 3, 6));
				});
				it("should shear z in proportion to y", {
					final transform = shearing(0, 0, 0, 0, 0, 1);
					final p = createPoint(2, 3, 4);
					(transform * p).should.equal(createPoint(2, 3, 7));
				});
			});
			describe("multiple transformation", {
				it("should apply individual transformations in sequence", {
					final p = createPoint(1, 0, 1);
					final A = rotationX(Math.PI / 2);
					final B = scaling(5, 5, 5);
					final C = translation(10, 5, 7);
					final p2 = A * p;
					final p3 = B * p2;
					final p4 = C * p3;
					p2.should.equal(createPoint(1, -1, 0));
					p3.should.equal(createPoint(5, -5, 0));
					p4.should.equal(createPoint(15, 0, 7));
				});
				it("chained transforamtions should be applied in reverso order", {
					final p = createPoint(1, 0, 1);
					final A = rotationX(Math.PI / 2);
					final B = scaling(5, 5, 5);
					final C = translation(10, 5, 7);
					final T = C * B * A;
					(T * p).should.equal(createPoint(15, 0, 7));
				});
			});
		});
	}
}
