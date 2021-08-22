//
//  CalculationViewController.swift
//  GPA Calculator
//
//  Created by manish on 20/08/21.
//

import UIKit
/// This class is used for the calculation of average
class CalculationViewController: UIViewController {
    var screenType:Int = 0
    var isGrade:Bool = false
    var indexPath: IndexPath?
    //MARK:- IBOUTLET
 //   var db = DBhelper()
    var list: [Grade] = [Grade]()
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var Advertise: UIView!
    @IBOutlet weak var tblView: UITableView!
    var resultString: String? = nil
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "New Values"
        self.tblView.tableFooterView = UIView()
        self.setupTable()
        self.tapToHideKeyboard()
    //    print(DBhelper.shared.read(avg: 4))
        
        // Do any additional setup after loading the view.
    }
    func setupTable() {
        let Newmodel = Grade()
        Newmodel.id  = String(list.count + 1)
        Newmodel.name = ""
        list.append(Newmodel)
        
        self.tblView.reloadData()
    }
    var isScrolled : Bool = false
    
    @objc func keyboardWillShow(_ notification:NSNotification) {
        if self.isScrolled {
            self.tblView.contentSize = CGSize(width: 0, height: self.tblView.contentSize.height + 250.0)
            self.isScrolled = true
        }
    }
    @objc func keyboardWillHide(_ notification:NSNotification) {
        if self.isScrolled {
            self.tblView.contentSize = CGSize(width: 0, height: self.tblView.contentSize.height - 250.0)
            self.isScrolled = false
        }
    }
    func isValidate() -> Bool {
        if txtName.text!.isEmpty {
            let alert = UIAlertController(title: "", message: "The name field cannot be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return false
        }
        return true
    }
    func calculateResult() {
        if isValidate() {
        let totalRows = tblView.numberOfRows(inSection: 0)
        var sumofHours : Double = 0.0
        var sumofPoints : Double = 0.0
        for row in 0..<totalRows {
            print("row \(row)")
            guard let cell = tblView.cellForRow(at: IndexPath(row: row, section: 0)) as? CalculationCell else {
                return
            }
            if cell.reuseIdentifier != nil && cell.reuseIdentifier == "Cell"  {
                if list[row].hour != nil {
                    
                    sumofHours = sumofHours + Double(list[row].hour!)!
                }
                sumofPoints = sumofPoints + Double(list[row].point)
                
            }
        }
        let gpa = Double(sumofPoints/sumofHours)
        let actualGPA = String(format: "%.2f", gpa)
        let message = " G.P.A   = \(actualGPA) \n This is the result on your DATA!"
        self.resultString = message
        self.tblView.reloadData()
        // saving the data in data base
        DBhelper.shared.insert(name: txtName.text ?? "", result: message, avg: self.screenType, list: self.list)
      }
    }
    
    
}
extension CalculationViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count + 1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let cell = tblView.dequeueReusableCell(withIdentifier: "footer") as! CalculationCell
        cell.resDecription.text = resultString
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if resultString == nil {
            return 0
        }
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == list.count{
            let cell = tblView.dequeueReusableCell(withIdentifier: "calculation", for: indexPath) as! CalculationCell
            cell.selectionStyle = .none
            cell.setfooter()
            cell.tapforCalculate = {
                self.calculateResult()
            }
            return cell
        }else{
            let cell = tblView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CalculationCell
            cell.setData(model: list[indexPath.row])
            if indexPath.row == list.count - 1 {
                cell.btnPlus.isHidden = false
            }else {
                cell.btnPlus.isHidden = true
            }
            cell.tapforPlus = {
                self.setupTable()
            }
            cell.tapforHours = {
                self.list[indexPath.row].name = cell.txtName.text!
                self.indexPath = indexPath
                self.isGrade = false
                
                let storyBoard = UIStoryboard(name: "Start", bundle: nil)
                let vc = storyBoard.instantiateViewController(identifier: "SelectionTableViewController") as! SelectionTableViewController
                if self.list[indexPath.row].hour != nil {
                    vc.selectedIndex = self.list[indexPath.row].hour
                }
                //isgrade is false
                vc.isGrade = self.isGrade
                vc.delegate = self
                vc.screenType = self.screenType
                self.navigationController?.pushViewController(vc, animated: true)
            }
            cell.tapforGrade = {
                self.list[indexPath.row].name = cell.txtName.text!
                self.indexPath = indexPath
                self.isGrade = true
                let storyBoard = UIStoryboard(name: "Start", bundle: nil)
                let vc = storyBoard.instantiateViewController(identifier: "SelectionTableViewController") as! SelectionTableViewController
                if self.list[indexPath.row].grade != nil {
                    vc.selectedIndex = self.list[indexPath.row].grade
                }
                //isgrade is true
                vc.delegate = self
                vc.isGrade = self.isGrade
                vc.screenType = self.screenType
                self.navigationController?.pushViewController(vc, animated: true)
            }
            cell.selectionStyle = .none
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == list.count {
            return 80
        }else {
            return 200
        }
        
    }
    
    
}

extension CalculationViewController: CallBack {
    func callBack(str: String,point : Double) {
        if isGrade {
            list[self.indexPath!.row].grade = str
            list[self.indexPath!.row].point = point
            
        }else {
            list[self.indexPath!.row].hour = str
        }
        tblView.reloadRows(at: [self.indexPath!], with: .none)
    }
    
    
}
/// This class is used for the cell used in the tableview
class CalculationCell: UITableViewCell {
    //MARK:- IBOUTLET
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var btnGrade: UIButton!
    @IBOutlet weak var btnHours: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var btnCalculate: UIButton!
    
    var tapforHours: (()-> Void)?
    var tapforGrade: (()-> Void)?
    var tapforPlus: (()-> Void)?
    var tapforCalculate: (()-> Void)?
    
    func setData(model:Grade) {
        txtName.text = model.name
        
        if model.hour == nil {
            btnHours.setTitle("Credits", for: .normal)
        }else{
            btnHours.setTitle("\(model.hour ?? "") - Credits", for: .normal)
        }
        if model.grade == nil {
            btnGrade.setTitle("Grade", for: .normal)
        }else{
            btnGrade.setTitle("\(model.grade ?? "") - Grade", for: .normal)
        }
        btnHours.addTarget(self, action: #selector(tappedHours), for: .touchUpInside)
        btnGrade.addTarget(self, action: #selector(tappedGrades), for: .touchUpInside)
        btnPlus.addTarget(self, action: #selector(tappedPlus), for: .touchUpInside)
        
    }
    func setfooter() {
        btnCalculate.addTarget(self, action: #selector(tappedCalculate), for: .touchUpInside)
    }
    
    @objc func tappedHours() {
        if let tap = tapforHours {
            tap()
        }
    }
    @objc func tappedGrades() {
        if let tap = tapforGrade {
            tap()
        }
    }
    @objc func tappedPlus() {
        if let tap = tapforPlus {
            tap()
        }
    }
    @objc func tappedCalculate() {
        if let tap = tapforCalculate {
            tap()
        }
    }
    
    @IBOutlet weak var resDecription: UILabel!
}
