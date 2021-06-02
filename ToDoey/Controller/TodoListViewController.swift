//
//  ViewController.swift
//  ToDoey
//
//  Created by Roshan Yadav on 18/04/2021.
//

import UIKit

class TodoListViewController: UITableViewController {
    var itemArray = [item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath as Any)
            
       loadItems()
    }
    //Mark - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = itemArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark: .none
        return cell
    }
    //Mark - TableView Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print(itemArray[indexPath.row])
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    //Mark - Add new items.
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
            var textField = UITextField()
            let alert = UIAlertController(title: "Add New Todo Items", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "Add Items", style: .default) { (action) in
            //What happens when the user clicks the add item button on our UIAlert
            let newItem = item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
                self.saveItems()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //Mark - Model Manipulation Method
    func saveItems() {
        let encoder = PropertyListEncoder()
            do {
                let data = try encoder.encode(itemArray)
                try data.write(to: dataFilePath!)
            } catch {
                print("Error encoding item array \(error)")
            }
        tableView.reloadData()
    }
    func loadItems() {
        if  let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([item].self, from: data)
            } catch {
                print("Error decoding item array /(error)")
            }
        }
    }
}
