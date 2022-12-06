//
//  DatePickerViewController.swift
//  TimeDateAlert
//
//  Created by Châu Hiệp on 30/11/2022.
//

import UIKit

class DatePickerViewController: UIViewController {


    @IBOutlet weak var lbDatePicker: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.locale = .current
        datePicker.date = Date()
        lbDatePicker.text = ""
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(dateSelected), for: .valueChanged)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSegTapped(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0: datePicker.preferredDatePickerStyle = .wheels
        case 1: datePicker.preferredDatePickerStyle = .inline
        case 2: datePicker.preferredDatePickerStyle = .compact
        default: break
        }
    }
    
    @objc func dateSelected(){
        let dateFormater = DateFormatter()
        dateFormater.dateStyle = .medium
        dateFormater.timeStyle = .short
        dateFormater.timeZone = .current
        let date = dateFormater.string(from: datePicker.date)
        lbDatePicker.text = date
    }
    


}
