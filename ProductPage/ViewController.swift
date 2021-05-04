//
//  ViewController.swift
//  ProductPage
//
//  Created by Ramazan Abdullayev on 03.05.21.
//

import UIKit

struct TextCellViewModel {
    let text: String
    let font: UIFont
}

enum SectionType {
    case productPhotos(images: [UIImage])
    case productInfo(viewModels: [TextCellViewModel])
    case relatedProducts(viewModels: [RelatedProductTableViewCellModel])
    
    var title: String? {
        switch self {
        case .relatedProducts:
            return "Related Products"
        default:
            return nil
        }
    }
}

class ViewController: UIViewController {
    
    private var sections = [SectionType]()
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.register(PhotoCarouselTableViewCell.self,
                      forCellReuseIdentifier: PhotoCarouselTableViewCell.identifier)
        view.register(RelatedProductTableViewCell.self,
                      forCellReuseIdentifier: RelatedProductTableViewCell.identifier)
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Alexa Dot"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        configureSections()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        tableView.frame = view.bounds
    }
    
    private func configureSections() {
        sections.append(.productPhotos(images: [
            UIImage(named: "photoOne"),
            UIImage(named: "photoTwo"),
            UIImage(named: "photoThree"),
            UIImage(named: "photoFour")
        ].compactMap({ $0 })))
        sections.append(.productInfo(viewModels: [
            TextCellViewModel(
                text: "Echo dot is a great home speaker device from Amazon to do stuff. Echo dot is a great home speaker device from Amazon to do stuff. Echo dot is a great home speaker device from Amazon to do stuff. Echo dot is a great home speaker device from Amazon to do stuff. Echo dot is a great home speaker device from Amazon to do stuff. Echo dot is a great home speaker device from Amazon to do stuff. ",
                font: .systemFont(ofSize: 18)
            ),
            TextCellViewModel(
                text: "Price: $49.99",
                font: .systemFont(ofSize: 22)
            )
        ]))
        sections.append(.relatedProducts(viewModels: [
            RelatedProductTableViewCellModel(title: "Amazon TV remote controller",
                                             image: UIImage(named: "relatedOne")),
            RelatedProductTableViewCellModel(title: "Meet the need Bag",
                                             image: UIImage(named: "relatedTwo")),
            RelatedProductTableViewCellModel(title: "Canon Photography Camera",
                                             image: UIImage(named: "relatedThree")),
            RelatedProductTableViewCellModel(title: "Book by Stephen Hawking",
                                             image: UIImage(named: "relatedFour")),
        ]))
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = sections[section]
        
        switch sectionType {
        case .productPhotos:
            return 1
        case .productInfo(let viewModels):
            return viewModels.count
        case .relatedProducts(let viewModels):
            return viewModels.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = sections[indexPath.section]
        
        switch sectionType {
        case .productPhotos(let images):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoCarouselTableViewCell.identifier, for: indexPath) as? PhotoCarouselTableViewCell else { fatalError() }
            cell.configure(with: images)
            return cell
        case .productInfo(let models):
            let model = models[indexPath.row]
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "cell",
                for: indexPath
            )
            cell.configure(with: model)
            return cell
        case .relatedProducts(let viewModels):
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: RelatedProductTableViewCell.identifier,
                    for: indexPath) as? RelatedProductTableViewCell else { fatalError() }
            cell.configure(with: viewModels[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionType = sections[indexPath.section]
        switch sectionType {
        case .productPhotos:
            return view.frame.size.width
        case .productInfo:
            return UITableView.automaticDimension
        case .relatedProducts:
            return 150 //UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionType = sections[section]
        
        return sectionType.title
    }
}

extension UITableViewCell {
    func configure(with model: TextCellViewModel) {
        textLabel?.text = model.text
        textLabel?.numberOfLines = 0
        textLabel?.font = model.font
    }
}
