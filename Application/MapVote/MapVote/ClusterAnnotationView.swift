//
//  ClusterAnnotationView.swift
//  MapVote
//
//  Created by LingoStar on 2021/03/01.
//

import UIKit
import MapKit

struct DrawAnnotation{
    var count: Int
    var color: UIColor
}

class ClusterAnnotationView: MKAnnotationView {

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        collisionMode = .circle
        centerOffset = CGPoint(x: 0, y: -10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()

        if let cluster = annotation as? MKClusterAnnotation {
            let totalAnnotations = cluster.memberAnnotations.count
            
            let colors : [UIColor?] = [UIColor(named: "color1"), UIColor(named: "color2"), UIColor(named: "color3")]
            
            var drawAnnotations : [DrawAnnotation] = []
            
            for i in 0..<categoryData.count{
                drawAnnotations.append(DrawAnnotation(count: count(itemName: categoryData[i].categoryName), color: colors[i]!))
            }

            image = drawRatio(drawAnnotations, to: totalAnnotations)
            
        }
    }
    
    // MARK: - 실제 원을 그리는 부분
    private func drawRatio(_ drawAnnotations: [DrawAnnotation], to whole: Int) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 40, height: 40))
        return renderer.image { _ in
            
            var angles : [CGFloat] = []
            var angle : CGFloat = 0
            var beforeAngle : CGFloat = 0
            var beforeAngles : [CGFloat] = []
            var piePaths : [UIBezierPath] = []

            for i in 0..<drawAnnotations.count {
                beforeAngles.append(beforeAngle)
                angle = beforeAngle + (CGFloat.pi * 2.0 * CGFloat(drawAnnotations[i].count)) / CGFloat(whole)
                beforeAngle = angle
                angles.append(angle)
                
                let piePath = UIBezierPath()
                piePaths.append(piePath)
            }
            
            for i in 0..<drawAnnotations.count {
                drawAnnotations[i].color.setFill()
                
                piePaths[i].addArc(withCenter: CGPoint(x: 20, y: 20), radius: 20,
                               startAngle: beforeAngles[i], endAngle: angles[i],
                               clockwise: true)
                piePaths[i].addLine(to: CGPoint(x: 20, y: 20))
                piePaths[i].close()
                piePaths[i].fill()
            }

            // Fill inner circle with white color
            UIColor.white.setFill()
            UIBezierPath(ovalIn: CGRect(x: 8, y: 8, width: 24, height: 24)).fill()

            // Finally draw count text vertically and horizontally centered
            let attributes = [ NSAttributedString.Key.foregroundColor: UIColor.black,
                               NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
            let text = "\(whole)"
            let size = text.size(withAttributes: attributes)
            let rect = CGRect(x: 20 - size.width / 2, y: 20 - size.height / 2, width: size.width, height: size.height)
            text.draw(in: rect, withAttributes: attributes)
        }
    }
    
    // MARK: - cluster의 annotation 개수 count
    private func count(itemName : String) -> Int {
        guard let cluster = annotation as? MKClusterAnnotation else {
            return 0
        }

        //cluster의 memberAnnotations에서 count할 item인 것만 filter하여 count
        return cluster.memberAnnotations.filter { member -> Bool in
            guard let annotation = member as? Annotation else {
                fatalError("Found unexpected annotation type")
            }
            //annotation의 itemName이 count할 itemName인지 체크
            return categoryNameForItem(annotation.item) == itemName
        }.count
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
