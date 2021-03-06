//
//  MenuViewController.swift
//  Timanager
//
//  Created by Kryg Tomasz on 08.07.2017.
//  Copyright © 2017 Kryg Tomek. All rights reserved.
//

import UIKit
import CoreData

class MenuViewController: MainViewController {

    @IBOutlet weak var mainImageView: UIImageView! {
        didSet {
            mainImageView.contentMode = .scaleAspectFill
            mainImageView.image = #imageLiteral(resourceName: "menuBackground")
        }
    }
    @IBOutlet weak var appNameLabel: UILabel! {
        didSet {
            appNameLabel.text = R.string.localizable.appName()
            appNameLabel.textColor = .main
        }
    }
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(R.nib.menuCVCell(), forCellWithReuseIdentifier: R.reuseIdentifier.menuCVCell.identifier)
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    @IBOutlet weak var activityView: UIView! {
        didSet {
            activityView.backgroundColor = UIColor.main.withAlphaComponent(0.75)
//            activityView.roundCornersWithLayerMask(cornerRadii: 10.0, corners: [.topLeft, .topRight])
        }
    }
    @IBOutlet weak var currentActivityLabel: UILabel! {
        didSet {
            currentActivityLabel.textColor = .white
        }
    }
    @IBOutlet weak var timeLabel: UILabel! {
        didSet {
            timeLabel.textColor = .white
        }
    }
    @IBOutlet weak var chooseActivityButton: UIButton! {
        didSet {
            chooseActivityButton.heroID = "choosenActivity"
            chooseActivityButton.setTitle(R.string.localizable.chooseActivity(), for: .normal)
            chooseActivityButton.layer.cornerRadius = 8
            chooseActivityButton.layer.borderWidth = 1.0
            chooseActivityButton.layer.borderColor = UIColor.main.cgColor
            chooseActivityButton.backgroundColor = .tint
            chooseActivityButton.setTitleColor(.white, for: .normal)
            chooseActivityButton.setTitleColor(.main, for: .disabled)
            chooseActivityButton.addTarget(self, action: #selector(onChooseActivityButtonClicked), for: .touchUpInside)
        }
    }
    @IBOutlet weak var startStopStackView: UIStackView!
    @IBOutlet weak var startButton: UIButton! {
        didSet {
            startButton.setTitle("", for: .normal)
            startButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            startButton.imageView?.contentMode = .scaleAspectFit
            startButton.tintColor = .mainDarkGreen
            startButton.layer.cornerRadius = 10.0
            startButton.backgroundColor = .mainPastelGreen
            startButton.setTitleColor(.white, for: .normal)
            startButton.addTarget(self, action: #selector(onStartButtonClicked), for: .touchUpInside)
        }
    }
    @IBOutlet weak var stopButton: UIButton! {
        didSet {
            stopButton.setTitle("", for: .normal)
            stopButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            stopButton.imageView?.contentMode = .scaleAspectFit
            stopButton.tintColor = .mainDarkRed
            stopButton.layer.cornerRadius = 10.0
            stopButton.backgroundColor = .mainPastelRed
            stopButton.setTitleColor(.white, for: .normal)
            stopButton.addTarget(self, action: #selector(onStopButtonClicked), for: .touchUpInside)
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let NUMBER_OF_CELLS: CGFloat = 3
    
    var choosenActivity: Activity? {
        didSet {
            guard let name = choosenActivity?.name else {
                chooseActivityButton.setTitle(R.string.localizable.chooseActivity(), for: .normal)
                chooseActivityButton.setTitleColor(.white, for: .normal)
                setStartStopButtons()
                return
            }
            setStartStopButtons()
            chooseActivityButton.setTitle("\(name)", for: .normal)
            chooseActivityButton.setTitleColor(.white, for: .normal)
        }
    }
    var currentActivity: PlannedActivity? {
        didSet {
            guard let activity = currentActivity?.activity else {
                currentActivityLabel.text = R.string.localizable.noCurrentActivity()
                timeLabel.text = ""
                setStartStopButtons()
                chooseActivityButton.isEnabled = true
                return
            }
            let name = activity.name ?? ""
            currentActivityLabel.text = "\(R.string.localizable.activity()): \(name)"
            setStartStopButtons()
            chooseActivityButton.isEnabled = false
            startTimer()
            onTimerUpdate()
        }
    }
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fetchRequest = NSFetchRequest<PlannedActivity>(entityName: "PlannedActivity")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "stopDate == 0")
        do {
            let objects = try context.fetch(fetchRequest)
            choosenActivity = objects.first?.activity
            currentActivity = objects.first
        } catch {
            let fetchError = error as NSError
            print("Unable to Perform Fetch Request for PlannedActivites")
            print("\(fetchError), \(fetchError.localizedDescription)")
        }
        mainImageView.addParallaxEffect()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.navigationController?.navigationBar.barTintColor = .black
        UIApplication.shared.statusBarStyle = .default
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }

}

//MARK: Buttons clicked methods
extension MenuViewController {
    
    func onChooseActivityButtonClicked() {
        let storyboard = R.storyboard.main()
        guard let vc = storyboard.instantiateViewController(withIdentifier: MenuIdentifiers.ChooseActivityVC) as? ChooseActivityViewController else {
            return
        }
        vc.prepare(using: .chooseActivities)
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    func onStartButtonClicked() {
        guard let activity = choosenActivity else {
            // CHOOSE ACTIVITY ALERT
            return
        }
        let date = Date()
        let startDate = Int64(date.timeIntervalSince1970)
        let object = PlannedActivity(context: context)
        object.fill(with: activity, startDate: startDate)
        do {
            try object.managedObjectContext?.save()
        } catch {
            print("Error saving activity object")
        }
        currentActivity = object
    }
    
    func onStopButtonClicked() {
        guard let activity = currentActivity else {
            return
        }
        let date = Date()
        let stopDate = Int64(date.timeIntervalSince1970)
        activity.stopDate = stopDate
        do {
            try activity.managedObjectContext?.save()
        } catch {
            print("Error saving activity object")
        }
        currentActivity = nil
        stopTimer()
    }
    
}

//MARK: Timer methods
extension MenuViewController {
    
    fileprivate func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerUpdate), userInfo: nil, repeats: true)
    }
    
    fileprivate func stopTimer() {
        timer?.invalidate()
    }
    
    func onTimerUpdate() {
        guard let startDate = currentActivity?.startDate else {
            return
        }
        
        let start = Date(timeIntervalSince1970: TimeInterval(startDate))
        let durationInSeconds = -start.timeIntervalSinceNow
        let parsedDuration = parseDuration(using: durationInSeconds)
        let hours = String(format: "%02d", parsedDuration.hours)
        let minutes = String(format: "%02d", parsedDuration.minutes)
        let seconds = String(format: "%02d", parsedDuration.seconds)
        timeLabel.text = R.string.localizable.durationTime() + ": \(hours):\(minutes):\(seconds)"
    }
    
    fileprivate func parseDuration(using seconds: TimeInterval) -> (hours: Int, minutes: Int, seconds: Int) {
        let hours = Int(seconds/3600)
        let minutes = Int(seconds/60)%60
        let seconds = Int(seconds)%60
        return (hours, minutes, seconds)
    }
    
}

//MARK: Start/Stop buttons management
extension MenuViewController {
    
    fileprivate func setStartStopButtons() {
        if let _ = currentActivity {
            startStopStackView.isHidden = false
            showStartStopButton(startButton, enable: false, animated: false)
            showStartStopButton(stopButton, enable: true, animated: false)
        } else {
            if let _ = choosenActivity {
                startStopStackView.isHidden = false
                showStartStopButton(startButton, enable: true, animated: false)
                showStartStopButton(stopButton, enable: false, animated: false)
            } else {
                startStopStackView.isHidden = true
                showStartStopButton(startButton, enable: false, animated: false)
                showStartStopButton(stopButton, enable: false, animated: false)
            }
        }
    }
    
    fileprivate func showStartStopButton(_ button: UIButton, enable: Bool, animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.33) {
                button.isHidden = !enable
                self.startStopStackView.layoutIfNeeded()
            }
        } else {
            button.isHidden = !enable
        }
    }
    
}

// MARK: CollectionView Delegates
extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(NUMBER_OF_CELLS)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.menuCVCell.identifier, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let menuCell = cell as? MenuCVCell else {
            return
        }
        let data = MenuCVCellData(forIndexPath: indexPath)
        menuCell.prepare(with: data)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let menuCell = collectionView.cellForItem(at: indexPath) as? MenuCVCell else {
            return
        }
        for cell in collectionView.visibleCells {
            guard let tempCell = cell as? MenuCVCell else {
                return
            }
            tempCell.resetHeroIds()
        }
        menuCell.titleImageView.heroID = "navigationImageView"
        menuCell.titleLabel.heroID = "navigationTitle"
        menuCell.bottomView.heroID = "navigation"
       let data = MenuCVCellData(forIndexPath: indexPath)
        switch indexPath.row {
        case 0:
            pushTimeManagerVC(usingColor: data.color)
        case 1:
            pushActivityManagerVC(usingColor: data.color)
        case 2:
            pushSettingsVC(usingColor: data.color)
        default:
            break
        }
    }
    
}

extension MenuViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.width
        let cellHeight = collectionView.bounds.height/3
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

//MARK: Pushed ViewControllers
extension MenuViewController {
    
    fileprivate func pushTimeManagerVC(usingColor color: UIColor?) {
        let storyboard = R.storyboard.statisticsStoryboard()
        guard let vc = storyboard.instantiateViewController(withIdentifier: StatisticsIdentifiers.StatisticsVC) as? StatisticsViewController else {
            return
        }
        vc.prepare(using: color)
        self.present(vc, animated: true, completion: nil)
    }
    
    fileprivate func pushActivityManagerVC(usingColor color: UIColor?) {
        let storyboard = R.storyboard.activityManagerStoryboard()
        guard let vc = storyboard.instantiateViewController(withIdentifier: ActivityManagerIdentifiers.ActivityManagerVC) as? ActivityManagerViewController else {
            return
        }
        vc.delegate = self
        vc.prepare(using: color)
        self.present(vc, animated: true, completion: nil)
    }
    
    fileprivate func pushSettingsVC(usingColor color: UIColor?) {
        let storyboard = R.storyboard.settingsStoryboard()
        guard let vc = storyboard.instantiateViewController(withIdentifier: SettingsIdentifiers.SettingsVC) as? SettingsViewController else {
            return
        }
        vc.delegate = self
        vc.prepare(using: color)
        self.present(vc, animated: true, completion: nil)
    }
    
}

//MARK: ChooseActivity delegates
extension MenuViewController: ChooseActivityDelegate {
    
    func chooseActivity(_ activity: Activity) {
        choosenActivity = activity
    }
    
}

//MARK: ActivityManager View delegate
extension MenuViewController: ActivityManagerDelegate {
    
    func deleteActivity(_ activity: Activity) {
        context.delete(activity)
        do {
            try activity.managedObjectContext?.save()
            if choosenActivity?.name == activity.name {
                choosenActivity = nil
                currentActivity = nil
            }
        } catch {
            print("Error deleting activity object")
        }
    }
    
}

//MARK: Settings View delegate
extension MenuViewController: SettingsDelegate {
    
    func truncateEverything(_ viewController: UIViewController) {
        if Activity.clear() && PlannedActivity.clear() {
            choosenActivity = nil
            currentActivity = nil
            showSuccessfulTruncateAlert(on: viewController)
        }
    }
    
    private func showSuccessfulTruncateAlert(on viewController: UIViewController) {
        let alert = UIAlertController(title: R.string.localizable.success()+"!", message: R.string.localizable.successfulDataDeletion(), preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: R.string.localizable.ok(), style: .default, handler: {
            action in
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(acceptAction)
        viewController.present(alert, animated: true, completion: nil)
    }
    
}
