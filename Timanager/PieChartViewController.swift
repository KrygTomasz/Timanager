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

    @IBOutlet weak var dateTextField: UITextField! {
        didSet {
            dateTextField.delegate = self
            dateTextField.textColor = .white
            dateTextField.text = "Wybierz datę"
            dateTextField.tintColor = .clear
            dateTextField.layer.borderColor = UIColor.white.cgColor
            dateTextField.layer.borderWidth = 1.0
            dateTextField.layer.cornerRadius = 4.0
            
            datePicker = UIDatePicker()
            datePicker?.datePickerMode = .date
            datePicker?.addTarget(self, action: #selector(onDatePickerChange), for: .valueChanged)
            
            dateTextField.inputView = datePicker
        }
    }
    @IBOutlet weak var pieChartView: PieChartView! {
        didSet {
            pieChartView.holeRadiusPercent = 0
            pieChartView.drawHoleEnabled = false
            pieChartView.usePercentValuesEnabled = true
            pieChartView.legend.textColor = .white
//            pieChartView.drawEntryLabelsEnabled = false
            pieChartView.highlightPerTapEnabled = false
            pieChartView.chartDescription?.text = ""
            pieChartView.delegate = self
            
            pieChartView.isHidden = true
        }
    }
    
    var datePicker: UIDatePicker?
    var date: Date = Date() {
        didSet {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = " dd MMM, yyyy "
            let dateString = dateFormatter.string(from: date)
            dateTextField.text = dateString
            animateChart()
        }
    }
    
    var activities: [Activity]? = [] {
        didSet {
            setChart(activities: activities)
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var fetchedResultsController: NSFetchedResultsController<Activity>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        date = Date()
        addDoneButtonToKeyboard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        pieChartView.isHidden = false
    }
    
    func setChart(activities: [Activity]?) {
        
        let dataEntries = getChartDataEntries(forActivities: activities)
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "")
        pieChartDataSet.sliceSpace = 3.0
        let pieChartColors = UIColor.generateColorSet(basedOn: .red, ofSize: dataEntries.count)
        pieChartDataSet.colors = pieChartColors
        
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartData.setValueFormatter(DefaultValueFormatter(formatter: NumberFormatter.getPercentFormatter()))
        pieChartData.setValueTextColor(UIColor.black)
        pieChartView.data = pieChartData
        
        pieChartView.animate(yAxisDuration: 1.5, easingOption: .easeInOutQuint)
    }
    
    func getChartDataEntries(forActivities activities: [Activity]?) -> [ChartDataEntry] {
        
        var dataEntries: [ChartDataEntry] = []
        
        guard let activities = activities else {
            return []
        }
        
        let dateInterval = getDateInterval(forDate: self.date)
        let predicate = NSPredicate(format: "startDate >= %d AND stopDate <= %d",
                                    Int64(dateInterval.minDate.timeIntervalSince1970),
                                    Int64(dateInterval.maxDate.timeIntervalSince1970))
        
//        let endDayPredicate = NSPredicate(format: "startDate <= %d AND stopDate >= %d",
//                                          Int64(dateInterval.maxDate.timeIntervalSince1970),
//                                          Int64(dateInterval.maxDate.timeIntervalSince1970))
//
//        let beginDayPredicate = NSPredicate(format: "startDate <= %d AND stopDate >= %d",
//                                            Int64(dateInterval.minDate.timeIntervalSince1970),
//                                            Int64(dateInterval.minDate.timeIntervalSince1970))
        
        for activity in activities {
            let filteredPlannedActivities = activity.plannedActivity?.filtered(using: predicate)
//            let filteredEndDayPlannedActivities = activity.plannedActivity?.filtered(using: endDayPredicate)
//            let filteredBeginDayPlannedActivities = activity.plannedActivity?.filtered(using: beginDayPredicate)
            guard let plannedActivitiesSet = filteredPlannedActivities as NSSet?,
                let plannedActivities = plannedActivitiesSet.allObjects as? [PlannedActivity]
            else {
                return []
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
        return dataEntries
        
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
    
    func getDateInterval(forDate date: Date) -> (minDate: Date, maxDate: Date) {
        
        let minDate = Date.getStartDate(forDate: date)
        let maxDate = Date.getEndDate(forDate: date)
        return (minDate, maxDate)
        
    }
    
    func animateChart() {
        initFetchedResultsController()
    }
    
}

//MARK: ChartView delegates
extension PieChartViewController: ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
        guard let data = entry.data as? String else {
            return
        }
        print(data)
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

//MARK: DatePicker
extension PieChartViewController {
    
    func onDatePickerChange(_ sender: UIDatePicker) {
        date = sender.date
    }
    
}

//MARK: TextField delegates
extension PieChartViewController: UITextFieldDelegate {
    
    func addDoneButtonToKeyboard() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done,
                                            target: view, action: #selector(UIView.endEditing(_:)))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        dateTextField.inputAccessoryView = keyboardToolbar
    }
    
}
