//
//  BarChartViewController.swift
//  Timanager
//
//  Created by Kryg Tomasz on 30.09.2017.
//  Copyright © 2017 Kryg Tomek. All rights reserved.
//

import UIKit
import CoreData
import Charts

class BarChartViewController: MainViewController {

    @IBOutlet weak var dateTextField: UITextField! {
        didSet {
            dateTextField.delegate = self
            dateTextField.textColor = .white
            dateTextField.addShadow()
            dateTextField.text = "Wybierz datę"
            dateTextField.tintColor = .clear
            
            datePicker = UIDatePicker()
            datePicker?.datePickerMode = .date
            datePicker?.addTarget(self, action: #selector(onDatePickerChange), for: .valueChanged)
            
            dateTextField.inputView = datePicker
        }
    }
    @IBOutlet weak var barChartView: BarChartView! {
        didSet {
//            barChartView.highlightPerTapEnabled = false
            barChartView.chartDescription?.text = ""
            barChartView.delegate = self
            
            barChartView.leftAxis.axisMinimum = 0
            barChartView.rightAxis.axisMinimum = 0
            barChartView.leftAxis.drawGridLinesEnabled = false
            barChartView.leftAxis.drawAxisLineEnabled = false
            barChartView.rightAxis.drawGridLinesEnabled = false
            barChartView.rightAxis.drawAxisLineEnabled = false
            barChartView.xAxis.drawGridLinesEnabled = false
            barChartView.xAxis.drawAxisLineEnabled = false
            barChartView.xAxis.drawLabelsEnabled = true
            barChartView.xAxis.granularity = 1.0
            barChartView.drawMarkers = true
            barChartView.highlightPerDragEnabled = false
            barChartView.doubleTapToZoomEnabled = false
            
            barChartView.isHidden = true
        }
    }
    
    var datePicker: UIDatePicker?
    var date: Date = Date() {
        didSet {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM, yyyy"
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
        if let mainColor = self.color {
            self.view.addGradientBackground(using: [mainColor.cgColor, UIColor.white.cgColor])
        }
        date = Date()
        addDoneButtonToKeyboard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        barChartView.isHidden = false
    }
    
    func setChart(activities: [Activity]?) {
        
        let dataEntries = getChartDataEntries(forActivities: activities)
        let barChartDataSet = BarChartDataSet(values: dataEntries, label: "")
//        barChartDataSet.sliceSpace = 3.0
        let barChartColors = UIColor.generateColorSet(ofSize: dataEntries.count, saturation: 0.5, brightness: 1, alpha: 1)
        barChartDataSet.colors = barChartColors
        
        let barChartData = BarChartData(dataSet: barChartDataSet)
        barChartData.setValueFormatter(DefaultValueFormatter(formatter: NumberFormatter.getPercentFormatter()))
//        barChartDataSet.setValueFormatter(DefaultValueFormatter(formatter: NumberFormatter.getPercentFormatter()))
//        barChartDataSet.setValueTextColor(UIColor.black)
        barChartView.data = barChartData
//        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: ["asd","dfg","htreg","yutr","etrr","wert","asd","dfg","htreg","yutr","etrr","wert"])
//        barChartView.leftAxis.valueFormatter = PercentFormatter(max: 40000)
        
//        barChartView.barData?.setValueFormatter(DefaultValueFormatter(formatter: NumberFormatter.getPercentFormatter()))
        barChartView.animate(yAxisDuration: 1.5, easingOption: .easeInOutQuint)
        
    }
    
    func getChartDataEntries(forActivities activities: [Activity]?) -> [ChartDataEntry] {
        
        var dataEntries: [BarChartDataEntry] = []
        var dataNumber: Double = 0
        
        guard let activities = activities else {
            return []
        }
        
        let dateInterval = getDateInterval(forDate: self.date)
        let predicate = NSPredicate(format: "startDate >= %d AND stopDate <= %d",
                                    Int64(dateInterval.minDate.timeIntervalSince1970),
                                    Int64(dateInterval.maxDate.timeIntervalSince1970))
        
        let endDayPredicate = NSPredicate(format: "startDate <= %d AND stopDate >= %d",
                                          Int64(dateInterval.maxDate.timeIntervalSince1970),
                                          Int64(dateInterval.maxDate.timeIntervalSince1970))
        
        let beginDayPredicate = NSPredicate(format: "startDate <= %d AND stopDate >= %d",
                                            Int64(dateInterval.minDate.timeIntervalSince1970),
                                            Int64(dateInterval.minDate.timeIntervalSince1970))
        
        for activity in activities {
            
            //            guard let plannedActivities = activity.plannedActivity?.allObjects as? [PlannedActivity] else {
            //                continue
            //            }
            
            let filteredPlannedActivities = activity.plannedActivity?.filtered(using: predicate)
            let filteredEndDayPlannedActivities = activity.plannedActivity?.filtered(using: endDayPredicate)
            let filteredBeginDayPlannedActivities = activity.plannedActivity?.filtered(using: beginDayPredicate)
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
            let dataEntry = BarChartDataEntry(x: dataNumber, y: Double(duration), data: activity.name as AnyObject)
            
            dataEntries.append(dataEntry)
            dataNumber += 1
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
extension BarChartViewController: ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
        guard let data = entry.data as? String else {
            return
        }
        
        let marker:BalloonMarker = BalloonMarker(color: UIColor.white, font: UIFont(name: "Helvetica", size: 12)!, textColor: UIColor.black, insets: UIEdgeInsets(top: 7.0, left: 0.0, bottom: 7.0, right: 0.0))
        marker.minimumSize = CGSize(width: 36.0, height: 36.0)
        marker.setLabel("")
        chartView.marker = marker
        
        print(data)
    }
    
}

//MARK: NSFetchedResultController delegates
extension BarChartViewController: NSFetchedResultsControllerDelegate {
    
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
extension BarChartViewController {
    
    func onDatePickerChange(_ sender: UIDatePicker) {
        date = sender.date
    }
    
}

//MARK: TextField delegates
extension BarChartViewController: UITextFieldDelegate {
    
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

class PercentFormatter: NSObject, IAxisValueFormatter {
    
    let numFormatter: NumberFormatter
    var max: Double?
    
    override init() {
        numFormatter = NumberFormatter()
        numFormatter.minimumFractionDigits = 0
        numFormatter.maximumFractionDigits = 1
        
        // if number is less than 1 add 0 before decimal
        numFormatter.minimumIntegerDigits = 1 // how many digits do want before decimal
        numFormatter.paddingPosition = .beforePrefix
        numFormatter.paddingCharacter = "0"
    }
    
    init(max: Double) {
        numFormatter = NumberFormatter()
        numFormatter.minimumFractionDigits = 0
        numFormatter.maximumFractionDigits = 1
        
        // if number is less than 1 add 0 before decimal
        numFormatter.minimumIntegerDigits = 1 // how many digits do want before decimal
        numFormatter.paddingPosition = .beforePrefix
        numFormatter.paddingCharacter = "0"
        
        self.max = max
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        guard let maxValue = max else {
            return numFormatter.string(from: NSNumber(floatLiteral: value))!
        }
        let percentValue = value/maxValue * 100.0
        var valueString = numFormatter.string(from: NSNumber(floatLiteral: percentValue))!
        valueString.append("%")
        return valueString
    }
}
