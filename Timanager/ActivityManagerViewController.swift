//
//  ActivityManagerViewController.swift
//  Timanager
//
//  Created by Kryg Tomasz on 08.07.2017.
//  Copyright © 2017 Kryg Tomek. All rights reserved.
//

import UIKit
import CoreData

class ActivityManagerViewController: MainViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(R.nib.activityTVCell(), forCellReuseIdentifier: R.reuseIdentifier.activityTVCell.identifier)
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    @IBOutlet weak var addButton: UIButton! {
        didSet {
            addButton.addTarget(self, action: #selector(onAddButtonClicked), for: .touchUpInside)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initFetchedResultsController()
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var fetchedResultsController: NSFetchedResultsController<Activity>?
    
    func onAddButtonClicked() {
        let object = Activity(context: context)
        object.fill(using: "Testowa aktywność")
        do {
            try object.managedObjectContext?.save()
        } catch {
            print("Error saving activity object")
        }
    }

}

extension ActivityManagerViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.activityTVCell.identifier, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let activityCell = cell as? ActivityTVCell else {
            return
        }
        let object = fetchedResultsController?.object(at: indexPath)
        activityCell.nameLabel.text = object?.name
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController?.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let object = fetchedResultsController?.object(at: indexPath) else {
                return
            }
            context.delete(object)
            do {
                try object.managedObjectContext?.save()
            } catch {
                print("Error saving activity object")
            }
        }
    }
    
}

extension ActivityManagerViewController: NSFetchedResultsControllerDelegate {
    
    func initFetchedResultsController() {
        
        let fetchRequest = NSFetchRequest<Activity>(entityName: "Activity")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController?.delegate = self
        
        do {
            try self.fetchedResultsController?.performFetch()
        } catch {
            let fetchError = error as NSError
            print("Unable to Perform Fetch Request")
            print("\(fetchError), \(fetchError.localizedDescription)")
        }
        
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            print("insert")
            if let tempIndexPath = newIndexPath {
                tableView.insertRows(at: [tempIndexPath], with: .fade)
            }
        case .delete:
            print("delete")
            if let tempIndexPath = indexPath {
                tableView.deleteRows(at: [tempIndexPath], with: .fade)
            }
        case .update:
            print("update")
        case .move:
            print("move")
        }
    }
    
}
