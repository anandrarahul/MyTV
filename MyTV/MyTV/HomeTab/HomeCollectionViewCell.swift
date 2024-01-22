//
//  HomeCollectionViewCell.swift
//  MyTV
//
//  Created by Rahul Anand on 21/01/24.
//

import UIKit

protocol ImageLoaderProtocol {
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void)
}

class ImageLoader: ImageLoaderProtocol {
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }.resume()
    }
}

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var imageLoader: ImageLoaderProtocol = ImageLoader()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageView.image = UIImage(named: "noImage")
    }
    
    func setThumbnailAndTitle(thumbnail: String?, title: String?) {
        if let title = title {
            self.titleLabel.text = title
        }
        guard let thumb = thumbnail, let thumbnailUrl = URL(string: thumb) else {
            return
        }
        self.imageLoader.loadImage(from: thumbnailUrl) { [weak self] image in
            DispatchQueue.main.async {
                if let strongSelf = self {
                    if let image = image {
                        strongSelf.imageView.image = image
                    } else {
                        strongSelf.imageView.image = UIImage(named: "noImage")
                    }
                }
            }
        }
    }

}
