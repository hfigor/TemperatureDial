import SwiftUI

struct TemperatureDial: View {

    @State private var value: CGFloat = 0

    private let initialTemperature: CGFloat
    private let scale: CGFloat = 100.0
    private let indicatorLength: CGFloat = 25.0
    private let maxTemperature: CGFloat = 500.0
    private let stepSize: CGFloat = 5.0

    private var innerScale: CGFloat {
        return scale - indicatorLength
    }

    init(temperature: CGFloat) {
        self.initialTemperature = temperature
    }

    private func angle(between starting: CGPoint, ending: CGPoint) -> CGFloat {
        let center = CGPoint(x: ending.x - starting.x, y: ending.y - starting.y)
        let radians = atan2(center.y, center.x)
        var degrees = 90 + (radians * 180 / .pi)

        if degrees < 0 {
            degrees += 360
        }

        return degrees
    }

   // var myColor = Color.applyColorName(.)
    var body: some View {
        
       ZStack(alignment: .center) {
            Circle()
               .fill(ColorManager.GaugeBlue)
                //.fill(Color.applyColorName(.Blueberry)
                .frame(width: self.innerScale, height: self.innerScale, alignment: .center)
                .rotationEffect(.degrees(-90))
                .gesture(
                    DragGesture().onChanged() { value in

                        let x: CGFloat = min(max(value.location.x, 0), self.innerScale)
                        let y: CGFloat = min(max(value.location.y, 0), self.innerScale)

                        let ending = CGPoint(x: x, y: y)
                        let start = CGPoint(x: (self.innerScale) / 2, y: (self.innerScale) / 2)

                        let angle = self.angle(between: start, ending: ending)
                        self.value = CGFloat(Int(((angle / 360) * (self.maxTemperature / self.stepSize)))) / (self.maxTemperature / self.stepSize)
                    }
                )
                    Circle()
               .stroke(ColorManager.GaugeRed, style: StrokeStyle(lineWidth: self.indicatorLength, lineCap: .butt, lineJoin: .miter, dash: [4]))
                .frame(width: self.scale, height: self.scale, alignment: .center)
        //   ZStack{
           Circle()
                .trim(from: 0.0, to: self.value)
                .stroke(ColorManager.GaugeGray, style: StrokeStyle(lineWidth: self.indicatorLength, lineCap: .butt, lineJoin: .miter, dash: [4]))
                .rotationEffect(.degrees(-90))
                .frame(width: self.scale, height: self.scale, alignment: .center)

            Text("\(self.value * self.maxTemperature, specifier: "%.1f") \u{2103}")
                .font(.largeTitle)
                .fontWeight(.semibold)

                .lineLimit(1)
                .minimumScaleFactor(0.3)
                .foregroundColor(Color.white)
                .frame(width: self.scale - indicatorLength, height: self.scale - indicatorLength, alignment: .center)

         //  }
          // .frame(width: self.scale, height: self.scale, alignment: .center)

       }// ZStack}
        .onAppear(perform: {
            self.value = self.initialTemperature / self.maxTemperature
        })
        
    }

}
struct TemperatureDial_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureDial(temperature: 100.0)
    }
}



