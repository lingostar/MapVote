//
//  WeightTableViewCell.swift
//  MapVote
//
//  Created by LingoStar on 2021/02/26.
//

import UIKit

class WeightTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var weightTextField: UITextField!
    
    var itemPath : IndexPath? {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateUI() {
        guard let indexPath = itemPath else { return }
        itemLabel.text = categoryData[indexPath.section].itemTemplates[indexPath.row].itemName
        weightTextField.text = String(categoryData[indexPath.section].itemTemplates[indexPath.row].weight)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //CategoryData 변경 함수 호출
        updateCategoryData(weightText: weightTextField.text ?? "0", index: itemPath!)
    }
    
}
