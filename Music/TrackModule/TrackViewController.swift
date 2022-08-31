//
//  TrackViewController.swift
//  Music
//
//  Created by Alice Romanova on 31.08.2022.
//

import UIKit

protocol TrackDiasplayLogic: AnyObject {
    
}
 

final class TrackViewController: UIViewController {
    
    var interactor: TrackBisnessLogic?
    var router: TrackRoutingLogic?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}





//MARK: - TrackDiasplayLogic

extension TrackViewController: TrackDiasplayLogic {
    
}
