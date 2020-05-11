package utils;

import types.Matrix;

using utils.Numbers;

class Matrices {
	public static function fill(m:Matrix, data:Array<Float>):Matrix {
		final length = Std.int(Math.min(m.length, data.length));
		for (i in 0...length) {
			m[i] = data[i];
		}
		return m;
	}

	public static function roundTo(m:Matrix, digitAfterComma:UInt):Matrix {
		final out = new Matrix(m.rows, m.columns);
		for (row in 0...m.rows) {
			for (column in 0...m.columns) {
				out.set(row, column, m.get(row, column).roundTo(digitAfterComma));
			}
		}
		return out;
	}

	public static function transpose(m:Matrix):Matrix {
		final out = new Matrix(m.rows, m.columns);
		for (row in 0...m.rows) {
			for (column in 0...m.columns) {
				out.set(row, column, m.get(column, row));
			}
		}
		return out;
	}

	public static function determinant(m:Matrix):Float {
		var det:Float = 0;
		if (m.length == 4) {
			det = m.get(0, 0) * m.get(1, 1) - m.get(0, 1) * m.get(1, 0);
		} else {
			for (column in 0...m.columns) {
				det += m.get(0, column) * cofactor(m, 0, column);
			}
		}
		return det;
	}

	public static function inverse(m:Matrix):Matrix {
		final out = new Matrix(m.rows, m.columns);
		final det = determinant(m);
		for (row in 0...m.rows) {
			for (column in 0...m.columns) {
				out.set(column, row, cofactor(m, row, column) / det);
			}
		}
		return out;
	}

	public static function submatrix(m:Matrix, rowToRemove:UInt, columnToRemove:UInt):Matrix {
		final out = new Matrix(m.rows - 1, m.columns - 1);
		var currentRow = 0;
		var currentColumn = 0;
		for (row in 0...m.rows) {
			if (row != rowToRemove) {
				currentColumn = 0;
				for (column in 0...m.columns) {
					if (column != columnToRemove) {
						out.set(currentRow, currentColumn, m.get(row, column));
						currentColumn++;
					}
				}
				currentRow++;
			}
		}
		return out;
	}

	public static function minor(m:Matrix, row:UInt, column:UInt):Float {
		return determinant(submatrix(m, row, column));
	}

	public static function cofactor(m:Matrix, row:UInt, column:UInt):Float {
		final minorValue = minor(m, row, column);

		return (row + column) % 2 == 0 ? minorValue : minorValue * -1;
	}
}
