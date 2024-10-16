//
//  PostTableViewCell.swift
//  Astra-Tech-Task-1
//
//  Created by Ahmad Ellashy on 15/10/2024.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    //MARK: - UIViews
    private let postImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(systemName: "photo")
        return imageView
    }()
    private let postTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "AShma"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()

//    var imageDownloadedClosure: ()->Void?
  //MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(postImageView)
        contentView.addSubview(postTitleLabel)
    }
    required init?(coder: NSCoder) {
        fatalError("Something went wrong!")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configUIViews()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
        postTitleLabel.text = nil
    }
    
    //MARK: - Helpers
    private func configUIViews(){
        let imageSize = 60
        postImageView.addCornerRadius(radius: CGFloat(imageSize / 2))
        postImageView.frame = CGRect(x: 20, y: 10, width: imageSize, height: imageSize)
        postTitleLabel.frame = CGRect(x:postImageView.right + 20, y: 30, width: width - (postImageView.right + 20), height: 30)

    }
    func config(post:RealPostModel){
        postTitleLabel.text = post.postTitle
        postImageView.image = post.postImage
    }
    
    
    //MARK: - Cell Config
    static let identifier: String = "PostTableViewCell"
}
