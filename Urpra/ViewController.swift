//
//  ViewController.swift
//  Urpra
//
//  Created by Ashok Machineni on 11/9/16.
//  Copyright © 2016 Ashok Machineni. All rights reserved.
//

import UIKit

import Firebase



class ViewController: UITableViewController {
    
    var ref: FIRDatabaseReference!
    var refHandle: UInt!
    var valueList = [Values]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        
        fetchFirebaseData()
        
    }
    
    func fetchFirebaseData() {
        
        
        refHandle = ref.child("SwiftJson").observe(.childAdded, with:
            {(snapshot) in
                if let dictionary = snapshot.value as? [String : AnyObject] {
                    print(dictionary)
                    
                    let value = Values() as AnyObject
                    
                    value.setValuesForKeys(dictionary)
                    self.valueList.append(value as! Values)
                    
                    
                    self.tableView.reloadData()
                    
                    
                }
                
        })
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return valueList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FTableViewCell
        
        
        
        let value = valueList[indexPath.row]
        
        cell.fTitle.text = value.title
        let imageUrlString = valueList[indexPath.row] as! String
        let imageURL = NSURL(string: imageUrlString)
        let imageData = NSData(contentsOf: imageURL as! URL)
        cell.fImage.image = UIImage(data: imageData as! Data)
        
        return cell
        
    }
}
