package utils;

import utils.MatrixCreator.createMatrix;

class MatrixCreatorTest extends BuddySuite {
	public function new() {
		describe("MatrixCreatorTest", {
			it("should create matrix", {
				var m = createMatrix(4, 4);
				m.length.should.be(16);
			});
			it("should fill with data", {
				var m = createMatrix(4, 4);
				m.set(0, 0, 1)
					.set(0, 1, 2)
					.set(0, 2, 3)
					.set(0, 3, 4)
					.set(1, 0, 5.5)
					.set(1, 1, 6.5)
					.set(1, 2, 7.5)
					.set(1, 3, 8.5)
					.set(2, 0, 9)
					.set(2, 1, 10)
					.set(2, 2, 11)
					.set(2, 3, 12)
					.set(3, 0, 13.5)
					.set(3, 1, 14.5)
					.set(3, 2, 15.5)
					.set(3, 3, 16.5);

				m.get(0, 0).should.be(1);
				m.get(1, 0).should.be(5.5);
				m.get(1, 2).should.be(7.5);
				m.get(2, 2).should.be(11);
				m.get(3, 0).should.be(13.5);
				m.get(3, 2).should.be(15.5);
			});
			it("should create 2x2 matrix", {
				var m = createMatrix(2, 2);
				m.length.should.be(4);

				m.set(0, 0, -3).set(0, 1, 5).set(1, 0, 1).set(1, 1, -2);

				m.get(0, 0).should.be(-3);
				m.get(0, 1).should.be(5);
				m.get(1, 1).should.be(-2);
			});
			it("should create 3x3 matrix", {
				var m = createMatrix(3, 3);
				m.length.should.be(9);

				m.set(0, 0, -3)
					.set(0, 1, 5)
					.set(0, 2, 0)
					.set(1, 0, 1)
					.set(1, 1, -2)
					.set(1, 2, -7)
					.set(2, 0, 0)
					.set(2, 1, 1)
					.set(2, 2, 1);

				m.get(0, 0).should.be(-3);
				m.get(1, 1).should.be(-2);
				m.get(2, 2).should.be(1);
			});
		});
	}
}
