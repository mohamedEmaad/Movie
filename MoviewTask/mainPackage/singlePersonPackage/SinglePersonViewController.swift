//
//  SinglePersonViewController.swift
//  MoviewTask
//
//  Created by Mohamed Emad on 1/14/19.
//  Copyright © 2019 Baianat. All rights reserved.
//

import UIKit
import NewBaseFrameWork
import RxSwift
import RxCocoa

class SinglePersonViewController: ParentViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userJobTitle: UILabel!
    @IBOutlet weak var userBiography: UILabel!
    @IBOutlet weak var imagesLabel: UILabel!
    @IBOutlet weak var userImageCollectionView: UICollectionView!
    @IBOutlet weak var imagesCollectionViewHeight: NSLayoutConstraint!
    var preseneter: SinglePersonPreseneter!
    let disposeBag = DisposeBag()
    var tempUserDetails: (userId: Int, username: String, userImage: String)? = nil
    var imagesList: BehaviorRelay<[Profiles]> = BehaviorRelay(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setupViews()
        self.setupPresenter()
        self.setupListener()
    }
    
    func setupViews(){
        self.userImageView.circleImage()
        self.imagesLabel.text = "Images"
        
        // setup the layout of the images views
        let layout = self.userImageCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidth = (((self.view.frame.width - 32) / 3) - 1)
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 1.5
        self.userImageCollectionView.collectionViewLayout = layout
    }
    
    func setupPresenter(){
        self.preseneter = SinglePersonPreseneter(disposeBag: self.disposeBag, viewPresenter: self)
    }
    
    func setupListener(){
        self.imagesList.asObservable().subscribe(onNext: { (newImages) in
            self.userImageCollectionView.reloadData()
        }).disposed(by: self.disposeBag)
    }
    
    class func getObject() -> SinglePersonViewController{
        return self.create(viewControllerId: "SinglePersonViewController", storyBoardId: "Main") as! SinglePersonViewController
    }

    override func viewWillAppear(_ animated: Bool) {
        self.postTempData()
        self.getPresonDetails()
        self.title = "Profile"
        self.scrollView.setScrollToTop()
    }
    
    /**
        get the data of this preson and the images
     */
    func getPresonDetails(){
        self.preseneter.getUserDetails(userId: self.tempUserDetails?.userId ?? 0)
    }
    
    /**
        show temporary view while the actual data is loaded
     */
    func postTempData(){
        if self.tempUserDetails != nil{
            self.userImageView.loadImageUrl(imageUrl: self.tempUserDetails?.userImage ?? "", placeholder: #imageLiteral(resourceName: "userAvatar"))
            self.usernameLabel.text = self.tempUserDetails?.username
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.emptyView()
    }
    
    /**
        remove all the data of this user
     */
    func emptyView(){
        self.userImageView.image = nil
        self.usernameLabel.text = ""
        self.userBiography.text = ""
        self.userJobTitle.text = ""
        self.imagesList.accept([])
    }
}

extension SinglePersonViewController: SinglePersonViewPresenter{
    
    func postUserImages(profiles: [Profiles]) {
        self.imagesList.accept(profiles)
    }
    
    /**
        setup user data with the view
     */
    func postUserData(userDetails: SinglePersonDetails) {
        self.usernameLabel.text = userDetails.name ?? ""
        self.userJobTitle.text = userDetails.known_for_department ?? ""
        self.userBiography.text = userDetails.biography ?? ""
        
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
    func onError(message: String) {
        self.showSnackBar(text: message, bottomMargin: -30, snackBarStatus: .error)
    }
    
    func onFailure(message: String) {
        self.showSnackBar(text: message, bottomMargin: -30, snackBarStatus: .error)
    }
    
}

extension SinglePersonViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imagesList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: galleryReuableCell, for: indexPath) as? GalleryCollectionViewCell{
            let profileImage = self.imagesList.value[indexPath.row]
            cell.setupImageData(imageUrl: "\(profileImageLink)\(profileImage.file_path ?? "")")
            return cell
        }
        return UICollectionViewCell()
    }
    
    /**
        update the height of the collection view with the height of the images
     */
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.imagesCollectionViewHeight.constant = collectionView.contentSize.height
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
}
