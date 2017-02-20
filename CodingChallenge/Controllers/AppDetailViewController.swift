//
//  AppDetailViewController.swift
//  CodingChallenge
//
//  Created by Juan José Villegas on 2/19/17.
//  Copyright © 2017 Juan José Villegas. All rights reserved.
//

import UIKit
import TransitionTreasury
import TransitionAnimation

class AppDetailViewController: UIViewController, NavgationTransitionable {
    
    var appEntry:AppEntry!
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbArtist: UILabel!
    
    @IBOutlet weak var lbSummary: UITextView!
    
    @IBOutlet weak var lbPrice: UILabel!
    
    @IBOutlet weak var lbReleaseDate: UILabel!
    
    @IBOutlet weak var lbRights: UILabel!
    
    @IBOutlet weak var lbCategory: UILabel!
    
    var tr_pushTransition: TRNavgationTransitionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = appEntry.name

        iconImageView.af_setImage(withURL: URL(string:appEntry.imageUrlString)!)
        iconImageView.addCornerRadius(radius: 10)
        iconImageView.isHidden = true
        
        lbTitle.text = appEntry.name
        
        lbArtist.text = appEntry.artist?.label
        
        lbSummary.text = appEntry.summary
        
        lbPrice.text = appEntry.price?.description
        
        lbRights.text = appEntry.rights
        
        lbCategory.text = appEntry.category?.label
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        iconImageView.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        iconImageView.isHidden = true
    }

}

//extension AppDetailViewController: NavgationTransitionable {
//    
//    @IBAction func popClick(_ sender: UIButton) {
//        _ = navigationController?.tr_popViewController()
//    }
//}


