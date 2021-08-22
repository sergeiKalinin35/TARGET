//
//  ViewController.swift
//  TARGET
//
//  Created by Sergey on 22.08.2021.
//
import UserNotifications
import UIKit

class ContactListViewController: UIViewController {

   // var models = [MyReminder]()

@IBOutlet var tableView: UITableView!

private var contacts: [String] = []

override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.rowHeight = 85
    
    //добавляем кнопку edit
    navigationItem.leftBarButtonItem = editButtonItem
    
    
contacts = StorageManager.shared.fetchContacts()
}

    // создаем кнопку боковую
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
       return .delete
    }
    
    
    
    
    
    
    
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let newContactVC = segue.destination as! NewContactViewController
    newContactVC.delegate = self
  
}

}




extension ContactListViewController: UITableViewDataSource {
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    contacts.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
   
   // cell.textLabel?.text = contacts[indexPath.row]
    
    
  //  cell.oneLabel?.text = contacs[indexPath.row].target
   // cell.titleLabel.text = models[indexPath.row].title
    cell.titleLabel?.text = contacts[indexPath.row]
    cell.oneLabel?.text = contacts[indexPath.row]
    
    
    return cell
}
}
// удаление ячейки справа на лево
extension ContactListViewController: UITableViewDelegate {
    
   

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       tableView.deselectRow(at: indexPath, animated: true)
      
        }
    
    
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
           let currenModel =  contacts.remove(at: sourceIndexPath.row)
        contacts.insert(currenModel, at: destinationIndexPath.row)
        }
    
    

func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
    if editingStyle == .delete {
        contacts.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
   
        StorageManager.shared.delete(at: indexPath.row)
        
   }
}

   
    
}
    
    
    
    
extension ContactListViewController: NewContactViewControllerDelegate {
    func saveContact(_ contact: String) {
   contacts.append(contact)
    tableView.reloadData()
}

 }

struct MyReminder {
    
    let target: String
    let title: String
    let date: Date
 
}
