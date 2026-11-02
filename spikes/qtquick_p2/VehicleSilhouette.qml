import QtQuick

// Original, model-agnostic vector artwork. Decorative only: never suggests a
// specific make, licence, condition or commercially approved photograph.
Item {
    id: illustration
    property string vehicleType: "Car"
    implicitWidth: 164
    implicitHeight: 74
    Accessible.ignored: true

    Canvas {
        id: drawing
        anchors.centerIn: parent
        width: 164
        height: 74
        onPaint: {
            const ctx = getContext("2d")
            ctx.clearRect(0, 0, width, height)
            ctx.lineJoin = "round"
            ctx.lineCap = "round"
            ctx.lineWidth = 3
            ctx.strokeStyle = "#17324D"
            ctx.fillStyle = "#FFFFFF"

            if (illustration.vehicleType.toLowerCase() === "motorcycle") {
                // Motorcycle silhouette with two grounded wheels.
                ctx.beginPath()
                ctx.arc(37, 56, 14, 0, 2 * Math.PI)
                ctx.arc(126, 56, 14, 0, 2 * Math.PI)
                ctx.fill()
                ctx.stroke()
                ctx.beginPath()
                ctx.moveTo(37, 56)
                ctx.lineTo(63, 26)
                ctx.lineTo(96, 56)
                ctx.lineTo(37, 56)
                ctx.lineTo(80, 56)
                ctx.lineTo(100, 32)
                ctx.lineTo(126, 56)
                ctx.moveTo(63, 26)
                ctx.lineTo(84, 26)
                ctx.moveTo(100, 32)
                ctx.lineTo(96, 22)
                ctx.lineTo(115, 22)
                ctx.moveTo(77, 16)
                ctx.lineTo(99, 16)
                ctx.stroke()
                ctx.strokeStyle = "#0F766E"
                ctx.beginPath()
                ctx.moveTo(59, 27)
                ctx.lineTo(86, 27)
                ctx.stroke()
            } else {
                // Generic passenger-vehicle outline, not a particular car model.
                ctx.beginPath()
                ctx.moveTo(17, 54)
                ctx.lineTo(17, 43)
                ctx.quadraticCurveTo(17, 38, 26, 36)
                ctx.lineTo(44, 32)
                ctx.lineTo(58, 16)
                ctx.quadraticCurveTo(61, 13, 67, 13)
                ctx.lineTo(108, 13)
                ctx.quadraticCurveTo(113, 13, 118, 19)
                ctx.lineTo(132, 35)
                ctx.lineTo(143, 39)
                ctx.quadraticCurveTo(149, 42, 149, 49)
                ctx.lineTo(149, 55)
                ctx.lineTo(17, 55)
                ctx.closePath()
                ctx.fill()
                ctx.stroke()
                ctx.beginPath()
                ctx.moveTo(54, 33)
                ctx.lineTo(66, 19)
                ctx.lineTo(108, 19)
                ctx.lineTo(122, 34)
                ctx.closePath()
                ctx.strokeStyle = "#0F766E"
                ctx.stroke()
                ctx.strokeStyle = "#17324D"
                ctx.beginPath()
                ctx.arc(48, 56, 11, 0, 2 * Math.PI)
                ctx.arc(119, 56, 11, 0, 2 * Math.PI)
                ctx.fill()
                ctx.stroke()
            }
        }
    }
    onVehicleTypeChanged: drawing.requestPaint()
}
