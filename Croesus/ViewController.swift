//
//  ViewController.swift
//  Croesus
//
//  Created by Mitch on 26/03/2020.
//  Copyright © 2020 Mitch. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {

    @IBOutlet weak var surveryQuestionsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        surveryQuestionsTableView.delegate = self
        surveryQuestionsTableView.dataSource = self
        // Do any additional setup after loading the view.
        var ref: DatabaseReference =  Database.database().reference()
        ref.child("data").observeSingleEvent(of: .value, with: { (snapshot) in
          // Get user value
            guard let value = snapshot.value else {return}
            print("value is \(value)")
            self.saveToJsonFile(data: value)

          // ...
          }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func saveToJsonFile(data:Any) {
        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileUrl = documentDirectoryUrl.appendingPathComponent("ExampleQuestions.json")

        do {
            let data = try JSONSerialization.data(withJSONObject: data, options: [])
            try data.write(to: fileUrl, options: [])
        } catch {
            print(error)
        }
    }


}

extension ViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "SurveysTableViewCell") as? SurveysTableViewCell
        
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let surveysController = storyboard?.instantiateViewController(identifier: "BasicSurveyViewController") as? BasicSurveyViewController else {return}
        present(surveysController, animated: true, completion: nil)
    }
}
