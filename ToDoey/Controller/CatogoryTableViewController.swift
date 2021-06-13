//
//  CatogoryTableViewController.swift
//  ToDoey
//
//  Created by Roshan Yadav on 07/06/2021.
//

import UIKit
import RealmSwift

class CatogoryTableViewController: UITableViewController {
    var realm = try! Realm()
    var categories: Results<Category>?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()

    }
    //Mark: - TableView Datasource Method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Category Added Yet"
        return cell
    }
    
    //Mark: - TableView Delegate Method.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
        
    }
    
    //Mark; - Data Manipulation Method
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving context \(error)")
        }
    tableView.reloadData()
}
   func loadCategories() {
    
    categories = realm.objects(Category.self)
  tableView.reloadData()
}
    
    
    
    //Mark: - Add New Categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
        //What happens when the user clicks the add item button on our UIAlert
           
            let newCategory = Category()
            newCategory.name = textField.text!
            self.save(category: newCategory)
    }
    alert.addTextField { (field) in
        textField.placeholder = "Create a new Category "
        textField = field
    }
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
}

}
