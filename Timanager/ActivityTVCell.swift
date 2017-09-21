//
//  ActivityTVCell.swift
//  Timanager
//
//  Created by Kryg Tomasz on 09.07.2017.
//  Copyright © 2017 Kryg Tomek. All rights reserved.
//

import UIKit

class ActivityTVCell: UITableViewCell {

    @IBOutlet weak var nameTextField: UITextField! {
        didSet {
            nameTextField.delegate = self
            nameTextField.isEnabled = false
            nameTextField.textColor = .white
            nameTextField.tintColor = .white
        }
    }
    @IBOutlet weak var nameBackgroundView: UIView! {
        didSet {
            nameBackgroundView.layer.borderWidth = 1.0
            nameBackgroundView.layer.borderColor = UIColor.mainRed.cgColor
            nameBackgroundView.backgroundColor = .mainPastelRed
            nameBackgroundView.layer.cornerRadius = 8
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(false, animated: animated)
    }
    
    var activity: Activity?
    
    func prepare(withName name: String?) {
        self.nameTextField.text = name
    }
    
    func prepare(withActivity activity: Activity?) {
        self.nameTextField.text = activity?.name
        self.activity = activity
    }
    
}

//MARK: TextField delegates
extension ActivityTVCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.isEnabled = false
        guard let text = textField.text else {
            return true
        }
        if text.isEmpty {}
        else {
            activity?.name = textField.text
            do {
                try activity?.managedObjectContext?.save()
            } catch {
                print("Error saving activity object")
            }
        }
        return true
    }
    
}
