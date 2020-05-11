package utils;

class Numbers {
	public static function roundTo(value:Float, digitsAfterComma:UInt):Float {
		final multiplier = Math.pow(10, digitsAfterComma);
		return Math.round(value * multiplier) / multiplier;
	}
}
