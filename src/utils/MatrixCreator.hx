package utils;

import types.Matrix;

class MatrixCreator {
	static public function createMatrix(rows:UInt, columns:UInt):Matrix {
		return new Matrix(rows, columns);
	}

	static public function createIdentityMatrix(rows:UInt, columns:UInt):Matrix {
		final m = new Matrix(rows, columns);
		for (row in 0...rows) {
			for (column in 0...columns) {
				if (row == column) {
					m.set(row, column, 1);
				}
			}
		}
		return m;
	}
}
