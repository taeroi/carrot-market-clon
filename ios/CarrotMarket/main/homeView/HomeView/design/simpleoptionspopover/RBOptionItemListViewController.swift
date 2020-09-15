//
//  File2.swift
//  ios
//
//  Created by 태로고침 on 2020/09/06.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//

import UIKit

protocol RBOptionItemListViewControllerDelegate: class {
    func optionItemListViewController(_ controller: RBOptionItemListViewController, didSelectOptionItem item: RBOptionItem)
}

class RBOptionItemListViewController: BaseViewController {
    var items = [[RBOptionItem]]() {
        didSet {
            calculateAndSetPreferredContentSize()
        }
    }
    private(set) weak var tableView: UITableView?
    weak var delegate: RBOptionItemListViewControllerDelegate?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        modalPresentationStyle = .popover
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UITableView(frame: .zero, style: UITableView.Style.plain)
        tableView = view as? UITableView
        tableView?.isScrollEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }
    
    func calculateAndSetPreferredContentSize() {
        let approxAccessoryViewWidth: CGFloat = 0
        let maxWidth = items.flatMap{ $0 }.reduce(0) { $1.sizeForDisplayText().width + approxAccessoryViewWidth > $0 ? $1.sizeForDisplayText().width + 130 : $0 }
        let totalItems = CGFloat(items.flatMap{ $0 }.count)
        let totalHeight = totalItems * 40
        preferredContentSize = CGSize(width: maxWidth, height: totalHeight)
    }
}

extension RBOptionItemListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let item = items[indexPath.section][indexPath.row]
        cell.configure(with:item)
        return cell
    }
}

// MARK: - 테이블 셀 선택
extension RBOptionItemListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.section][indexPath.row]
        delegate?.optionItemListViewController(self, didSelectOptionItem: item)
        
    }
}



