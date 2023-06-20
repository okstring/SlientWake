//
//  WheelViewController.swift
//  NewlabUIKit
//
//  Created by Ok Hyeon Kim on 2023/06/09.
//

import UIKit

protocol WheelViewControllerDelegate: AnyObject {
    func wheelViewController(_ viewController: WheelViewController, didSelectItemAtRow row: Int)
}

class WheelViewController: UIViewController {
    enum SectionAccessoryViewType {
        case header, footer
    }

    weak var delegate: WheelViewControllerDelegate?

    var tableView: UITableView! = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.rowHeight = 0
        tableView.estimatedRowHeight = 0
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = false
        tableView.delaysContentTouches = true
        return tableView
    }()

    var items: [String] = []

    var stripOne: UIView = {
        let view = UIView()
        return view
    }()

    var stripTwo: UIView = {
        let view = UIView()
        return view
    }()

    var itemHeight: CGFloat = 0
    var backgroundColor: UIColor = .black.withAlphaComponent(0.5)
    var cellBackgroundColor: UIColor = .white.withAlphaComponent(0.1)
    var stripColor: UIColor = .black
    var cellTextColor: UIColor = .black
    var cellTextFont: UIFont = UIFont.systemFont(ofSize: 15)

    var selectedIndexPath = IndexPath(row: 0, section: 0) {
        didSet {
            guard isViewLoaded, items.count > 0, selectedIndexPath.row >= 0, selectedIndexPath.row < items.count else {
                return
            }

            tableView.scrollToRow(at: selectedIndexPath, at: .top, animated: true)
            delegate?.wheelViewController(self, didSelectItemAtRow: selectedIndexPath.row)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    override func viewDidLayoutSubviews() {
        var rect = CGRect.zero

        rect.size = view.bounds.size
        tableView.frame = rect

        rect.size.height = 2
        rect.size.width = view.bounds.width
        rect.origin.y = view.bounds.height / 3
        stripOne.frame = rect

        rect.origin.y = (rect.origin.y * 2) - rect.height
        stripTwo.frame = rect
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        tableView.scrollToRow(at: selectedIndexPath, at: .top, animated: true)
    }

    private func setUI() {
        view.backgroundColor = .white
        tableView.backgroundColor = .black

        stripOne.backgroundColor = stripColor
        stripTwo.backgroundColor = stripColor

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "CellHeaderFooter")

        tableView.dataSource = self
        tableView.delegate = self

        view.addSubview(tableView)
        view.addSubview(stripOne)
        view.addSubview(stripTwo)

        tableView.reloadData()
    }

    public func setAttribute(_ attribute: ThemeAttribute) {
        backgroundColor = attribute.contentViewBackgroundColor
        cellBackgroundColor = attribute.wheelCellBackgroundColor
        stripColor = attribute.stripColor
        cellTextFont = attribute.wheelFont
        cellTextColor = attribute.wheelTextColor
    }

    public func getCurrnetIndexPath() -> IndexPath {
        let point = CGPoint(
            x: tableView.center.x + tableView.contentOffset.x,
            y: tableView.center.y + tableView.contentOffset.y
        )

        let indexPath = tableView.indexPathForRow(at: point)

        guard let indexPath = indexPath else {
            return IndexPath(index: 0)
        }

        delegate?.wheelViewController(self, didSelectItemAtRow: selectedIndexPath.row)

        return indexPath
    }

}

extension WheelViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.numberOfLines = 1
        cell.textLabel?.minimumScaleFactor = 0.1
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.font = cellTextFont
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = cellTextColor
        cell.textLabel?.text = items[indexPath.row]
        cell.selectionStyle = .none
        cell.backgroundColor = cellBackgroundColor
        cell.contentView.backgroundColor = .clear
        return cell
    }

    private func dequeueHeaderFooter(from tableView: UITableView, type: SectionAccessoryViewType) -> UITableViewHeaderFooterView {
        guard let headerFooter = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CellHeaderFooter") else {
            return UITableViewHeaderFooterView()
        }

        if headerFooter.backgroundView == nil {
            let view = UIView()
            view.backgroundColor = backgroundColor
            headerFooter.backgroundView = view
        }
        return headerFooter
    }
}

extension WheelViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return itemHeight
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return itemHeight
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return itemHeight
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return dequeueHeaderFooter(from: tableView, type: .header)
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return dequeueHeaderFooter(from: tableView, type: .footer)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let point = CGPoint(
            x: scrollView.center.x + scrollView.contentOffset.x,
            y: scrollView.center.y + scrollView.contentOffset.y
        )

        let indexPath = tableView.indexPathForRow(at: point)

        guard let indexPath = indexPath else {
            return
        }

        selectedIndexPath = indexPath
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard !decelerate else { return }

        scrollViewDidEndDecelerating(scrollView)
    }
}
