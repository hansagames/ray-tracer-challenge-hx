package utils;

import utils.TuplesCreator.create;
import utils.TuplesCreator.createPoint;
import utils.TuplesCreator.createVector;

using utils.Tuples;

class TuplesTest extends BuddySuite {
	public function new() {
		describe("TuplesTest", {
			describe("add", {
				it("should add tuples", {
					var a = create(3, -2, 5, 1);
					var b = create(-2, 3, 1, 0);
					var output = create(1, 1, 6, 1);
					var result = a + b;
					result.should.equal(output);
				});
			});
			describe("substract", {
				it("should substract 2 points", {
					var a = createPoint(3, 2, 1);
					var b = createPoint(5, 6, 7);
					var result = a - b;
					var output = createVector(-2, -4, -6);
					result.should.equal(output);
				});
				it("should substract vector from point", {
					var a = createPoint(3, 2, 1);
					var b = createVector(5, 6, 7);
					var result = a - b;
					var output = createPoint(-2, -4, -6);
					result.should.equal(output);
				});
				it("should substract 2 vectors", {
					var a = createVector(3, 2, 1);
					var b = createVector(5, 6, 7);
					var result = a - b;
					var output = createVector(-2, -4, -6);
					result.should.equal(output);
				});
			});
			describe("negating", {
				it("should negate tuple", {
					var input = create(1, -2, 3, -4);
					var result = -input;
					var output = create(-1, 2, -3, 4);
					result.should.equal(output);
				});
			});
			describe("multiplay with scalar", {
				it("should multiplay with scalar", {
					var input = create(1, -2, 3, -4);
					var result = input * 3.5;
					var output = create(3.5, -7, 10.5, -14);
					result.should.equal(output);
				});
				it("should multiplay with fraction", {
					var input = create(1, -2, 3, -4);
					var result = input * 0.5;
					var output = create(0.5, -1, 1.5, -2);
					result.should.equal(output);
				});
			});
			describe("multiplay with tuple", {
				it("should multiplay with tuple", {
					var a = create(1, -2, 3, -4);
					var b = create(0.5, 2, -1, -2);
					var result = a * b;
					var output = create(0.5, -4, -3, 8);
					result.should.equal(output);
				});
			});
			describe("divide by scalar", {
				it("should divide by scalar", {
					var input = create(1, -2, 3, -4);
					var result = input / 2;
					var output = create(0.5, -1, 1.5, -2);
					result.should.equal(output);
				});
			});
			describe("magnitude", {
				it("should calculate magnitude for vec(1, 0, 0)", {
					var input = createVector(1, 0, 0);
					input.magnitude().should.be(1);
				});
				it("should calculate magnitude for vec(0, 1, 0)", {
					var input = createVector(0, 1, 0);
					input.magnitude().should.be(1);
				});
				it("should calculate magnitude for vec(0, 0, 1)", {
					var input = createVector(0, 0, 1);
					input.magnitude().should.be(1);
				});
				it("should calculate magnitude for vec(1, 2, 3)", {
					var input = createVector(1, 2, 3);
					input.magnitude().should.be(Math.sqrt(14));
				});
				it("should calculate magnitude for vec(-1, -2, -3)", {
					var input = createVector(-1, -2, -3);
					input.magnitude().should.be(Math.sqrt(14));
				});
			});
			describe("normalize", {
				it("should normalize vec(4, 0, 0)", {
					var input = createVector(4, 0, 0);
					var output = createVector(1, 0, 0);
					input.normalize().should.equal(output);
				});
				it("should normalize vec(1, 2, 3)", {
					var input = createVector(1, 2, 3);
					var output = createVector(1 / Math.sqrt(14), 2 / Math.sqrt(14), 3 / Math.sqrt(14));
					input.normalize().should.equal(output);
				});
				it("should have magnitude 1 after normalization", {
					var input = createVector(1, 2, 3);
					input.magnitude().should.not.be(1);
					input.normalize().magnitude().should.be(1);
				});
			});
			describe("dot", {
				it("should calculate dot product for 2 tuples", {
					var a = createVector(1, 2, 3);
					var b = createVector(2, 3, 4);
					a.dot(b).should.be(20);
				});
			});
			describe("cross", {
				it("should calculate cross product for vec(1, 2, 3) and vec(2, 3, 4)", {
					var a = createVector(1, 2, 3);
					var b = createVector(2, 3, 4);
					var result = createVector(-1, 2, -1);
					a.cross(b).should.equal(result);
				});
				it("should calculate cross product for vec(2, 3, 4) and vec(1, 2, 3)", {
					var a = createVector(2, 3, 4);
					var b = createVector(1, 2, 3);
					var result = createVector(1, -2, 1);
					a.cross(b).should.equal(result);
				});
			});
		});
	}
}
