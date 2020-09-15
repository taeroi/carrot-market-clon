//
//  Category.swift
//  ios
//
//  Created by 태로고침 on 2020/09/08.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//

import UIKit

class CategoryViewController: BaseViewController {
    
    @IBOutlet weak var categoryTableView: UITableView!
    
    var categories = [Category]()
    var prevViewController: WriteViewPopUp?  //button delegate
    var prevViewController2: EditViewPopUp? //수정
          
    override func viewDidLoad() {
        super.viewDidLoad()
        CategoryDataManager().getCategory(self)
        
        let categoryCellNib = UINib(nibName: "CategoryTableViewCell", bundle: nil)
        self.categoryTableView.register(categoryCellNib, forCellReuseIdentifier: "CategoryTableViewCell")
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        
        prevViewController?.categoryDelegate = self
        prevViewController2?.categoryDelegate = self
    }
}

extension CategoryViewController: UITableViewDataSource, UITableViewDelegate,ChangeCategoryBtnText,ChangeCategoryBtnText2{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = categoryTableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell") as! CategoryTableViewCell?
        cell!.categoryKindLabel?.text = categories[indexPath.row].name!
        
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = categoryTableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell") as! CategoryTableViewCell?
        cell!.categoryKindLabel?.text = categories[indexPath.row].name!
        
        let category = categories[indexPath.row].id!
        CATEGORY = category
        print("Selected Category is \(categories[indexPath.row].name!)")
        print("Selected Category's ID is \(categories[indexPath.row].id)")

        changeCategory((cell?.categoryKindLabel.text)!)
        changeCategory2((cell?.categoryKindLabel.text)!)
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    //WriteViewPopUp delegate func -
    func changeCategory(_ categoryTitle: String) {
        prevViewController?.categorySelectBtn.setTitle(categoryTitle, for: .normal) //게시
        print("selected changeCategory -> \(categoryTitle)")
    }
    
    
    func changeCategory2(_ categoryTitle: String) {
           prevViewController2?.categorySelectBtn.setTitle(categoryTitle, for: .normal) //수정
           print("selected changeCategory -> \(categoryTitle)")
       }
    
    
    
}
