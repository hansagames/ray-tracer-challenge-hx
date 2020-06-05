package utils;

import types.CheckerPattern;
import types.RingPattern;
import types.GradientPattern;
import types.Pattern;
import types.Shape;
import types.StripePattern;
import types.Tuple;

using utils.Matrices;

class Paterns {
	public static function stripePattern(color1:Tuple, color2:Tuple):StripePattern {
		return new StripePattern(color1, color2);
	}

	public static function gradientPattern(color1:Tuple, color2:Tuple):GradientPattern {
		return new GradientPattern(color1, color2);
	}

	public static function ringPattern(color1:Tuple, color2:Tuple):RingPattern {
		return new RingPattern(color1, color2);
	}

	public static function checkerPattern(color1:Tuple, color2:Tuple):CheckerPattern {
		return new CheckerPattern(color1, color2);
	}

	public static function patternAtShape(pattern:Pattern, object:Shape, point:Tuple):Tuple {
		final objectPoint = object.transform.inverse() * point;
		final patternPoint = pattern.transform.inverse() * objectPoint;
		return pattern.patternAt(patternPoint);
	}
}
