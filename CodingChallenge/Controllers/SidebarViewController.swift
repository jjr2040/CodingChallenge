//
//  SidebarViewController.swift
//  CodingChallenge
//
//  Created by Juan José Villegas on 2/19/17.
//  Copyright © 2017 Juan José Villegas. All rights reserved.
//

import UIKit
import RealmSwift

class SidebarViewController: UIViewController {
    
    // MARK: - Constants
    
    static let appListSegue = "app_list"

    // MARK: - Attributes
    
    @IBOutlet weak var tableView: UITableView!
    
    var categories:Results<AppCategory> = {
        let realm = try! Realm()
        
        return realm.objects(AppCategory.self)
        
    }()
    
    var notifications: NotificationToken?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notifications =  categories.addNotificationBlock { (changes) in
            switch changes{
            case .initial:
                self.tableView.reloadData()
            case .update(_, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                self.tableView.beginUpdates()
                
                self.tableView.deleteRows(at: deletions.map{IndexPath(row: $0, section: 0)}, with: .automatic)
                
                self.tableView.insertRows(at: insertions.map{IndexPath(row: $0, section: 0)}, with: .automatic)
                
                self.tableView.reloadRows(at: modifications.map{IndexPath(row: $0, section: 0)}, with: .automatic)
                
                self.tableView.endUpdates()
            default:
                break
            }
        }
    }
    
    deinit {
        notifications?.stop()
    }
    

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == SidebarViewController.appListSegue {
            let navController = segue.destination
            let controller = navController.childViewControllers.first as! AppListViewController
            
            if let category = sender as? AppCategory {
                
                if category.id.isEmpty {
                    controller.category = nil
                }
                else{
                    controller.category = category
                }

            }
        }
        
    }

}

extension SidebarViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        let category = categories[indexPath.row]
        
        cell.textLabel?.text = category.label
        cell.textLabel?.textColor = UIColor.darkGray
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let category = categories[indexPath.row]
        
        performSegue(withIdentifier: SidebarViewController.appListSegue, sender: category)
        
    }
    
}
