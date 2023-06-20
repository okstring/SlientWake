//
//  TimePickerViewController.swift
//  NewlabUIKit
//
//  Created by Ok Hyeon Kim on 2023/06/09.
//

import UIKit

public class TimePickerViewController: UIViewController {
    let contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 3
        view.layer.masksToBounds = true
        return view
    }()

    let delimiterLabel: UILabel = {
        let label = UILabel()
        label.text = ":"
        label.textAlignment = .center
        return label
    }()

    let hourWheel: WheelViewController = {
        let vc = WheelViewController()
        return vc
    }()

    let minuteWheel: WheelViewController = {
        let vc = WheelViewController()
        return vc
    }()

    let meridianWheel: WheelViewController = {
        let vc = WheelViewController()
        return vc
    }()

    var is24Format: Bool = true
    var contentsViewSize: CGSize = .init(width: 216, height: 210)

    var result: TimePickerResult {
        var result = TimePickerResult()
        result.hour = hourWheel.getCurrnetIndexPath().row + (is24Format ? 0 : 1)
        result.minute = minuteWheel.getCurrnetIndexPath().row
        result.meridian = meridianWheel.getCurrnetIndexPath().row == 0 ? .am : .pm
        result.is24 = is24Format
        return result
    }

    public var theme: Theme = .dark

    public convenience init() {
        self.init(nibName: nil, bundle: nil)
    }

    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }


    public override func viewDidLayoutSubviews() {
        setLayout()
    }

    private func setUI() {
        let attrib = theme.attribute
        is24Format = attrib.is24

        delimiterLabel.textColor = attrib.wheelTextColor
        delimiterLabel.font = attrib.wheelFont

        setWheelItem(attrib)
    }

    private func setWheelItem(_ attribute: ThemeAttribute) {
        var items = [String]()

        if(is24Format) {
            for i in 0..<24 {
                items.append("\(i)")
            }
        } else {
            for i in 1..<13 {
                items.append("\(i)")
            }
        }

        hourWheel.items = items
        hourWheel.setAttribute(attribute)

        items.removeAll()

        for i in 0..<60 {
            i < 10 ? items.append("0\(i)") : items.append("\(i)")
        }

        minuteWheel.items = items
        minuteWheel.setAttribute(attribute)

        let now = Date()
        let calendar = Calendar.current
        var hour = calendar.component(.hour, from: now)
        let minute = calendar.component(.minute, from: now)

        if !is24Format {
            items.removeAll()
            items.append(contentsOf: ["AM", "PM"])

            meridianWheel.items = items
            meridianWheel.setAttribute(attribute)

            let meridian = hour >= 12 && hour < 24 ? 1 : 0
            hour = hour % 12
            hour = hour == 0 ? 12 : hour
            hour -= 1

            meridianWheel.selectedIndexPath = IndexPath(row: meridian, section: 0)
        }

        hourWheel.selectedIndexPath = IndexPath(row: hour, section: 0)
        minuteWheel.selectedIndexPath = IndexPath(row: minute, section: 0)
    }

    private func setLayout() {
        var rect = CGRect.zero

        let contentViewHorizontalMargin: CGFloat = 20
        let contentViewWidth: CGFloat = min(contentsViewSize.width, view.frame.width - contentViewHorizontalMargin * 2)

        let wheelWidth: CGFloat = is24Format ? 72 : 56
        let wheelSpacing: CGFloat = 24
        let totalWidth: CGFloat = is24Format ? (wheelWidth * 2 + wheelSpacing) : wheelWidth * 3 + wheelSpacing * 2
        let totalHeight: CGFloat = 210

        contentsViewSize = .init(width: totalWidth, height: totalHeight)

        rect.size.width = wheelWidth
        rect.size.height = totalHeight
        rect.origin.y = 0
        rect.origin.x = 0
        hourWheel.itemHeight = rect.height / 3
        hourWheel.view.frame = rect

        var delimiterRect = rect
        delimiterRect.size.width = wheelSpacing
        delimiterRect.origin.x = rect.maxX
        delimiterLabel.frame = delimiterRect

        rect.origin.x = rect.maxX + wheelSpacing
        minuteWheel.itemHeight = hourWheel.itemHeight
        minuteWheel.view.frame = rect

        if !is24Format {
            rect.origin.x = rect.maxX + wheelSpacing
            meridianWheel.itemHeight = hourWheel.itemHeight
            meridianWheel.view.frame = rect
        }

        rect.size.height = rect.maxY
        rect.size.width = contentViewWidth
        rect.origin.x = 0
        rect.origin.y = 0
        contentView.frame = rect
        contentView.bounds.size = contentsViewSize

        if contentView.superview == nil {
            view.addSubview(contentView)
            contentView.addSubview(delimiterLabel)
            contentView.addSubview(hourWheel.view)
            contentView.addSubview(minuteWheel.view)

            if !is24Format {
                contentView.addSubview(meridianWheel.view)
                addChild(meridianWheel)
                meridianWheel.didMove(toParent: self)
            }

            addChild(hourWheel)
            addChild(minuteWheel)

            hourWheel.didMove(toParent: self)
            minuteWheel.didMove(toParent: self)
        }
    }
}
