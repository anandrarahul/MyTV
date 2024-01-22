//
//  HomeCollectionViewCell.swift
//  MyTV
//
//  Created by Rahul Anand on 21/01/24.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageView.image = UIImage(named: "noImage")
    }
    
    func setThumbnailAndTitle(thumbnail: String?, title: String?) {
        if let thumb = thumbnail {
            let thumbnailUrl = URL(string: thumb)!
            URLSession.shared.dataTask(with: thumbnailUrl) { data, response, error in
                DispatchQueue.main.async {
                    if let _ = error {
                        self.imageView.image = UIImage(named: "noImage")
                    } else {
                        if let imageData = data {
                            self.imageView.image = UIImage(data: imageData)
                        }
                    }
                }
            }.resume()
        }
        if let title = title {
            self.titleLabel.text = title
        }
    }

}
