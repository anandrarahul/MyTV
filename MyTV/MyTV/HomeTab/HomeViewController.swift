//
//  HomeViewController.swift
//  MyTV
//
//  Created by Rahul Anand on 19/12/23.
//

import UIKit
import Foundation

class HomeViewController: UIViewController {

    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    
    private let restApi = RestAPI()
    var videoDetailsList: [VideoDetails] = []
    
    @IBAction func refreshButtonTapped(_ sender: UIButton) {
        self.homeCollectionView.isHidden = true
        self.activityIndicator.isHidden = false
        self.errorLabel.isHidden = true
        self.refreshButton.isHidden = true
        self.activityIndicator.startAnimating()
        self.performNetworkCall()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeCollectionView.dataSource = self
        self.homeCollectionView.delegate = self
        self.homeCollectionView.isHidden = true
        self.activityIndicator.isHidden = false
        self.errorLabel.isHidden = true
        self.refreshButton.isHidden = true
        self.activityIndicator.startAnimating()
        let nib = UINib(nibName: "HomeCollectionViewCell", bundle: nil)
        self.homeCollectionView.register(nib, forCellWithReuseIdentifier: "HomeCollectionViewCell")
        self.performNetworkCall()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = NSLocalizedString("home.title", comment: "")
    }
    
    private func performNetworkCall() {
        
        if let endpoint = self.restApi.getUrlForVideos() {
            VideoListNetworkService.fetchVideoList(endpoint: endpoint) { videoDetails, error in
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    if let err = error {
                        self.errorLabel.text = "An error occured during network call \(err).\nPlease Refresh."
                        self.errorLabel.isHidden = false
                        self.refreshButton.isHidden = false
                    } else {
                        self.homeCollectionView.isHidden = false
                        self.videoDetailsList.append(contentsOf: videoDetails ?? [])
                        self.homeCollectionView.reloadData()
                    }
                }
            }
        } else {
            self.errorLabel.text = "Invalid Endpoint.\nPlease Refresh."
            self.errorLabel.isHidden = false
            self.refreshButton.isHidden = false
        }
    }

}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let homeCollectionViewCell = self.homeCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        return homeCollectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = self.homeCollectionView.frame.width - 20
        let cellHeight = self.homeCollectionView.frame.height * 0.4
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
