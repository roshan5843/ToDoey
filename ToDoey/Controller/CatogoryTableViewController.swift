//
//  CatogoryTableViewController.swift
//  ToDoey
//
//  Created by Roshan Yadav on 07/06/2021.
//

import UIKit
import CoreData

class CatogoryTableViewController: UITableViewController {
    var categories = [Catogory]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()

    }
    //Mark: - TableView Datasource Method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
    
    //Mark: - TableView Delegate Method.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
        
    }
    
    //Mark; - Data Manipulation Method
    func saveCategories() {
        do {
           try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    tableView.reloadData()
}
    func loadCategories(with request: NSFetchRequest<Catogory> = Catogory.fetchRequest()) {
   
    do {
        categories = try context.fetch(request)
    } catch {
        print("Error fetching data from context \(error)")
    }
    tableView.reloadData()
}
    
    
    
    //Mark: - Add New Categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
        //What happens when the user clicks the add item button on our UIAlert
           
            let newCategory = Catogory(context: self.context)
            newCategory.name = textField.text!
            self.categories.append(newCategory)
            self.saveCategories()
        
    }
    alert.addTextField { (field) in
        textField.placeholder = "Create a new Category "
        textField = field
    }
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
}

}
