//
//  ChooseActivityViewController.swift
//  Timanager
//
//  Created by Kryg Tomasz on 09.07.2017.
//  Copyright © 2017 Kryg Tomek. All rights reserved.
//

import UIKit
import CoreData

class ChooseActivityViewController: MainViewController {

    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(R.nib.activityTVCell(), forCellReuseIdentifier: R.reuseIdentifier.activityTVCell.identifier)
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigationBar()
        initFetchedResultsController()
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var fetchedResultsController: NSFetchedResultsController<Activity>?
    
    var activities: [Activity] = []
    var filteredActivities: [Activity] = []

    func initNavigationBar() {
        let backButton = UIBarButtonItem(title: R.string.localizable.back(), style: .plain, target: self, action: #selector(onBackButtonClicked))
        
        self.navigationItem.rightBarButtonItem = backButton
    }
    
    func onBackButtonClicked() {
        dismiss(animated: true, completion: nil)
    }

}

//MARK: TableView delegates
extension ChooseActivityViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.activityTVCell.identifier, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let activityCell = cell as? ActivityTVCell,
            let searchText = searchBar.text else {
                return
        }
        
        if searchText.isEmpty {
            let object = fetchedResultsController?.object(at: indexPath)
            activityCell.prepare(with: object?.name)
        } else {
            let object = filteredActivities[indexPath.row]
            activityCell.prepare(with: object.name)
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let searchText = searchBar.text else {
            return activities.count
        }
        if searchText.isEmpty {
            return activities.count
        } else {
            return filteredActivities.count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
}

extension ChooseActivityViewController: NSFetchedResultsControllerDelegate {
    
    func initFetchedResultsController() {
        
        let fetchRequest = NSFetchRequest<Activity>(entityName: "Activity")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController?.delegate = self
        
        do {
            try self.fetchedResultsController?.performFetch()
            self.activities = self.fetchedResultsController?.fetchedObjects ?? []
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

//MARK: SearchBar delegates
extension ChooseActivityViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterContentForSearchText(searchText: searchBar.text)
    }
    
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchText: searchBar.text, scope: searchBar.scopeButtonTitles?[selectedScope])
    }
    
    func filterContentForSearchText(searchText: String?, scope: String? = "All") {
        guard let text = searchText else {
            return
        }
        filteredActivities = activities.filter { activity in
            guard let name = activity.name else {
                return false
            }
            return name.lowercased().contains(text.lowercased())
        }
        
        tableView.reloadData()
    }
    
}
