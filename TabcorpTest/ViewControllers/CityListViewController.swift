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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWeather" {
            guard let detail = sender as? CityDetail, let destinationVC = segue.destination as? WeatherViewController else {
                return
            }
            
            let weatherService = WeatherService(cityId: "\(detail.id)")
            let detailsViewModel = WeatherViewModel(service: weatherService)
            destinationVC.viewModel = detailsViewModel
        }
    }
    
    private func setupTableView() {
        cityListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cityCell")
        
        cityListTableView
            .rx
            .modelSelected(CityDetail.self)
            .subscribe(onNext: { [weak self] detail in
                self?.performSegue(withIdentifier: "showWeather", sender: detail)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupBindings() {
        viewModel
            .error
            .observe(on: MainScheduler.instance)
            .subscribe { error in
                print(error.element ?? "")
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

