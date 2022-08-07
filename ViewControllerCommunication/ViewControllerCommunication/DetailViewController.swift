//
//  DetailViewController.swift
//  ViewControllerCommunication
//
//  Created by Maneesh M on 07/08/22.
//

import UIKit
import RxSwift

class DetailViewController: UIViewController {

    private let selectedCharecterVariable = Variable("User")
    var selectedCharecer:Observable<String> {
        return selectedCharecterVariable.asObservable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didSelectCharecter(_ sender: UIButton) {
        guard let charecterName = sender.titleLabel?.text else {return}
        self.selectedCharecterVariable.value = charecterName
    }
    
    

}
