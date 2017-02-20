//
//  AppEntrySectionController.swift
//  CodingChallenge
//
//  Created by Juan José Villegas on 2/19/17.
//  Copyright © 2017 Juan José Villegas. All rights reserved.
//

import UIKit
import IGListKit
import AlamofireImage
import TransitionTreasury
import TransitionAnimation

class AppEntrySectionController: IGListSectionController, IGListSectionType {
    
    var appEntry:AppEntry?
    
    func numberOfItems() -> Int {
        return 1
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            
            let width = (collectionContext!.containerSize.width/2)
            let height = CGFloat(116.0)
            
            return CGSize(width: width, height: height)
        }
        
        return CGSize(width: collectionContext!.containerSize.width, height: 76)
        
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {

        if UIDevice.current.userInterfaceIdiom == .pad {
            let cell = collectionContext!.dequeueReusableCell(withNibName: "AppGridCell", bundle: nil, for: self, at: index) as! AppGridCell
            
            if let appEntry = appEntry {
                let imgUrl = URL(string:appEntry.imageUrlString)
                cell.imageView.af_setImage(withURL: imgUrl!)
                cell.imageView.addCornerRadius(radius: 10)
                
                cell.lbName.text = appEntry.name
                cell.lbArtist.text = appEntry.artist!.label
                
            }
            
            return cell
        }
        else{
            let cell = collectionContext!.dequeueReusableCell(withNibName: "AppListCell", bundle: nil, for: self, at: index) as! AppListCell
            
            if let appEntry = appEntry {
                let imgUrl = URL(string:appEntry.imageUrlString)
                cell.imageView.af_setImage(withURL: imgUrl!)
                cell.imageView.addCornerRadius(radius: 10)
                
                cell.lbName.text = appEntry.name
                cell.lbArtist.text = appEntry.artist!.label
                
            }
            
            return cell
        }

        
        
    }
    
    func didUpdate(to object: Any) {
        appEntry = object as? AppEntry
    }
    
    func didSelectItem(at index: Int) {
        
        let detailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AppDetailViewController") as! AppDetailViewController
        let appListViewController = viewController as! AppListViewController
        
        detailViewController.appEntry = appEntry
        
        let cell = collectionContext?.cellForItem(at: index, sectionController: self)
        
        if let cell = cell as?  AppListCell{
            let rect = CGRect(x: 12, y: 65 + 12, width: 90, height: 90)
//            let method = TRPushTransitionMethod.blixt(keyView: cell.imageView, to: rect)
            let method = TRCustomPushTransitionMethod.blixt(keyView: cell.imageView, to: rect)
            appListViewController.navigationController?.tr_pushViewController(detailViewController, method: method)
//            appListViewController.navigationController?.transitioningDelegate = appListViewController
        }
        
        

//
        
//        appListViewController.tr_presentViewController(detailViewController, method: TRPresentTransitionMethod.twitter)
//        viewController?.performSegue(withIdentifier: "app_detail", sender: appEntry)
    }
}


