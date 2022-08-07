//
//  ViewController.swift
//  RaywenderichTutorial
//
//  Created by Maneesh M on 07/08/22.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    // MARK: - Properties
    fileprivate let bag = DisposeBag()
  
    //input
    fileprivate let allSymbols = ["RZW", "UDP","MTT","ZKQ", "IPK", "EQU" ]
    fileprivate let allPrices = PublishSubject<[StockPrice]>()
    //output
    fileprivate let prices = PublishSubject<[StockPrice]>()
    
    fileprivate let dispiseBag = DisposeBag()
 
    // MARK: - IBOutlets
    @IBOutlet var tableView: UITableView!
    @IBOutlet var favoritesSwitch: UISwitch!
    @IBOutlet var searchTerm: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //bind UI
        bindUI()
        
        
        //initialize data
        let prices = allSymbols.enumerated () .map { index, symbol in
            
            return StockPrice(symbol: symbol, favorite: index % 2 == 0)
        }
        allPrices.onNext (prices)
        allPrices.onCompleted()
        //prices.value = allPrices.value
        
        
    }


}

extension ViewController {
    func bindUI(){
        Observable.combineLatest(
            allPrices.asObservable(),
            favoritesSwitch.rx.isOn,
            searchTerm.rx.text) { currentPrices, onlyFavorites, search in
//                print(currentPrices)
//                print(onlyFavorites)
//                print(search)
                return prices.filter { price -> Bool in
                    return self.shouldDisplayPrice(price: price, onlyFavorites: onlyFavorites, search: search)
                }
            }.bind(to: prices).disposed(by: dispiseBag)
        
        prices.asObservable()
            .subscribe(onNext: { [weak self] value in
                self?.tableView.reloadData()
            }).disposed(by: dispiseBag)
    }
    
    fileprivate func shouldDisplayPrice(price: StockPrice, onlyFavorites: Bool, search: String?) -> Bool {
        
        if onlyFavorites && !price.favorite {
            return false
        }
        if let search = search, !search.isEmpty, !price.symbol.contains(search) {
            return false
        }
    }
    
    fileprivate func update(prices: [StockPrice], with newPrices: [String:Double]) -> [StockPrice] {
        for (key, newPrice) in newPrices {
            if let stockPrice = prices.filter({$0.symbol == key }).first {
                stockPrice.update(newPrices)
            }
        }
        return prices
    }
}




//extension ViewController: UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return self.prices.values.
//    }
//}
