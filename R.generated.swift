//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)
  
  static func validate() throws {
    try intern.validate()
  }
  
  /// This `R.color` struct is generated, and contains static references to 0 color palettes.
  struct color {
    fileprivate init() {}
  }
  
  /// This `R.file` struct is generated, and contains static references to 0 files.
  struct file {
    fileprivate init() {}
  }
  
  /// This `R.font` struct is generated, and contains static references to 0 fonts.
  struct font {
    fileprivate init() {}
  }
  
  /// This `R.image` struct is generated, and contains static references to 4 images.
  struct image {
    /// Image `info`.
    static let info = Rswift.ImageResource(bundle: R.hostingBundle, name: "info")
    /// Image `pieChart`.
    static let pieChart = Rswift.ImageResource(bundle: R.hostingBundle, name: "pieChart")
    /// Image `settings`.
    static let settings = Rswift.ImageResource(bundle: R.hostingBundle, name: "settings")
    /// Image `time`.
    static let time = Rswift.ImageResource(bundle: R.hostingBundle, name: "time")
    
    /// `UIImage(named: "info", bundle: ..., traitCollection: ...)`
    static func info(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.info, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "pieChart", bundle: ..., traitCollection: ...)`
    static func pieChart(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.pieChart, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "settings", bundle: ..., traitCollection: ...)`
    static func settings(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.settings, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "time", bundle: ..., traitCollection: ...)`
    static func time(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.time, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.nib` struct is generated, and contains static references to 2 nibs.
  struct nib {
    /// Nib `ActivityTVCell`.
    static let activityTVCell = _R.nib._ActivityTVCell()
    /// Nib `MenuCVCell`.
    static let menuCVCell = _R.nib._MenuCVCell()
    
    /// `UINib(name: "ActivityTVCell", in: bundle)`
    static func activityTVCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.activityTVCell)
    }
    
    /// `UINib(name: "MenuCVCell", in: bundle)`
    static func menuCVCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.menuCVCell)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.reuseIdentifier` struct is generated, and contains static references to 2 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `MenuCVCell`.
    static let menuCVCell: Rswift.ReuseIdentifier<MenuCVCell> = Rswift.ReuseIdentifier(identifier: "MenuCVCell")
    /// Reuse identifier `activityTVCell`.
    static let activityTVCell: Rswift.ReuseIdentifier<ActivityTVCell> = Rswift.ReuseIdentifier(identifier: "activityTVCell")
    
    fileprivate init() {}
  }
  
  /// This `R.segue` struct is generated, and contains static references to 0 view controllers.
  struct segue {
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 5 storyboards.
  struct storyboard {
    /// Storyboard `ActivityManagerStoryboard`.
    static let activityManagerStoryboard = _R.storyboard.activityManagerStoryboard()
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()
    /// Storyboard `SettingsStoryboard`.
    static let settingsStoryboard = _R.storyboard.settingsStoryboard()
    /// Storyboard `StatisticsStoryboard`.
    static let statisticsStoryboard = _R.storyboard.statisticsStoryboard()
    
    /// `UIStoryboard(name: "ActivityManagerStoryboard", bundle: ...)`
    static func activityManagerStoryboard(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.activityManagerStoryboard)
    }
    
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    
    /// `UIStoryboard(name: "SettingsStoryboard", bundle: ...)`
    static func settingsStoryboard(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.settingsStoryboard)
    }
    
    /// `UIStoryboard(name: "StatisticsStoryboard", bundle: ...)`
    static func statisticsStoryboard(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.statisticsStoryboard)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.string` struct is generated, and contains static references to 3 localization tables.
  struct string {
    /// This `R.string.launchScreen` struct is generated, and contains static references to 0 localization keys.
    struct launchScreen {
      fileprivate init() {}
    }
    
    /// This `R.string.localizable` struct is generated, and contains static references to 18 localization keys.
    struct localizable {
      /// Value: Aktywności
      static let activities = Rswift.StringResource(key: "activities", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Aktywności
      static let manageActivities = Rswift.StringResource(key: "manageActivities", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Aktywność
      static let activity = Rswift.StringResource(key: "activity", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Analiza
      static let analysis = Rswift.StringResource(key: "analysis", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Brak rozpoczętej aktywności
      static let noCurrentActivity = Rswift.StringResource(key: "noCurrentActivity", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Dodaj aktywność
      static let addActivity = Rswift.StringResource(key: "addActivity", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Godzina rozpoczęcia
      static let startHour = Rswift.StringResource(key: "startHour", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Informacje
      static let info = Rswift.StringResource(key: "info", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Informacje o aplikacji
      static let aboutApp = Rswift.StringResource(key: "aboutApp", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Nowa aktywność
      static let newActivity = Rswift.StringResource(key: "newActivity", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Podaj nazwę aktywności
      static let typeActivityName = Rswift.StringResource(key: "typeActivityName", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Start
      static let start = Rswift.StringResource(key: "start", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Statystyki
      static let statistics = Rswift.StringResource(key: "statistics", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Stop
      static let stop = Rswift.StringResource(key: "stop", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Ustawienia
      static let settings = Rswift.StringResource(key: "settings", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Wróć
      static let back = Rswift.StringResource(key: "back", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Wybierz aktywność
      static let chooseActivity = Rswift.StringResource(key: "chooseActivity", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Wykres kołowy
      static let pieChart = Rswift.StringResource(key: "pieChart", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      
      /// Value: Aktywności
      static func activities(_: Void = ()) -> String {
        return NSLocalizedString("activities", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Aktywności
      static func manageActivities(_: Void = ()) -> String {
        return NSLocalizedString("manageActivities", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Aktywność
      static func activity(_: Void = ()) -> String {
        return NSLocalizedString("activity", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Analiza
      static func analysis(_: Void = ()) -> String {
        return NSLocalizedString("analysis", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Brak rozpoczętej aktywności
      static func noCurrentActivity(_: Void = ()) -> String {
        return NSLocalizedString("noCurrentActivity", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Dodaj aktywność
      static func addActivity(_: Void = ()) -> String {
        return NSLocalizedString("addActivity", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Godzina rozpoczęcia
      static func startHour(_: Void = ()) -> String {
        return NSLocalizedString("startHour", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Informacje
      static func info(_: Void = ()) -> String {
        return NSLocalizedString("info", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Informacje o aplikacji
      static func aboutApp(_: Void = ()) -> String {
        return NSLocalizedString("aboutApp", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Nowa aktywność
      static func newActivity(_: Void = ()) -> String {
        return NSLocalizedString("newActivity", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Podaj nazwę aktywności
      static func typeActivityName(_: Void = ()) -> String {
        return NSLocalizedString("typeActivityName", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Start
      static func start(_: Void = ()) -> String {
        return NSLocalizedString("start", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Statystyki
      static func statistics(_: Void = ()) -> String {
        return NSLocalizedString("statistics", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Stop
      static func stop(_: Void = ()) -> String {
        return NSLocalizedString("stop", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Ustawienia
      static func settings(_: Void = ()) -> String {
        return NSLocalizedString("settings", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Wróć
      static func back(_: Void = ()) -> String {
        return NSLocalizedString("back", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Wybierz aktywność
      static func chooseActivity(_: Void = ()) -> String {
        return NSLocalizedString("chooseActivity", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Wykres kołowy
      static func pieChart(_: Void = ()) -> String {
        return NSLocalizedString("pieChart", bundle: R.hostingBundle, comment: "")
      }
      
      fileprivate init() {}
    }
    
    /// This `R.string.main` struct is generated, and contains static references to 5 localization keys.
    struct main {
      /// pl translation: Aktywność: Wyprowadzanie psa na spacer
      /// 
      /// Locales: pl
      static let bp2PhCQGText = Rswift.StringResource(key: "Bp2-Ph-cQG.text", tableName: "Main", bundle: R.hostingBundle, locales: ["pl"], comment: nil)
      /// pl translation: Button
      /// 
      /// Locales: pl
      static let dRzZTYwhNormalTitle = Rswift.StringResource(key: "dRz-zT-Ywh.normalTitle", tableName: "Main", bundle: R.hostingBundle, locales: ["pl"], comment: nil)
      /// pl translation: Button
      /// 
      /// Locales: pl
      static let f8BoBqrNormalTitle = Rswift.StringResource(key: "7F8-Bo-bqr.normalTitle", tableName: "Main", bundle: R.hostingBundle, locales: ["pl"], comment: nil)
      /// pl translation: Button
      /// 
      /// Locales: pl
      static let pr8DTA0BNormalTitle = Rswift.StringResource(key: "Pr8-DT-A0B.normalTitle", tableName: "Main", bundle: R.hostingBundle, locales: ["pl"], comment: nil)
      /// pl translation: Godzina rozpoczęcia: 23:42
      /// 
      /// Locales: pl
      static let ssEQMJAvText = Rswift.StringResource(key: "SsE-QM-jAv.text", tableName: "Main", bundle: R.hostingBundle, locales: ["pl"], comment: nil)
      
      /// pl translation: Aktywność: Wyprowadzanie psa na spacer
      /// 
      /// Locales: pl
      static func bp2PhCQGText(_: Void = ()) -> String {
        return NSLocalizedString("Bp2-Ph-cQG.text", tableName: "Main", bundle: R.hostingBundle, comment: "")
      }
      
      /// pl translation: Button
      /// 
      /// Locales: pl
      static func dRzZTYwhNormalTitle(_: Void = ()) -> String {
        return NSLocalizedString("dRz-zT-Ywh.normalTitle", tableName: "Main", bundle: R.hostingBundle, comment: "")
      }
      
      /// pl translation: Button
      /// 
      /// Locales: pl
      static func f8BoBqrNormalTitle(_: Void = ()) -> String {
        return NSLocalizedString("7F8-Bo-bqr.normalTitle", tableName: "Main", bundle: R.hostingBundle, comment: "")
      }
      
      /// pl translation: Button
      /// 
      /// Locales: pl
      static func pr8DTA0BNormalTitle(_: Void = ()) -> String {
        return NSLocalizedString("Pr8-DT-A0B.normalTitle", tableName: "Main", bundle: R.hostingBundle, comment: "")
      }
      
      /// pl translation: Godzina rozpoczęcia: 23:42
      /// 
      /// Locales: pl
      static func ssEQMJAvText(_: Void = ()) -> String {
        return NSLocalizedString("SsE-QM-jAv.text", tableName: "Main", bundle: R.hostingBundle, comment: "")
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }
    
    fileprivate init() {}
  }
  
  fileprivate class Class {}
  
  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    try storyboard.validate()
  }
  
  struct nib {
    struct _ActivityTVCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType {
      typealias ReusableType = ActivityTVCell
      
      let bundle = R.hostingBundle
      let identifier = "activityTVCell"
      let name = "ActivityTVCell"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [NSObject : AnyObject]? = nil) -> ActivityTVCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? ActivityTVCell
      }
      
      fileprivate init() {}
    }
    
    struct _MenuCVCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType {
      typealias ReusableType = MenuCVCell
      
      let bundle = R.hostingBundle
      let identifier = "MenuCVCell"
      let name = "MenuCVCell"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [NSObject : AnyObject]? = nil) -> MenuCVCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? MenuCVCell
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try main.validate()
      try activityManagerStoryboard.validate()
      try settingsStoryboard.validate()
      try statisticsStoryboard.validate()
    }
    
    struct activityManagerStoryboard: Rswift.StoryboardResourceType, Rswift.Validatable {
      let activityManagerVC = StoryboardViewControllerResource<ActivityManagerViewController>(identifier: "ActivityManagerVC")
      let bundle = R.hostingBundle
      let name = "ActivityManagerStoryboard"
      
      func activityManagerVC(_: Void = ()) -> ActivityManagerViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: activityManagerVC)
      }
      
      static func validate() throws {
        if _R.storyboard.activityManagerStoryboard().activityManagerVC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'activityManagerVC' could not be loaded from storyboard 'ActivityManagerStoryboard' as 'ActivityManagerViewController'.") }
      }
      
      fileprivate init() {}
    }
    
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "LaunchScreen"
      
      fileprivate init() {}
    }
    
    struct main: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UINavigationController
      
      let bundle = R.hostingBundle
      let chooseActivityVC = StoryboardViewControllerResource<ChooseActivityViewController>(identifier: "ChooseActivityVC")
      let menuVC = StoryboardViewControllerResource<MenuViewController>(identifier: "MenuVC")
      let name = "Main"
      
      func chooseActivityVC(_: Void = ()) -> ChooseActivityViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: chooseActivityVC)
      }
      
      func menuVC(_: Void = ()) -> MenuViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: menuVC)
      }
      
      static func validate() throws {
        if _R.storyboard.main().chooseActivityVC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'chooseActivityVC' could not be loaded from storyboard 'Main' as 'ChooseActivityViewController'.") }
        if _R.storyboard.main().menuVC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'menuVC' could not be loaded from storyboard 'Main' as 'MenuViewController'.") }
      }
      
      fileprivate init() {}
    }
    
    struct settingsStoryboard: Rswift.StoryboardResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let name = "SettingsStoryboard"
      let settingsVC = StoryboardViewControllerResource<SettingsViewController>(identifier: "SettingsVC")
      
      func settingsVC(_: Void = ()) -> SettingsViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: settingsVC)
      }
      
      static func validate() throws {
        if _R.storyboard.settingsStoryboard().settingsVC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'settingsVC' could not be loaded from storyboard 'SettingsStoryboard' as 'SettingsViewController'.") }
      }
      
      fileprivate init() {}
    }
    
    struct statisticsStoryboard: Rswift.StoryboardResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let name = "StatisticsStoryboard"
      let pieChartVC = StoryboardViewControllerResource<PieChartViewController>(identifier: "PieChartVC")
      let statisticsVC = StoryboardViewControllerResource<StatisticsViewController>(identifier: "StatisticsVC")
      
      func pieChartVC(_: Void = ()) -> PieChartViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: pieChartVC)
      }
      
      func statisticsVC(_: Void = ()) -> StatisticsViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: statisticsVC)
      }
      
      static func validate() throws {
        if _R.storyboard.statisticsStoryboard().pieChartVC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'pieChartVC' could not be loaded from storyboard 'StatisticsStoryboard' as 'PieChartViewController'.") }
        if _R.storyboard.statisticsStoryboard().statisticsVC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'statisticsVC' could not be loaded from storyboard 'StatisticsStoryboard' as 'StatisticsViewController'.") }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}
