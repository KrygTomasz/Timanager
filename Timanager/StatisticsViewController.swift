//
//  StatisticsViewController.swift
//  Timanager
//
//  Created by Kryg Tomasz on 08.07.2017.
//  Copyright © 2017 Kryg Tomek. All rights reserved.
//

import UIKit
import CoreData

class StatisticsViewController: MainViewController {

    @IBOutlet weak var navigationView: UIView! {
        didSet {
            navigationView.backgroundColor = self.color
        }
    }
    @IBOutlet weak var navigationLabel: UILabel! {
        didSet {
            navigationLabel.heroID = "navigation"
            navigationLabel.textColor = .white
            navigationLabel.text = R.string.localizable.statistics()
        }
    }
    @IBOutlet weak var navigationImageView: UIImageView! {
        didSet {
            navigationImageView.heroID = "navigationImageView"
            navigationImageView.image = #imageLiteral(resourceName: "pieChart")
            navigationImageView.image = navigationImageView.image?.withRenderingMode(.alwaysTemplate)
            navigationImageView.tintColor = .white
            
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
    @IBOutlet weak var segmentedControlView: UIView! {
        didSet {
            segmentedControlView.backgroundColor = self.color
        }
    }
    @IBOutlet weak var segmentedControl: UISegmentedControl! {
        didSet {
            setupSegmentedControl()
        }
    }
    @IBOutlet weak var mainView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        self.setGradientBackground()
        setupView()
    }
    
    lazy var pieChartViewController: PieChartViewController = {
        let storyboard = R.storyboard.statisticsStoryboard()
        guard let vc = storyboard.instantiateViewController(withIdentifier: StatisticsIdentifiers.PieChartVC) as? PieChartViewController else {
            return PieChartViewController()
        }
        vc.prepare(using: self.color)
        self.addViewControllerAsChildViewController(childViewController: vc)
        return vc
    }()

//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    var fetchedResultsController: NSFetchedResultsController<PlannedActivity>?
//    
//    var plannedActivities: [PlannedActivity]? = []
    
    private func initNavigationBar() {
        self.navigationItem.title = R.string.localizable.statistics()
    }
    
    private func setupView() {
        setupSegmentedControl()
    }
    
    private func updateView() {
        pieChartViewController.view.isHidden = !(segmentedControl.selectedSegmentIndex == 0)
    }
    
    private func setupSegmentedControl() {
        segmentedControl.tintColor = .white
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: R.string.localizable.pieChart(), at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: R.string.localizable.analysis(), at: 1, animated: false)
        segmentedControl.addTarget(self, action: #selector(onSegmentedControlChange), for: .valueChanged)
        
        segmentedControl.selectedSegmentIndex = 0
        pieChartViewController.view.isHidden = false
    }
    
    private func addViewControllerAsChildViewController(childViewController: UIViewController) {
        addChildViewController(childViewController)
        mainView.addSubview(childViewController.view)
        childViewController.view.frame = mainView.bounds
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childViewController.didMove(toParentViewController: self)
    }
    
    func onCloseButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func onSegmentedControlChange() {
        updateView()
    }
    
}

////MARK: NSFetchedResultController delegates
//extension StatisticsViewController: NSFetchedResultsControllerDelegate {
//    
//    func initFetchedResultsController() {
//        
//        let fetchRequest = NSFetchRequest<PlannedActivity>(entityName: "PlannedActivity")
//        let sortDescriptor = NSSortDescriptor(key: "activity.name", ascending: true)
//        fetchRequest.sortDescriptors = [sortDescriptor]
//        fetchRequest.predicate = NSPredicate(format: "stopDate != 0")
//        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
//        fetchedResultsController?.delegate = self
//        
//        do {
//            plannedActivities = try context.fetch(fetchRequest)
//            pieChartViewController.plannedActivities = plannedActivities
//            print(plannedActivities?.count)
//        } catch {
//            let fetchError = error as NSError
//            print("Unable to Perform Fetch Request for PlannedActivites")
//            print("\(fetchError), \(fetchError.localizedDescription)")
//        }
//        
//    }
//    
////    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
////        switch type {
////        case .insert:
////            print("insert")
////            if let tempIndexPath = newIndexPath {
////                tableView.insertRows(at: [tempIndexPath], with: .fade)
////            }
////        case .delete:
////            print("delete")
////            if let tempIndexPath = indexPath {
////                tableView.deleteRows(at: [tempIndexPath], with: .fade)
////            }
////        case .update:
////            print("update")
////        case .move:
////            print("move")
////        }
////    }
//    
//}
