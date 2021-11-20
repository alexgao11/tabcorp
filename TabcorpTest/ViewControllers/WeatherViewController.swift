//
//  WeatherViewController.swift
//  TabcorpTest
//
//  Created by Alex Gao on 20/11/21.
//

import UIKit
import RxSwift

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var detailsTextView: UITextView!
    
    var viewModel: WeatherViewModel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupBindings()
        viewModel.getWeather()
    }
    
    private func setupBindings() {
        viewModel
            .error
            .observe(on: MainScheduler.instance)
            .subscribe{error in
                print(error)
            }
            .disposed(by: disposeBag)
        
        viewModel
            .weather
            .map({ weather in
                weather.cityName
            })
            .bind(to: cityNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel
            .weather
            .map({ weather in
                String(describing: weather)
            })
            .bind(to: detailsTextView.rx.text)
            .disposed(by: disposeBag)
    }
    
}

