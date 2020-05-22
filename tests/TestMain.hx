package;

import buddy.Buddy;
import utils.TuplesTest;
import utils.TuplesCreatorTest;
import utils.ColorTest;
import utils.CanvasCreatorTest;
import utils.CanvasPPMTest;
import utils.MatrixCreatorTest;
import utils.MatricesTest;
import utils.TransformationTest;
import utils.RayCreatorTest;
import utils.RaysTest;
import utils.SpheresTest;
import utils.IntersectionCreatorTest;
import utils.IntersectionsTest;
import utils.PointLightCreatorTest;
import utils.MaterialsCreatorTest;
import utils.WorldCreatorTest;
import utils.WorldsTest;
import utils.CameraCreatorTest;
import utils.CamerasTest;
import components.CanvasTest;

class TestMain implements Buddy<[
	TuplesCreatorTest, TuplesTest, ColorTest, CanvasCreatorTest, CanvasTest, MatrixCreatorTest, MatricesTest, TransformationTest, RayCreatorTest, RaysTest,
	CanvasPPMTest, SpheresTest, IntersectionCreatorTest, IntersectionsTest, PointLightCreatorTest, MaterialsCreatorTest, WorldCreatorTest, WorldsTest,
	CameraCreatorTest, CamerasTest
]> {}
