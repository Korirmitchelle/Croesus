//
//  BasicSurveyViewController.swift
//  Croesus
//
//  Created by Mitch on 27/03/2020.
//  Copyright © 2020 Mitch. All rights reserved.
//

import UIKit
import SurveyNative

class BasicSurveyViewController: SurveyViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setSurveyAnswerDelegate(self)
        self.setCustomConditionDelegate(self)
        self.setValidationFailedDelegate(self)
        
        // Do any additional setup after loading the view.
    }
    
    override func surveyJsonFile() -> String {
         return "ExampleQuestions"
      }
      
      override func surveyTitle() -> String {
         return "Example Survey"
      }
}
extension BasicSurveyViewController:SurveyAnswerDelegate,CustomConditionDelegate,ValidationFailedDelegate{
    func question(for id: String, answer: Any) {
        print("Question: \(id) has answer (maybe is complete): \(answer)")
        if (surveyQuestions!.isQuestionFullyAnswered(id)) {
            print("Question: \(id) is complete")
        }
    }
    
    func isConditionMet(answers: [String : Any], extra: [String : Any]?) -> Bool {
        let id = extra!["id"] as! String
        if id == "check_age" {
           if let birthYearStr = answers["birthyear"] as? String, let ageStr = answers["age"] as? String {
              let birthYear = Int(birthYearStr)
              let age = Int(ageStr)
              let wiggleRoom = extra!["wiggle_room"] as? Int
              let date = Date()
              let calendar = Calendar.current
              let components = calendar.dateComponents([.year], from: date)
              let currentYear =  components.year
              return abs(birthYear! + age! - currentYear!) > wiggleRoom!
           } else {
              return false
           }
        } else {
           Logger.log("Unknown custom condition check: \(id)")
           return false
        }
    }
    
    func validationFailed(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
