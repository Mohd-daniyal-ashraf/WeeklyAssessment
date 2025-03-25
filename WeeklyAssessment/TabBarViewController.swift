//
//  TabBarViewController.swift
//  WeeklyAssessment
//
//  Created by Mddaniyal on 3/20/25.
//

import UIKit



class TabBarViewController: UIViewController {
    
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var addTodoView: UIView!
        
    @IBOutlet weak var addIcon: UIImageView!
    @IBOutlet weak var addBtn: UIButton!
    
    @IBOutlet weak var editlbl: UILabel!
    @IBOutlet weak var deleteLbl: UILabel!
    
    var dataSource: [Todo] = []
    
    var isDeleteEnabled = false
    var isEditEnabled = false
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)

        myTableView.dataSource = self
        myTableView.delegate = self
        addTodoView.layer.cornerRadius = addTodoView.frame.height / 2
        addTodoView.layer.shadowColor = UIColor.systemBlue.cgColor
        addTodoView.layer.shadowOpacity = 0.7

        let nib = UINib(nibName: "TodoTableViewCell", bundle: nil)
        myTableView.register(nib, forCellReuseIdentifier: "TodoTableViewCell")
    }
    
    @IBAction func addTodoBtn(_ sender: Any) {
        
        handleAddTodoBtn()
        
        addIcon.tintColor = .black
        addTodoView.backgroundColor = .white
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            
            self.addIcon.tintColor = .white
            self.addTodoView.backgroundColor = .systemBlue
        }
    }
    
    @IBAction func editTodoBtn(_ sender: Any) {
        
        isEditEnabled.toggle()
        myTableView.reloadData()

        if isEditEnabled {
            
            editlbl.textColor = .systemBlue
        } else {
            
            editlbl.textColor = .white
        }
    }
    
    @IBAction func deleteBtn(_ sender: Any) {
        
        isDeleteEnabled.toggle()
        myTableView.reloadData()
        
        if isDeleteEnabled {
            
            deleteLbl.textColor = .systemBlue
        } else {
            
            deleteLbl.textColor = .white
        }
    }
}

extension TabBarViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = dataSource[indexPath.row]
        
        let cell = myTableView.dequeueReusableCell(withIdentifier: "TodoTableViewCell", for: indexPath) as? TodoTableViewCell
        
        cell?.todoText.text = row.todoText
        cell?.priority.text = row.priority
        
        switch cell?.priority.text?.lowercased() {
            
            case "low":
                cell?.priorityColor.backgroundColor = .systemBlue
            case "normal":
                cell?.priorityColor.backgroundColor = .systemGreen
            case "high":
                cell?.priorityColor.backgroundColor = .systemRed
            default:
                cell?.priorityColor.backgroundColor = .systemYellow
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            
        if isDeleteEnabled {
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
                self.dataSource.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                completionHandler(true)
            }
            
            deleteAction.backgroundColor = .red
            
            return UISwipeActionsConfiguration(actions: [deleteAction])
        }
        
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if isEditEnabled {
            
            let editAction = UIContextualAction(style: .normal, title: "Edit") { _, _, completionHandler in
                self.handleEditTodo(at: indexPath)
                completionHandler(true)
            }
            
            editAction.backgroundColor = .systemOrange
            
            return UISwipeActionsConfiguration(actions: [editAction])
        }
        
        return nil
    }
}

extension TabBarViewController {
    
    func handleAddTodoBtn() {
        
        let alert = UIAlertController(title: "Add To-Do", message: "Enter details below", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter To-Do"
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Priority Level"
            textField.keyboardType = .numberPad
        }
        

        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            
            if let todoText = alert.textFields?[0].text, !todoText.isEmpty,
               let priorityText = alert.textFields?[1].text, !priorityText.isEmpty {
                
                let newTodo = Todo(todoText: todoText, priority: priorityText)
                self.dataSource.append(newTodo)
                self.myTableView.reloadData()
                
            } else {
                
                print("Both fields are required.")
            }
        }
        

        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        
        present(alert, animated: true, completion: nil)
    }
}

extension TabBarViewController {
    
    func handleEditTodo(at indexPath: IndexPath) {
        
        let todo = dataSource[indexPath.row]
        
        let alert = UIAlertController(title: "Edit To-Do", message: "Modify details below", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.text = todo.todoText
        }
        
        alert.addTextField { (textField) in
            textField.text = todo.priority
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            if let updatedText = alert.textFields?[0].text, !updatedText.isEmpty,
               let updatedPriority = alert.textFields?[1].text, !updatedPriority.isEmpty {
                
                self.dataSource[indexPath.row] = Todo(todoText: updatedText, priority: updatedPriority)
                self.myTableView.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        present(alert, animated: true)
    }
}

