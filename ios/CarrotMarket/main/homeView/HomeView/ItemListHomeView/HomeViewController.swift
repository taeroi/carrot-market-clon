//
//  test1.swift
//  ios
//
//  Created by 태로고침 on 2020/08/30.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import Kingfisher

class HomeViewController: BaseViewController, UIPopoverPresentationControllerDelegate{
    
    // 테이블뷰
    @IBOutlet weak var itemListTableView: UITableView!
    
    // 중고거래 아이템
    var itemList = [Item]()
    
    var refresh = UIRefreshControl()
    
    
    var lastContentOffSet: CGFloat = 0.0
    internal func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.lastContentOffSet < 0 || self.lastContentOffSet > scrollView.contentOffset.y {
            self.navigationController?.navigationBar.isHidden = false
        }
        else if self.lastContentOffSet < scrollView.contentOffset.y{
            self.navigationController?.navigationBar.isHidden = true
        }
        self.lastContentOffSet = scrollView.contentOffset.y
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemListTableView.delegate = self
        itemListTableView.dataSource = self
        setuptHomeVCNavItems()  // 네비게이터 뷰 구성
        
        
        //회원이면 알람 안 띄움
        isMember()
        //MARK: - User Defaults 저장
        let place_id = PLACE_ID
        let dataSave = UserDefaults.standard
        dataSave.setValue(place_id, forKey: "save_placeID")
        
        //15번 게스글리스트 조회 API 연동 - 동네 설정 값으로 조회
        ItemListDataManager().getItemList(self,PLACE_ID)
        
        // tableview refresh
        refresh.tintColor = UIColor.orange
        refresh.addTarget(self, action: #selector(refreshSwipe), for: .valueChanged)
        itemListTableView.addSubview(refresh) // 테이블뷰에 추가
        
        
        let itemCellNib = UINib(nibName: "UsedTradingItemsTableViewCell", bundle: nil)
        self.itemListTableView.register(itemCellNib, forCellReuseIdentifier: "UsedTradingItemsTableViewCell")
        
        itemListTableView.reloadData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        itemListTableView.reloadData()
    }
    
    //동네생활버튼
    @IBAction func neighborhoodLife(_ sender: UIButton) {
        commingSoonPopUp()
    }
    
    @objc func refreshSwipe(){
        itemListTableView.reloadData()
        refresh.endRefreshing()
    }
    
    
    
    // 회원 가입이 되어 있는지 안되어 있는지 확인
    func isMember(){
        if ISMEMBER == 0{
            popUp()
            print("인증이 필요합니다")
        } else{
            print("인증 완료")
        }
    }
    
    // 로그인 팝업창
    func popUp(){
        let loginSB = UIStoryboard(name: "LoginNoticePopUp", bundle: Bundle.main)
        guard let popUP = loginSB.instantiateViewController(withIdentifier: "LoginNoticePopUp") as? LoginNoticePopUp else { return }
        
        popUP.loginNoticePopUpDelegate = self
        popUP.modalPresentationStyle = .custom
        
        self.present(popUP,animated: true, completion: nil)
        
    }
    
    //홈 서치바 뷰 구성
    private func setuptHomeVCNavItems(){
        
        let sortorderButtonITem = UIBarButtonItem(title: MYTOWN, style: .done, target: self, action: #selector(sortorderAction(_:)))
        self.navigationItem.leftBarButtonItem = sortorderButtonITem
        
        
        // 검색 버튼
        let searchBtn = UIBarButtonItem(image: UIImage(named: "icon_search"), style: .plain, target: self, action: #selector(pressedPresentSearchViewController))
        self.navigationItem.rightBarButtonItem = searchBtn
        
        // 관심 카테고리 설정 버튼
        let preferenceSettingBtn = UIBarButtonItem(image: UIImage(named: "icon_preference"), style: .plain, target: self, action: #selector(testing))
        self.navigationItem.rightBarButtonItem = preferenceSettingBtn
        
        // 알람 버튼
        let notificationBtn = UIBarButtonItem(image: UIImage(named: "icon_notification"), style: .plain,target: self, action: #selector(testing))
        self.navigationItem.rightBarButtonItem = notificationBtn
        
        //네비게이션바 우측 버튼 생성
        navigationItem.rightBarButtonItems = [ notificationBtn, preferenceSettingBtn, searchBtn ]
    }
    
    //동네 선택 창 팝오버뷰
    @IBAction func sortorderAction(_ sender: UIBarButtonItem) {
        let sortOrderMytown = SortOrderOptionItem(text: MYTOWN, font: UIFont.systemFont(ofSize: 13), isSelected: true, orderType: .descending)
        let sortOrderPresentSettingBtn = SortOrderOptionItem(text: "내 동네 설정하기", font: UIFont.systemFont(ofSize: 13), isSelected: false, orderType: .ascending)
        presentOptionsPopover(withOptionItems: [[sortOrderMytown, sortOrderPresentSettingBtn]], fromBarButtonItem: sender)
    }
    
    func presentOptionsPopover(withOptionItems items: [[RBOptionItem]], fromBarButtonItem barButtonItem: UIBarButtonItem) {
        let optionItemListVC = RBOptionItemListViewController()
        optionItemListVC.items = items
        
        guard let popoverPresentationController = optionItemListVC.popoverPresentationController else { fatalError("Set Modal presentation style") }
        popoverPresentationController.barButtonItem = barButtonItem
        popoverPresentationController.delegate = self
        self.present(optionItemListVC, animated: true, completion: nil)
    }
    
    
    //검색 컨트롤러로 이동
    @objc fileprivate func pressedPresentSearchViewController() {
        let navigationViewController = self.navigationController
        navigationViewController?.pushViewController(SearchViewController(), animated: true)
    }
    @objc fileprivate func testing(){
        commingSoonPopUp()
    }
    
}

extension HomeViewController: LoginNoticePopUpDelegate{
    func pressedDismissButton() {
        print("LoginNoticePopUp - pressedDismissButton")
    }
}


extension HomeViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = itemListTableView.dequeueReusableCell(withIdentifier: "UsedTradingItemsTableViewCell") as! UsedTradingItemsTableViewCell?
        
        
        
            cell?.usedTradingItemTitleLabel.text = itemList[indexPath.row].title
            cell?.locationLabel.text = itemList[indexPath.row].address
            cell?.priceLabel.text = itemList[indexPath.row].price
            cell?.timeLabel.text = itemList[indexPath.row].post_time
            
            // 사진 다운로드하여 테이블 뷰에 보여주기
            let imgURL = itemList[indexPath.row].post_image_url
            let url = URL(string: imgURL!)
            cell?.usedTradingItemImg?.kf.setImage(with: url)
            
            if imgURL == "" {
                cell?.usedTradingItemImg.image = UIImage(named: "default_Item_img")
            }
            
            //좋아요가 1개 이상 있는 상품만 하트 표시
            if itemList[indexPath.row].post_like_num > 0{
                cell?.likeImage.isHidden = false
                cell?.likeNumberLabel.isHidden = false
                cell!.likeNumberLabel.text! = "\(String(describing: (itemList[indexPath.row].post_like_num)!))"
            }else{
                cell?.likeImage.isHidden = true
                cell?.likeNumberLabel.isHidden = true
                
        }
     
        return cell!
     
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let navigationViewController = self.navigationController
        navigationViewController?.pushViewController(ItemDetailViewController(), animated: true)
        
        POST_ID = itemList[indexPath.row].id
        print(POST_ID)
    }
}

extension HomeViewController: UIScrollViewDelegate{
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}


