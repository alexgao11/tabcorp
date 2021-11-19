//
//  ViewController.swift
//  TabcorpTest
//
//  Created by Alex Gao on 19/11/21.
//

import UIKit
import RxCocoa
import RxSwift

class CityListViewController: UIViewController {
    
    @IBOutlet weak var cityListTableView: UITableView!
    
    let disposeBag = DisposeBag()
    let service = CityService()
    var viewModel: CitiesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel = CitiesViewModel(service: service)
        setupBindings()
        setupTableView()
        viewModel.getCities()
    }
    
    private func setupTableView() {
        cityListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cityCell")
        
        cityListTableView
            .rx
            .modelSelected(CityDetail.self)
            .subscribe(onNext: { [weak self] detail in
                print(detail)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupBindings() {
        viewModel
            .errorMessage
            .observe(on: MainScheduler.instance)
            .subscribe { errorMessage in
                print(errorMessage)
            }
            .disposed(by: disposeBag)
        
        viewModel
            .cities
            .bind(to: cityListTableView.rx.items(cellIdentifier: "cityCell", cellType: UITableViewCell.self)) { row, element, cell in
                cell.textLabel?.text = element.name
            }
            .disposed(by: disposeBag)
    }
    
}

