//
//  AppListViewController.swift
//  CodingChallenge
//
//  Created by Juan José Villegas on 2/19/17.
//  Copyright © 2017 Juan José Villegas. All rights reserved.
//

import UIKit
import IGListKit
import RealmSwift
import SnapKit
import SWRevealViewController
import TransitionTreasury
import TransitionAnimation
import ReachabilitySwift

class AppListViewController: UIViewController {
    
    // MARK: - Attributes

    let collectionView: IGListCollectionView =  {
        let layout = IGListGridCollectionViewLayout()
        let view = IGListCollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    lazy var adapter: IGListAdapter = {
        return IGListAdapter(updater: IGListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    
    var appEntries:Results<AppEntry>!
    var notifications: NotificationToken?
    
    var category:AppCategory?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAppEntries()
        setupSidebar()
        
        adapter.collectionView = collectionView
        adapter.dataSource = self
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    deinit {
        notifications?.stop()
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "app_detail" {
            let controller = segue.destination as! AppDetailViewController
            
            if let appEntry = sender as? AppEntry {
                controller.appEntry = appEntry
            }
        }
    }
    
    // MARK: - Helpers
    
    func setupSidebar() {
        if revealViewController() != nil {
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
    }
    
    func loadAppEntries() {
        
        let realm = try! Realm()
        
        if let category = category {
            title = category.label
            appEntries = realm.objects(AppEntry.self).filter("category.id == %@", category.id)
        }
        else{
            title = NSLocalizedString("All Apps", comment: "")
            appEntries = realm.objects(AppEntry.self)
        }
        
        
        
        notifications = appEntries.addNotificationBlock({ (changes) in
            self.adapter.performUpdates(animated: true)
        })
        
        let reachability = Reachability()!
        
        if reachability.isReachable {
            AppStoreClient.sharedInstance.fetchApps { (success, entries, errorMessage) in
                
                if !success {
                    UIAlertController.createSimpleAlertControllerWithMessage(errorMessage, title: "", viewController: self)
                }
                
            }
        }

    }
    
    // MARK: - Actions

    @IBAction func showSidebarMenu(_ sender: Any) {
        
        revealViewController().revealToggle(self)
        
    }
}

extension AppListViewController: IGListAdapterDataSource{
    
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        let array:[Any] = Array(appEntries)
        return array as! [IGListDiffable]
    }
    
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        return AppEntrySectionController()
    }
    
    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        return nil
    }
    
}
