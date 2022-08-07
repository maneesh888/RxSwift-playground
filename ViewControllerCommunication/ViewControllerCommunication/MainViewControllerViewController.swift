//
//  ViewController.swift
//  ViewControllerCommunication
//
//  Created by Maneesh M on 07/08/22.
//

import UIKit
import RxSwift

class MainViewController: UIViewController {
    
    @IBOutlet weak var greetingsLabel: UILabel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectCharacter (_ sender: Any) {
        
        let detailVC = storyboard?.instantiateViewController (withIdentifier: "DetailViewController") as!
        DetailViewController
       
        detailVC.selectedCharecer.subscribe { [weak self] charecter in
            self?.greetingsLabel.text = "Hello \(charecter)"
        }.disposed(by: disposeBag)
        
        navigationController?.pushViewController(detailVC,animated: true)
    }
    
    func didSelectCharacter (_ name: String) {
        
    }
    
}

