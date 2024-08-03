import UIKit

extension UIColor{
    static func random()->UIColor{
        let Color = UIColor(
            red: CGFloat.random(in: 0.2..<0.8),
            green: CGFloat.random(in: 0.2..<0.8),
            blue: CGFloat.random(in: 0.2..<0.8),
            alpha: 1
        )
        return Color
    }
    func toHex() -> String{
            var red: CGFloat = 0
            var green: CGFloat = 0
            var blue: CGFloat = 0
            var alpha: CGFloat = 0

            guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
                return "#7F7F7F"
            }

            let r = Int(red * 255)
            let g = Int(green * 255)
            let b = Int(blue * 255)

            return String(format: "#%02X%02X%02X", r, g, b)
        }
    func relativeLuminance() -> CGFloat {
        let ciColor = CIColor(color: self)
        let components = [ciColor.red, ciColor.green, ciColor.blue].map { component -> CGFloat in
            if component <= 0.03928 {
                return component / 12.92
            } else {
                return pow((component + 0.055) / 1.055, 2.4)
            }
        }
        return 0.2126 * components[0] + 0.7152 * components[1] + 0.0722 * components[2]
    }
    
    
    func contrastRatio(with color: UIColor) -> CGFloat {
        let lum1 = self.relativeLuminance()
        let lum2 = color.relativeLuminance()
        return (max(lum1, lum2) + 0.05) / (min(lum1, lum2) + 0.05)
    }
    
    func contrastColor() -> UIColor {
        let blackContrast = self.contrastRatio(with: .black)
        let whiteContrast = self.contrastRatio(with: .white)
        
        return blackContrast > whiteContrast ? .black : .white
    }
}
