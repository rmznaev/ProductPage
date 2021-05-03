//
//  ViewController.swift
//  ProductPage
//
//  Created by Ramazan Abdullayev on 03.05.21.
//

import UIKit

enum SectionType {
    case productPhotos
    case productInfo
    case relatedProducts
}

class ViewController: UIViewController {
    
    private var sections = [SectionType]()
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Amazon Alexa Dot"
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
        sections.append(.productPhotos)
        sections.append(.productInfo)
        sections.append(.relatedProducts)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Hello"
        
        return cell
    }
}
