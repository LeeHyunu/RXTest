//
//  ViewController.swift
//  RXSample
//
//  Created by NICE_hwlee on 03/05/2019.
//  Copyright © 2019 nice. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var button1: UIButton!
    
    let disposeBag = DisposeBag()
    
    var shownCities = [String]()
    let allCities = ["New York", "London", "Oslo", "Warsaw", "Berlin", "Praga"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        searchBar
            .rx.text
            .orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] query in
                print(query)
                self.shownCities = self.allCities.filter({$0.hasPrefix(query)})
                self.tableView.reloadData()
            })
        .disposed(by: disposeBag)
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityPrototypeCell", for: indexPath)
        cell.textLabel?.text = shownCities[indexPath.row]
        
        return cell
    }
    
}

