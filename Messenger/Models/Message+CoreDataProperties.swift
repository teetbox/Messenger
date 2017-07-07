//
//  Message+CoreDataProperties.swift
//  Messenger
//
//  Created by Matt Tian on 7/7/17.
//  Copyright © 2017 Bizersoft. All rights reserved.
//

import Foundation
import CoreData

extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }

    @NSManaged public var date: Date?
    @NSManaged public var text: String?
    @NSManaged public var isSender: Bool
    @NSManaged public var friend: Friend?

}
