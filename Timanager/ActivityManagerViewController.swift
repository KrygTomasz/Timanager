//
//  ActivityManagerViewController.swift
//  Timanager
//
//  Created by Kryg Tomasz on 08.07.2017.
//  Copyright © 2017 Kryg Tomek. All rights reserved.
//

import UIKit
import CoreData

protocol ActivityManagerDelegate: class {
    func deleteActivity(_ activity: Activity)
}

class ActivityManagerViewController: MainViewController {

    @IBOutlet var containerView: UIView! {
        didSet {
            containerView.heroID = "navigation"
            containerView.backgroundColor = self.color
        }
    }
    @IBOutlet weak var navigationView: UIView! {
        didSet {
            navigationView.backgroundColor = self.color
        }
    }
    @IBOutlet weak var closeButton: UIButton! {
        didSet {
            closeButton.setTitle("", for: .normal)
            closeButton.setImage(#imageLiteral(resourceName: "down"), for: .normal)
            closeButton.tintColor = .white
            closeButton.scaleImage(height: 24, width: 24)
            closeButton.backgroundColor = .clear
            closeButton.addTarget(self, action: #selector(onCloseButtonClicked), for: .touchUpInside)
        }
    }
    @IBOutlet weak var navigationLabel: UILabel! {
        didSet {
            navigationLabel.heroID = "navigationTitle"
            navigationLabel.textColor = .white
            navigationLabel.text = R.string.localizable.activities()
        }
    }
    @IBOutlet weak var navigationImageView: UIImageView! {
        didSet {
            navigationImageView.heroID = "navigationImageView"
            navigationImageView.image = #imageLiteral(resourceName: "activity")
            navigationImageView.image = navigationImageView.image?.withRenderingMode(.alwaysTemplate)
            navigationImageView.tintColor = .white
            
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(R.nib.activityTVCell(), forCellReuseIdentifier: R.reuseIdentifier.activityTVCell.identifier)
//            tableView.keyboardDismissMode = .interactive
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = UITableViewAutomaticDimension
            tableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, newActivityButton.frame.height, 0.0)
            tableView.backgroundColor = self.color
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    @IBOutlet weak var newActivityButton: UIButton! {
        didSet {
            newActivityButton.setTitle(R.string.localizable.newActivity(), for: .normal)
            newActivityButton.setTitleColor(.white, for: .normal)
            newActivityButton.backgroundColor = UIColor.clear
            newActivityButton.addTarget(self, action: #selector(onNewActivityButtonClicked), for: .touchUpInside)
        }
    }
    @IBOutlet weak var mainNewActivityView: UIView! {
        didSet {
            if #available(iOS 11.0, *) {
                mainNewActivityView.layer.cornerRadius = 20
                mainNewActivityView.clipsToBounds = true
                mainNewActivityView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            } else {
                // Fallback on earlier versions
            }
            mainNewActivityView.backgroundColor = UIColor.main
        }
    }
    @IBOutlet weak var newActivityView: UIView! {
        didSet {
            newActivityView.backgroundColor = UIColor.clear
        }
    }
    @IBOutlet weak var newActivityBottom: NSLayoutConstraint!
    @IBOutlet weak var newActivityTextField: UITextField! {
        didSet {
            newActivityTextField.placeholder = R.string.localizable.typeActivityName()
            newActivityTextField.returnKeyType = .done
            newActivityTextField.delegate = self
        }
    }
    @IBOutlet weak var addActivityButton: UIButton! {
        didSet {
            addActivityButton.layer.cornerRadius = 10.0
            addActivityButton.setTitle(R.string.localizable.addActivity(), for: .normal)
            addActivityButton.setTitleColor(UIColor.main, for: .normal)
            addActivityButton.backgroundColor = .white
            addActivityButton.addTarget(self, action: #selector(onAddActivityButtonClicked), for: .touchUpInside)
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var fetchedResultsController: NSFetchedResultsController<Activity>?
    var isShowingNewActivity: Bool = false
    weak var delegate: ActivityManagerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initObservers()
        initNavigationBar()
//        self.setGradientBackground()
        initFetchedResultsController()
        newActivityBottom.constant = -newActivityView.bounds.height
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        mainNewActivityView.roundCornersWithLayerMask(cornerRadii: 20.0, corners: [.topLeft, .topRight])
    }
    
    func initObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func initNavigationBar() {
        self.navigationItem.title = R.string.localizable.activities()
    }
    
    func onCloseButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func onNewActivityButtonClicked() {
        if isShowingNewActivity {
            newActivityTextField.resignFirstResponder()
            showNewActivityView(false)
        } else {
            showNewActivityView(true)
            newActivityTextField.becomeFirstResponder()
        }
    }
    
    func onAddActivityButtonClicked() {
        guard let activityName = newActivityTextField.text else {
            return
        }
        if activityName.isEmpty || activityExists(name: activityName) {
            return
        }
        let object = Activity(context: context)
        object.fill(using: activityName)
        do {
            try object.managedObjectContext?.save()
        } catch {
            print("Error saving activity object")
        }
        newActivityTextField.resignFirstResponder()
        onNewActivityButtonClicked()
        showSuccessfulAddAlert()
        newActivityTextField.text = ""
    }
    
    private func showSuccessfulAddAlert() {
        let alert = UIAlertController(title: R.string.localizable.success()+"!", message: R.string.localizable.successfulAdd(), preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: R.string.localizable.ok(), style: .default, handler: {
            action in
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(acceptAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func activityExists(name: String?) -> Bool {
        let activityWithGivenNameOptional = fetchedResultsController?.fetchedObjects?.filter { activity in
            guard let activityName = activity.name else {
                return false
            }
            return name == activityName
        }
        guard let activityWithGivenName = activityWithGivenNameOptional else {
            return false
        }
        if activityWithGivenName.isEmpty { } else {
            return true
        }
        return false
    }
    
    func showNewActivityView(_ show: Bool) {
        isShowingNewActivity = show
        if show {
            newActivityBottom.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        } else {
            newActivityBottom.constant = -newActivityView.bounds.height
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }

}

//MARK: TableView delegates
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
        activityCell.prepare(withActivity: object)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController?.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let activityCell = tableView.cellForRow(at: indexPath) as? ActivityTVCell else {
            return
        }
        activityCell.nameTextField.isEnabled = true
        activityCell.nameTextField.becomeFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let object = fetchedResultsController?.object(at: indexPath) else {
                return
            }
            delegate?.deleteActivity(object)
        }
    }
    
}

//MARK: NSFetchedResultController delegates
extension ActivityManagerViewController: NSFetchedResultsControllerDelegate {
    
    func initFetchedResultsController() {
        
        let fetchRequest = NSFetchRequest<Activity>(entityName: "Activity")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true, selector: "caseInsensitiveCompare:")
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

//MARK: TextField delegates
extension ActivityManagerViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        newActivityBottom.constant = 0
        return true
    }
    
}

//MARK: Keyboard handling
extension ActivityManagerViewController {
    func keyboardWillShow(notification:NSNotification){
        
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        if newActivityTextField.isFirstResponder {
            newActivityBottom.constant = keyboardFrame.size.height
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            })
        } else {
            tableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, keyboardFrame.size.height, 0.0)
        }

    }
    
    func keyboardWillHide(notification:NSNotification){
        
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        tableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, newActivityButton.frame.height, 0.0)
        
        if isShowingNewActivity {
            newActivityBottom.constant = 0
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            })
        }
        
    }
}
