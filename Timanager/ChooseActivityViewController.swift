//
//  ChooseActivityViewController.swift
//  Timanager
//
//  Created by Kryg Tomasz on 09.07.2017.
//  Copyright © 2017 Kryg Tomek. All rights reserved.
//

import UIKit
import CoreData

protocol ChooseActivityDelegate: class {
    func chooseActivity(_ activity: Activity)
}

class ChooseActivityViewController: MainViewController {

    @IBOutlet var contentView: UIView! {
        didSet {
            contentView.backgroundColor = .darkGray
        }
    }
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
            searchBar.barTintColor = .darkGray
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

        initObservers()
//        initNavigationBar()
        initFetchedResultsController()
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var fetchedResultsController: NSFetchedResultsController<Activity>?
    
    var activities: [Activity] = []
    var filteredActivities: [Activity] = []
    
    weak var delegate: ChooseActivityDelegate?

    func initObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
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
        activityCell.contentView.heroID = "choosenActivity"
        let object = filteredActivities[indexPath.row]
        activityCell.prepare(withName: object.name)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let searchText = searchBar.text else {
            filteredActivities = activities
            return filteredActivities.count
        }
        if searchText.isEmpty {
            filteredActivities = activities
        }
        return filteredActivities.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        guard let selectedCell = tableView.cellForRow(at: indexPath) as? ActivityTVCell else {
            return
        }
//        selectedCell.activityButton.heroID = "choosenActivityLabel"
        let object = filteredActivities[indexPath.row]
        delegate?.chooseActivity(object)
        tableView.deselectRow(at: indexPath, animated: false)
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        guard let selectedCell = tableView.cellForRow(at: indexPath) as? ActivityTVCell else {
            return
        }
        selectedCell.nameBackgroundView.backgroundColor = .mainRed
//        selectedCell.contentView.backgroundColor = .black
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        guard let selectedCell = tableView.cellForRow(at: indexPath) as? ActivityTVCell else {
            return
        }
        selectedCell.nameBackgroundView.backgroundColor = .mainPastelRed
//        selectedCell.contentView.backgroundColor = .black
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
            self.filteredActivities = self.activities
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
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
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

//MARK: Keyboard handling
extension ChooseActivityViewController {
    func keyboardWillShow(notification:NSNotification){
        
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        tableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, keyboardFrame.size.height, 0.0)
        
    }
    
    func keyboardWillHide(notification:NSNotification){
//
//        var userInfo = notification.userInfo!
//        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
//        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        tableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        
    }
}
