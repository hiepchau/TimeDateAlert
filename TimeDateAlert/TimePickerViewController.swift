//
//  TimePickerViewController.swift
//  TimeDateAlert
//
//  Created by Châu Hiệp on 30/11/2022.
//

import UIKit

class TimePickerViewController: UIViewController {


    @IBOutlet weak var lbTimePicker: UILabel!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var countDown: UIDatePicker!
    @IBOutlet weak var lbCountDown: UILabel!
    @IBOutlet weak var btnCountDown: UIButton!
    
    var hours: Int = 0
    var mins: Int = 0
    var secs: Int = 0
    var timerTest: Timer? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        timePicker.locale = .current
        timePicker.date = Date()
        lbTimePicker.text = ""
        lbCountDown.text = ""
        timePicker.preferredDatePickerStyle = . wheels
        timePicker.addTarget(self, action: #selector(timeSelected), for: .valueChanged)
        
        btnCountDown.addTarget(self, action: #selector(startCountDown), for: .touchUpInside)
        
    }
    
    @objc func timeSelected(){
        let dateFormater = DateFormatter()
        dateFormater.dateStyle = .none
        dateFormater.timeStyle = .long
        dateFormater.timeZone = .current
        let date = dateFormater.string(from: timePicker.date)
        lbTimePicker.text = date
    }
    //Count down
    @objc func startCountDown() {
        let difference = floor(countDown.date.timeIntervalSince(Date()))
        if difference > 0.0 {
            let computedHours: Int = Int(difference) / 3600
            let remainder: Int = Int(difference) - (computedHours * 3600)
            let minutes: Int = remainder / 60
            let seconds: Int = Int(difference) - (computedHours * 3600) - (minutes * 60)
            
            print("\(computedHours) \(minutes) \(seconds)")
            hours = computedHours
            mins = minutes
            secs = seconds

            self.updateLabel()
            
            startTimer()
        }
        else {
            print("Error")
        }
    }
    
    private func startTimer() {
        stopTimerTest()
        timerTest = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            if self.secs > 0 {
                self.secs = self.secs - 1
            }
            else if self.mins > 0 && self.secs == 0 {
                self.mins = self.mins - 1
                self.secs = 59
            }
            else if self.hours > 0 && self.mins == 0 && self.secs == 0 {
                self.hours = self.hours - 1
                self.mins = 59
                self.secs = 59
            }

            self.updateLabel()
        })
    }
    
    func stopTimerTest() {
        timerTest?.invalidate()
        timerTest = nil
    }

    private func updateLabel() {
        let time = "\(mins):\(secs)"
        let formatter = DateFormatter()
        //fire fighting
        formatter.dateFormat = "mm:ss"
        lbCountDown.text = "\(hours):" + formatter.string(from: formatter.date(from: time)!)
    }
}
