//
//  TodoCell.swift
//  TodoList
//
//  Created by Muhammad Ashary on 07/10/19.
//  Copyright © 2019 M. Ashary. All rights reserved.
//

import UIKit

protocol TodoCellDelegate {
    func checkmarkTapped(sender: TodoCell)
}

class TodoCell: UITableViewCell {
    
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var delegate: TodoCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Actions
    
    @IBAction func completeButtonTapped(_ sender: Any) {
        delegate?.checkmarkTapped(sender: self)
    }
    

}
