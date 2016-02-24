//
//  TableViewCell.swift
//  CourseData
//
//  Created by CharlieWu on 1/12/16.
//  Copyright © 2016 CharlieWu. All rights reserved.
//

import UIKit

class CourseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var subjectLabel: UILabel!
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

class CourseDetailTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var subjectLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class CourseInfoTableViewCell: UITableViewCell {
    
    @IBOutlet var fieldLabel:UILabel!
    @IBOutlet var valueLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        sharedInit()
        // Configure the view for the selected state
    }
    
        func sharedInit() {
            userInteractionEnabled = true
            addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: "showMenu:"))
        }
    
        func showMenu(sender: AnyObject?) {
            becomeFirstResponder()
            let menu = UIMenuController.sharedMenuController()
            if !menu.menuVisible {
                menu.setTargetRect(bounds, inView: self)
                menu.setMenuVisible(true, animated: true)
            }
        }
    
    
        override func copy(sender: AnyObject?) {
            let board = UIPasteboard.generalPasteboard()
            board.string = valueLabel.text
            let menu = UIMenuController.sharedMenuController()
            menu.setMenuVisible(false, animated: true)
        }
    
        override func canBecomeFirstResponder() -> Bool {
            return true
        }
    
        override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
            if action == "copy:" {
                return true
            }
            return false
        }
    
}

//import UIKit
//
//class SRCopyableLabel: UILabel {
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        sharedInit()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        sharedInit()
//    }
//    
//    func sharedInit() {
//        userInteractionEnabled = true
//        addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: "showMenu:"))
//    }
//    
//    func showMenu(sender: AnyObject?) {
//        becomeFirstResponder()
//        let menu = UIMenuController.sharedMenuController()
//        if !menu.menuVisible {
//            menu.setTargetRect(bounds, inView: self)
//            menu.setMenuVisible(true, animated: true)
//        }
//    }
//    
//    
//    override func copy(sender: AnyObject?) {
//        let board = UIPasteboard.generalPasteboard()
//        board.string = text
//        let menu = UIMenuController.sharedMenuController()
//        menu.setMenuVisible(false, animated: true)
//    }
//    
//    override func canBecomeFirstResponder() -> Bool {
//        return true
//    }
//    
//    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
//        if action == "copy:" {
//            return true
//        }
//        return false
//    }
//    
//    
//}

