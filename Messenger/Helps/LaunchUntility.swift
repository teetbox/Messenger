//
//  LaunchUntility.swift
//  Messenger
//
//  Created by Matt Tian on 7/7/17.
//  Copyright © 2017 Bizersoft. All rights reserved.
//

import Foundation
import CoreData

extension FriendsViewController {
    
    var context: NSManagedObjectContext {
        return CoreDataManager.shared.viewContext
    }
    
    func setupData() {
        clearData()
        createData()
    }
    
    private func clearData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Friend")

        do {
            let managedObjects = try context.fetch(request) as! [NSManagedObject]
            
            for object in managedObjects {
                context.delete(object)
            }
            
            CoreDataManager.shared.saveContext()
            
        } catch let err {
            print(err.localizedDescription)
        }
        
    }
    
    private func createData() {
        let steve = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
        steve.name = "Steve Jobs"
        steve.profileImageName = "steve_profile"
        
        let steve_message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        steve_message.text = "Hello, welcome to Apple!"
        steve_message.friend = steve
        steve_message.date = Date()
        
        let mark = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
        mark.name = "Mark Zuckerberg"
        mark.profileImageName = "zuckprofile"
        
        let mark_message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        mark_message.text = "I love Facebook. Please enjoy yourself with it."
        mark_message.friend = mark
        mark_message.date = Date()
        
        messages = [steve_message, mark_message]
        
        CoreDataManager.shared.saveContext()
    }
    
}
