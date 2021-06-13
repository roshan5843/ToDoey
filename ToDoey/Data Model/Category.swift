//
//  Category.swift
//  ToDoey
//
//  Created by Roshan Yadav on 09/06/2021.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
