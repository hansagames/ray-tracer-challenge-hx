package utils;

import types.Pattern;
import types.Tuple;
import utils.TuplesCreator.createColor;
import utils.TuplesCreator.createPoint;
import utils.Paterns.stripePattern;
import utils.Paterns.gradientPattern;
import utils.Paterns.ringPattern;
import utils.Paterns.checkerPattern;
import utils.SphereCreator.createSphere;
import utils.Transformation.scaling;
import utils.Transformation.translation;
import utils.MatrixCreator.createIdentityMatrix;
import utils.Paterns.patternAtShape;

class PatternsTest extends BuddySuite {
	public function new() {
		describe("PattternsTest", {
			describe("abstract pattern", {
				it("should have default transfromation", {
					final pattern = new Pattern();
					pattern.transform.should.equal(createIdentityMatrix(4, 4));
				});
				it("should change transform", {
					final pattern = new Pattern();
					final transfrom = translation(1, 2, 3);
					pattern.transform = transfrom;
					pattern.transform.should.equal(transfrom);
				});
				it("should make pattern with object transforamtion", {
					final object = createSphere();
					object.transform = scaling(2, 2, 2);
					final pattern = new Pattern();
					patternAtShape(pattern, object, createPoint(2, 3, 4)).should.equal(createColor(1, 1.5, 2));
				});
				it("should make pattern with pattern transformation", {
					final object = createSphere();
					final pattern = new Pattern();
					pattern.transform = scaling(2, 2, 2);
					patternAtShape(pattern, object, createPoint(2, 3, 4)).should.equal(createColor(1, 1.5, 2));
				});
				it("should stripe with object and pattern transforamtion", {
					final object = createSphere();
					object.transform = scaling(2, 2, 2);
					final pattern = new Pattern();
					pattern.transform = translation(0.5, 1, 1.5);
					patternAtShape(pattern, object, createPoint(2.5, 3, 3.5)).should.equal(createColor(0.75, 0.5, 0.25));
				});
			});
			describe("stripes", {
				var black:Tuple;
				var white:Tuple;
				beforeEach(() -> {
					black = createColor(0, 0, 0);
					white = createColor(1, 1, 1);
				});
				describe("stripePattern", {
					it("should create stripe pattern", {
						final pattern = stripePattern(white, black);
						pattern.a.should.equal(white);
						pattern.b.should.equal(black);
					});
				});
				describe("stripeAt", {
					it("should be constant for Y", {
						final pattern = stripePattern(white, black);
						pattern.patternAt(createPoint(0, 0, 0)).should.equal(white);
						pattern.patternAt(createPoint(0, 1, 0)).should.equal(white);
						pattern.patternAt(createPoint(0, 2, 0)).should.equal(white);
					});
					it("should be constant for Z", {
						final pattern = stripePattern(white, black);
						pattern.patternAt(createPoint(0, 0, 0)).should.equal(white);
						pattern.patternAt(createPoint(0, 0, 1)).should.equal(white);
						pattern.patternAt(createPoint(0, 0, 2)).should.equal(white);
					});
					it("should alternate for X", {
						final pattern = stripePattern(white, black);
						pattern.patternAt(createPoint(0, 0, 0)).should.equal(white);
						pattern.patternAt(createPoint(0.9, 0, 0)).should.equal(white);
						pattern.patternAt(createPoint(1, 0, 0)).should.equal(black);
						pattern.patternAt(createPoint(-0.1, 0, 0)).should.equal(black);
						pattern.patternAt(createPoint(-1, 0, 0)).should.equal(black);
						pattern.patternAt(createPoint(-1.1, 0, 0)).should.equal(white);
					});
				});
			});
			describe("gradientPattern", {
				var black:Tuple;
				var white:Tuple;
				beforeEach(() -> {
					black = createColor(0, 0, 0);
					white = createColor(1, 1, 1);
				});
				it("should interpolate between colors", {
					final pattern = gradientPattern(white, black);
					pattern.patternAt(createPoint(0, 0, 0)).should.equal(white);
					pattern.patternAt(createPoint(0.25, 0, 0)).should.equal(createColor(0.75, 0.75, 0.75));
					pattern.patternAt(createPoint(0.5, 0, 0)).should.equal(createColor(0.5, 0.5, 0.5));
					pattern.patternAt(createPoint(0.75, 0, 0)).should.equal(createColor(0.25, 0.25, 0.25));
				});
			});
			describe("ringPattern", {
				var black:Tuple;
				var white:Tuple;
				beforeEach(() -> {
					black = createColor(0, 0, 0);
					white = createColor(1, 1, 1);
				});
				it("should interpolate between colors", {
					final pattern = ringPattern(white, black);
					pattern.patternAt(createPoint(0, 0, 0)).should.equal(white);
					pattern.patternAt(createPoint(1, 0, 0)).should.equal(black);
					pattern.patternAt(createPoint(0, 0, 1)).should.equal(black);
					pattern.patternAt(createPoint(Math.sqrt(2) * 0.5, 0, Math.sqrt(2) * 0.5)).should.equal(black);
				});
			});
			describe("checkerPattern", {
				var black:Tuple;
				var white:Tuple;
				beforeEach(() -> {
					black = createColor(0, 0, 0);
					white = createColor(1, 1, 1);
				});
				it("should repeat in x", {
					final pattern = checkerPattern(white, black);
					pattern.patternAt(createPoint(0, 0, 0)).should.equal(white);
					pattern.patternAt(createPoint(0.99, 0, 0)).should.equal(white);
					pattern.patternAt(createPoint(1.01, 0, 0)).should.equal(black);
				});
				it("should repeat in y", {
					final pattern = checkerPattern(white, black);
					pattern.patternAt(createPoint(0, 0, 0)).should.equal(white);
					pattern.patternAt(createPoint(0, 0.99, 0)).should.equal(white);
					pattern.patternAt(createPoint(0, 1.01, 0)).should.equal(black);
				});
				it("should repeat in z", {
					final pattern = checkerPattern(white, black);
					pattern.patternAt(createPoint(0, 0, 0)).should.equal(white);
					pattern.patternAt(createPoint(0, 0, 0.99)).should.equal(white);
					pattern.patternAt(createPoint(0, 0, 1.01)).should.equal(black);
				});
			});
		});
	}
}
