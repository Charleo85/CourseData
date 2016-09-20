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
        addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(CourseInfoTableViewCell.showMenu(_:))))
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

//    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
//        if action == #selector(NSObject.copy()) {
//            return true
//        }
//        return false
//    }
//   copy function
}


class ScheduleTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
     }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .None
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(lineView)
        contentView.addSubview(circleView)
        
        let views = [
            "timeLabel": timeLabel,
            "titleLabel": titleLabel,
            "lineView": lineView,
            "circleView": circleView,
            "contentView": contentView
        ]
        
        let metrics = [
            "margin": 6,
            "leftMargin": 16,
            "lineMargin": 14
        ]
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-(leftMargin)-[timeLabel(80)]-(lineMargin)-[lineView(2)]-(lineMargin)-[titleLabel]-|", options: [], metrics: metrics, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(margin)-[titleLabel]-(margin)-|", options: [], metrics: metrics, views: views))
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[lineView]", options: [], metrics: metrics, views: views))
        contentView.addConstraint(NSLayoutConstraint(item: circleView, attribute: .CenterX, relatedBy: .Equal, toItem: lineView, attribute: .CenterX, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: circleView, attribute: .CenterY, relatedBy: .Equal, toItem: titleLabel, attribute: .CenterY, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: circleView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 14))
        contentView.addConstraint(NSLayoutConstraint(item: circleView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 14))
        contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .CenterY, relatedBy: .Equal, toItem: timeLabel, attribute: .CenterY, multiplier: 1, constant: 0))
        
        contentView.addConstraint(lineViewYConstraint)
        contentView.addConstraint(heightConstraint)

    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir", size: 14)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Light", size: 14)
        label.textColor = UIColor(red: 0.631, green: 0.651, blue: 0.678, alpha: 1)
        label.textAlignment = .Right
        return label
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.906, green: 0.914, blue: 0.918, alpha: 1)
        return view
    }()
    
    lazy var circleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.whiteColor()
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 7
        view.layer.borderColor = UIColor.disabledGreen().CGColor
        return view
    }()
    
    lazy var lineViewYConstraint: NSLayoutConstraint = {
        return NSLayoutConstraint(item: self.lineView, attribute: .Height, relatedBy: .Equal, toItem: self.contentView, attribute: .Height, multiplier: 1.0, constant: 0)
    }()
    
    lazy var heightConstraint: NSLayoutConstraint = {
        return NSLayoutConstraint(item: self.contentView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 55)
    }()

    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    var height: CGFloat = 55 {
        willSet(height) {
            contentView.removeConstraint(heightConstraint)
            heightConstraint.constant = height
            contentView.addConstraint(heightConstraint)
        }
    }
    
    var isLastCell: Bool = false {
        willSet {
            let constant: CGFloat = newValue ? -0.5 * self.contentView.frame.size.height : 0
            lineViewYConstraint.constant = constant
        }
    }
    
    var isCurrent: Bool = false {
        willSet(current) {
            if current {
                circleView.backgroundColor = UIColor.selectedGreen()
                circleView.layer.borderColor = UIColor.selectedGreen().CGColor
                timeLabel.textColor = UIColor.selectedGreen()
            } else {
                circleView.backgroundColor = UIColor.whiteColor()
                circleView.layer.borderColor = UIColor.disabledGreen().CGColor
                timeLabel.textColor = UIColor(red: 0.631, green: 0.651, blue: 0.678, alpha: 1)
            }
        }
    }
    
    func animateTimeLabelTextChange(text: String) {
        let animation = CATransition();
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionFade;
        animation.duration = 0.15;
        timeLabel.layer.addAnimation(animation, forKey: "kCATransitionFade")
        timeLabel.text = text
    }
    
}

extension UIColor {
    
    class func selectedGreen() -> UIColor {
        return UIColor(red: 0.541, green: 0.875, blue: 0.780, alpha: 1)
    }
    
    class func disabledGreen() -> UIColor {
        return UIColor(red: 0.329, green: 0.831, blue: 0.690, alpha: 1)
    }
}





