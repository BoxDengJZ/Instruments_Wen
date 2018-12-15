//
//  ViewController.swift
//  Catstagram-Starter
//
//  Created by Luke Parham on 2/9/17.
//  Copyright © 2017 Luke Parham. All rights reserved.
//

import UIKit
import CoreMotion

class CatFeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let kCatCellIdentifier = "CatPhotoTableViewCell"
    private let screensFromBottomToLoadMoreCats: CGFloat = 2.5
    
    private var photoFeed: PhotoFeedModel?
    private let tableView = UITableView(frame: CGRect.zero, style: .plain)
    private let activityIndicatorView = UIActivityIndicatorView(style: .gray)
    
    private let motionManager = CMMotionManager()
    private var lastY = 0.0

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = "500PX"
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoFeed = PhotoFeedModel(imageSize: imageSizeForScreenWidth())
        view.backgroundColor = UIColor.white
        
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        
        tableView.register(UINib(nibName: kCatCellIdentifier, bundle: nil), forCellReuseIdentifier: kCatCellIdentifier)
        view.addSubview(tableView)
        tableView.addSubview(activityIndicatorView)
        tableView.frame = view.bounds
        activityIndicatorView.center = CGPoint(x: view.bounds.size.width/2.0, y: view.bounds.size.height/2.0)

        refreshFeed()
        motionManager.startDeviceMotionUpdates(to: .main, withHandler:{ [weak self ] deviceMotion, error in
            guard let deviceMotion = deviceMotion else { return }
            guard abs(self?.lastY ?? 0 - deviceMotion.rotationRate.y) > 0.1 else { return }
            self?.lastY = deviceMotion.rotationRate.y
            let xRotationRate = CGFloat(deviceMotion.rotationRate.x)
            let yRotationRate = CGFloat(deviceMotion.rotationRate.y)
            let zRotationRate = CGFloat(deviceMotion.rotationRate.z)

            
            //  y > z, 这个动作是翘起来
            //  y > x + z, 这个动作是斜着翘起来
              if abs(yRotationRate) > (abs(xRotationRate) + abs(zRotationRate)) {
                for cell in self?.tableView.visibleCells as! [CatPhotoTableViewCell] {
                    cell.panImage(with: yRotationRate)
                }
              }
            
            
            //  meaning the y , is the main way , we turn things
            //  we pass that y to the pan image method. to move our image around.
            
            
            //  Since these events are always happening,
            //  that means we are probably passing a lot of really amall values of y, into this method here,
            //  and we are always updating this image.
            
            
            // if wannas stop doing all this unnecessary work,
            // 应当 is check to see that
            // y moved greater than some threshold amout,
        })
    }
    

    func refreshFeed() {
        guard let photoFeed = photoFeed else { return }
        
        activityIndicatorView.startAnimating()
        photoFeed.refreshFeed(with: 4) { [unowned self] (photoModels) in
            self.activityIndicatorView.stopAnimating()
            self.insert(newRows: photoModels)
            self.loadPage()
        }
    }
    
    func loadPage() {
        guard let photoFeed = photoFeed else { return }

        photoFeed.requestPage(with: 20) { (photoModels) in
            self.insert(newRows: photoModels)
        }
    }
    
    func insert(newRows photoModels: [PhotoModel]) {
        guard let photoFeed = photoFeed else { return }

        var indexPaths = [IndexPath]()
        
        let newTotal = photoFeed.numberOfItemsInFeed()
        for i in (newTotal - photoModels.count)..<newTotal {
            indexPaths.append(IndexPath(row: i, section: 0))
        }
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    
    //MARK: Table View Delegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCatCellIdentifier, for: indexPath) as! CatPhotoTableViewCell
 
        tableView.backgroundColor = UIColor.lightGray
        //TODO: leave this in as an error left behind from some other developer.
        //  The cells used to have round corners but now they dont
        cell.layer.cornerRadius = 40.0
        cell.clipsToBounds = true
        cell.updateCell(with: photoFeed?.object(at: indexPath.row))
        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let photoModel = photoFeed?.object(at: indexPath.row) {
            return CatPhotoTableViewCell.height(forPhoto: photoModel, with: view.bounds.size.width)
        }
        return 0
    }
    
    
    
    //MARK: Table View DataSource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoFeed?.numberOfItemsInFeed() ?? 0
    }

    //MARK: Scroll View Delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let screensFromBottom = (scrollView.contentSize.height - scrollView.contentOffset.y)/UIScreen.main.bounds.size.height;
        
        if screensFromBottom < screensFromBottomToLoadMoreCats {
            loadPage()
        }
    }
    
    //MARK: Helpers
    func imageSizeForScreenWidth() -> CGSize {
        let screenRect = UIScreen.main.bounds
        let scale = UIScreen.main.scale
        
        return CGSize(width: screenRect.width * scale, height: screenRect.width * scale)
    }
    
    func resetAllData() {
        photoFeed?.clearFeed()
        tableView.reloadData()
        refreshFeed()
    }
}

