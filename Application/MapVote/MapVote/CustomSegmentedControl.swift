//
//  CustomSegmentedControl.swift
//  MapVote
//
//  Created by Lingostar on 2021/02/28.
//

import UIKit

class CustomSegmentedControl: UISegmentedControl {
    
    
    override func layoutSubviews(){
        super.layoutSubviews()
        
        let segmentStringSelected: [NSAttributedString.Key : Any] = [
          NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        ]
        let segmentStringHighlited: [NSAttributedString.Key : Any] = [
          NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0, green: 0.861200273, blue: 0.67304039, alpha: 1)
        ]
        setTitleTextAttributes(segmentStringHighlited, for: .normal)
        setTitleTextAttributes(segmentStringSelected, for: .selected)
        
        selectedSegmentTintColor = #colorLiteral(red: 0, green: 0.861200273, blue: 0.67304039, alpha: 1)
        layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        //background
        layer.cornerRadius = bounds.height / 2
        layer.borderWidth = 2.0
        layer.borderColor = #colorLiteral(red: 0, green: 0.861200273, blue: 0.67304039, alpha: 1)

        let foregroundIndex = numberOfSegments
        if subviews.indices.contains(foregroundIndex),
          let foregroundImageView = subviews[foregroundIndex] as? UIImageView {
          foregroundImageView.image = UIImage()
          foregroundImageView.backgroundColor = #colorLiteral(red: 0, green: 0.861200273, blue: 0.67304039, alpha: 1)
          foregroundImageView.layer.cornerRadius = bounds.height / 2 + 3
        }
      }
}

extension UISegmentedControl {
    func replaceSegments(segmentNames : [String]) {
        self.removeAllSegments()
        for name in segmentNames {
            self.insertSegment(withTitle: name, at: self.numberOfSegments, animated: false)
        }
    }
}
