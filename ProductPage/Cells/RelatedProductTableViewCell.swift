//
//  RelatedProductTableViewCell.swift
//  ProductPage
//
//  Created by Ramazan Abdullayev on 04.05.21.
//

import UIKit

struct RelatedProductTableViewCellModel {
    let title: String
    let image: UIImage?
}

class RelatedProductTableViewCell: UITableViewCell {
    
    static let identifier = "RelatedProductTableViewCell"
    
    private let productImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        
        return view
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(label)
        contentView.addSubview(productImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageSize: CGFloat = contentView.frame.size.height
        productImageView.frame = CGRect(x: 10, y: 0, width: imageSize, height: imageSize)
    
        label.frame = CGRect(x: imageSize + 20,
                             y: 0,
                             width: contentView.frame.size.width - 25 - imageSize,
                             height: imageSize)
    }
    
    public func configure(with model: RelatedProductTableViewCellModel) {
        label.text = model.title
        productImageView.image = model.image
    }
}
