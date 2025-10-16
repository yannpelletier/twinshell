import "root:/services"
import "root:/config"

StyledText {
  property real fill
  property int grade: Config.color.light ? 0 : -25

  font.family: Config.font.family.material
  font.pointSize: Config.font.size.larger
  font.variableAxes: ({
    FILL: fill.toFixed(1),
    GRAD: grade,
    opsz: fontInfo.pixelSize,
    wght: fontInfo.weight
  })
}
