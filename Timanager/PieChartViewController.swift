//
//  PieChartViewController.swift
//  Timanager
//
//  Created by Kryg Tomasz on 09.07.2017.
//  Copyright © 2017 Kryg Tomek. All rights reserved.
//

import UIKit
import CoreData
import Charts

class PieChartViewController: MainViewController {

    @IBOutlet weak var pieChartView: PieChartView! {
        didSet {
            pieChartView.holeRadiusPercent = 0
            pieChartView.drawHoleEnabled = false
            pieChartView.usePercentValuesEnabled = true
            pieChartView.highlightPerTapEnabled = false
            pieChartView.chartDescription?.text = ""
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let mainColor = self.color {
            self.view.addGradientBackground(using: [mainColor.cgColor, UIColor.white.cgColor])
        }
        initFetchedResultsController()
    }
    
    var activities: [Activity]? = [] {
        didSet {
            setChart(activities: activities)
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var fetchedResultsController: NSFetchedResultsController<Activity>?
    
    func setChart(activities: [Activity]?) {
        
        var dataEntries: [ChartDataEntry] = []
        guard let activities = activities else {
            return
        }
        for activity in activities {
            guard let plannedActivities = activity.plannedActivity?.allObjects as? [PlannedActivity] else {
                continue
            }
            if hasNotFinishedAnyActivity(in: plannedActivities) {
                continue
            }
            var duration: Int64 = 0
            for plannedActivity in plannedActivities {
                if plannedActivity.stopDate != 0 {
                    duration += (plannedActivity.stopDate - plannedActivity.startDate)
                }
            }
            let dataEntry = PieChartDataEntry(value: Double(duration), label: activity.name, data: activity.name as AnyObject)
            
            dataEntries.append(dataEntry)
        }

        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "")
        pieChartDataSet.sliceSpace = 3.0
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        pieChartData.setValueFormatter(DefaultValueFormatter(formatter: NumberFormatter.getPercentFormatter()))
        pieChartData.setValueTextColor(UIColor.black)
//        pieChartDataSet.colors = ChartColorTemplates.material()
        
        let pieChartColors = UIColor.generateColorSet(ofSize: dataEntries.count, saturation: 0.5, brightness: 1, alpha: 1)
        pieChartDataSet.colors = pieChartColors
        
        pieChartView.animate(yAxisDuration: 1.0, easingOption: .easeInOutQuart)
    }
    
    func hasNotFinishedAnyActivity(in plannedActivities: [PlannedActivity]) -> Bool {
        if plannedActivities.isEmpty {
            return true
        }
        else if plannedActivities.count == 1 {
            if plannedActivities.first?.stopDate == 0 {
                return true
            }
        }
        return false
    }
    
}

//MARK: NSFetchedResultController delegates
extension PieChartViewController: NSFetchedResultsControllerDelegate {
    
    func initFetchedResultsController() {
        
        let fetchRequest = NSFetchRequest<Activity>(entityName: "Activity")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController?.delegate = self
        
        do {
            activities = try context.fetch(fetchRequest)
        } catch {
            let fetchError = error as NSError
            print("Unable to Perform Fetch Request for PlannedActivites")
            print("\(fetchError), \(fetchError.localizedDescription)")
        }
        
    }
    
}
