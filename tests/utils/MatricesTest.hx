package utils;

import utils.MatrixCreator.createMatrix;
import utils.MatrixCreator.createIdentityMatrix;
import utils.TuplesCreator.create;

using utils.Matrices;
using utils.Numbers;

class MatricesTest extends BuddySuite {
	public function new() {
		describe("MatricesTest", {
			describe("equality with identical length matrix", {
				it("shoul be equal", {
					final a = createMatrix(4, 4);
					final b = createMatrix(4, 4);

					a.fill([1, 2, 3, 4, 5, 6, 7, 8, 9, 8, 7, 6, 5, 4, 3, 2]);
					b.fill([1, 2, 3, 4, 5, 6, 7, 8, 9, 8, 7, 6, 5, 4, 3, 2]);

					a.should.equal(b);
				});
				it("shoul not be equal", {
					final a = createMatrix(4, 4);
					final b = createMatrix(4, 4);

					a.fill([1, 2, 3, 4, 5, 6, 7, 8, 9, 8, 7, 6, 5, 4, 3, 2]);
					b.fill([2, 3, 4, 5, 6, 7, 8, 9, 8, 7, 6, 5, 4, 3, 2, 1]);

					a.should.not.equal(b);
				});
			});
			describe("multiplay", {
				it("should multiplay 2 4x4 matrices", {
					final a = createMatrix(4, 4).fill([1, 2, 3, 4, 5, 6, 7, 8, 9, 8, 7, 6, 5, 4, 3, 2]);
					final b = createMatrix(4, 4).fill([-2, 1, 2, 3, 3, 2, 1, -1, 4, 3, 6, 5, 1, 2, 7, 8]);
					final output = createMatrix(4, 4).fill([20, 22, 50, 48, 44, 54, 114, 108, 40, 58, 110, 102, 16, 26, 46, 42]);
					final result = a * b;
					result.should.equal(output);
				});
				it("should multiplay matrix and tuple", {
					final m = createMatrix(4, 4).fill([1, 2, 3, 4, 2, 4, 4, 2, 8, 6, 4, 1, 0, 0, 0, 1]);
					final t = create(1, 2, 3, 1);
					final output = create(18, 24, 33, 1);
					final result = m * t;
					result.should.equal(output);
				});
				it("should multiplay matrix with identity matrix", {
					final m = createMatrix(4, 4).fill([0, 1, 2, 4, 1, 2, 4, 8, 2, 4, 8, 16, 4, 8, 16, 32]);
					final identityMatrix = createIdentityMatrix(4, 4);
					final result = m * identityMatrix;
					result.should.equal(m);
				});
				it("shoul multiplay identity matrix by tuple", {
					final t = create(1, 2, 3, 4);
					final identityMatrix = createIdentityMatrix(4, 4);
					final result = identityMatrix * t;
					result.should.equal(t);
				});
				it("should mulitplay product by its inverse", {
					final a = createMatrix(4, 4).fill([3, -9, 7, 3, 3, -8, 2, -9, -4, 4, 4, 1, -6, 5, -1, 1]);
					final b = createMatrix(4, 4).fill([8, 2, 2, 2, 3, -1, 7, 0, 7, 0, 5, 4, 6, -2, 0, 5]);
					final c = a * b;
					final result = c * b.inverse();
					result.roundTo(5).should.equal(a);
				});
			});
			describe("transpose", {
				it("should transpose matrix", {
					final m = createMatrix(4, 4).fill([0, 9, 3, 0, 9, 8, 0, 8, 1, 8, 5, 3, 0, 0, 5, 8]);
					final transposedM = createMatrix(4, 4).fill([0, 9, 1, 0, 9, 8, 8, 0, 3, 0, 5, 5, 0, 8, 3, 8]);
					final result = m.transpose();
					result.should.equal(transposedM);
				});
				it("should transpose identity matrix", {
					final m = createIdentityMatrix(4, 4);
					final result = m.transpose();
					result.should.equal(m);
				});
			});
			describe("determinant", {
				it("should calculate determinant for 2x2", {
					final m = createMatrix(2, 2).fill([1, 5, -3, 2]);
					final result = m.determinant();
					result.should.be(17);
				});
				it("should calculate determinant for 3x3", {
					final m = createMatrix(3, 3).fill([1, 2, 6, -5, 8, -4, 2, 6, 4]);
					m.cofactor(0, 0).should.be(56);
					m.cofactor(0, 1).should.be(12);
					m.cofactor(0, 2).should.be(-46);
					m.determinant().should.be(-196);
				});
				it("should calculate determinant for 4x4", {
					final m = createMatrix(4, 4).fill([-4, 2, -2, -3, 9, 6, 2, 6, 0, -5, 1, -5, 0, 0, 0, 0]);
					m.determinant().should.be(0);
				});
			});
			describe("inverse", {
				it("should inverse matrix", {
					final m = createMatrix(4, 4).fill([-5, 2, 6, -8, 1, -5, 1, 8, 7, 7, -6, -7, 1, -3, 7, 4]);
					final inversedM = createMatrix(4, 4).fill([
						0.21805, 0.45113, 0.24060, -0.04511, -0.80827, -1.45677, -0.44361, 0.52068, -0.07895, -0.22368, -0.05263, 0.19737, -0.52256, -0.81391,
						-0.30075, 0.30639
					]);
					m.determinant().should.be(532);
					m.cofactor(2, 3).should.be(-160);
					inversedM.get(3, 2).should.be((-160 / 532).roundTo(5));
					m.cofactor(3, 2).should.be(105);
					inversedM.get(2, 3).should.be((105 / 532).roundTo(5));
					m.inverse().roundTo(5).should.equal(inversedM);
				});
				it("should calculate inverse matrix for matrix A", {
					final m = createMatrix(4, 4).fill([8, -5, 9, 2, 7, 5, 6, 1, -6, 0, 9, 6, -3, 0, -9, -4]);
					final inversedM = createMatrix(4, 4).fill([
						-0.15385, -0.15385, -0.28205, -0.53846, -0.07692, 0.12308, 0.02564, 0.03077, 0.35897, 0.35897, 0.43590, 0.92308, -0.69231, -0.69231,
						-0.76923, -1.92308
					]);
					m.inverse().roundTo(5).should.equal(inversedM);
				});
				it("should calculate inverse matrix for matrix B", {
					final m = createMatrix(4, 4).fill([9, 3, 0, 9, -5, -2, -6, -3, -4, 9, 6, 4, -7, 6, 6, 2]);
					final inversedM = createMatrix(4, 4).fill([
						-0.04074, -0.07778, 0.14444, -0.22222, -0.07778, 0.03333, 0.36667, -0.33333, -0.02901, -0.14630, -0.10926, 0.12963, 0.17778, 0.06667,
						-0.26667, 0.33333
					]);

					m.inverse().roundTo(5).should.equal(inversedM);
				});
			});
			describe("submatrix", {
				it("should create submatrix from 3x3", {
					final m = createMatrix(3, 3).fill([1, 5, 0, -3, 2, 7, 0, 6, -3]);
					final output = createMatrix(2, 2).fill([-3, 2, 0, 6]);
					final result = m.submatrix(0, 2);
					result.should.equal(output);
				});
				it("should create submatrix from 4x4", {
					final m = createMatrix(4, 4).fill([-6, 1, 1, 6, -8, 5, 8, 6, -1, 0, 8, 2, -7, 1, -1, 1]);
					final output = createMatrix(3, 3).fill([-6, 1, 6, -8, 8, 6, -7, -1, 1]);
					final result = m.submatrix(2, 1);
					result.should.equal(output);
				});
			});
			describe("minor", {
				it("should calculate minor for 3x3 matrix", {
					final m = createMatrix(3, 3).fill([3, 5, 0, 2, -1, -7, 6, -1, 5]);
					final subMatrix = m.submatrix(1, 0);
					final minor = m.minor(1, 0);
					final subMatrixDeterminant = subMatrix.determinant();
					subMatrixDeterminant.should.be(25);
					subMatrixDeterminant.should.be(minor);
				});
			});
			describe("cofactor", {
				it("should calcualte cofactor for 3x3 matrix", {
					final m = createMatrix(3, 3).fill([3, 5, 0, 2, -1, -7, 6, -1, 5]);
					m.minor(0, 0).should.be(-12);
					m.cofactor(0, 0).should.be(-12);
					m.minor(1, 0).should.be(25);
					m.cofactor(1, 0).should.be(-25);
				});
			});
		});
	}
}
