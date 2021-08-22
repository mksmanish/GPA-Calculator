//
//  SelectionTableViewController.swift
//  GPA Calculator
//
//  Created by manish on 20/08/21.
//

import UIKit

class SelectionTableViewController: UITableViewController {
    
    var isGrade : Bool = false
    var list: [Grade] = [Grade]()
    var selectedIndex:String?
    var delegate: CallBack?
    var screenType:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        if isGrade {
            self.navigationItem.title = "Select Grades"
        }else {
            self.navigationItem.title = "Select Hours"
        }
        self.setUp()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func setUp() {
        self.list.removeAll()
        if  isGrade {
            for i in 0...11{
                let mod = Grade()
                mod.id = String(i)
                if i == 0 {
                    mod.name = GradeTitle.A
                    if screenType == 4{
                        mod.point = GradeAvg4.A
                    }else if screenType == 5{
                        mod.point = GradeAvg5.A
                    }else {
                        mod.point = GradeAvg100.A
                    }
                }else if i == 1 {
                    mod.name = GradeTitle.A_M
                    if screenType == 4{
                        mod.point = GradeAvg4.A_M
                    }else if screenType == 5{
                        mod.point = GradeAvg5.A_M
                    }else {
                        mod.point = GradeAvg100.A_M
                    }
                }else if i == 2 {
                    mod.name = GradeTitle.B_P
                    if screenType == 4{
                        mod.point = GradeAvg4.B_P
                    }else if screenType == 5{
                        mod.point = GradeAvg5.B_P
                    }else {
                        mod.point = GradeAvg100.B_P
                    }
                   
                }else if i == 3 {
                    mod.name = GradeTitle.B
                    if screenType == 4{
                        mod.point = GradeAvg4.B
                    }else if screenType == 5{
                        mod.point = GradeAvg5.B
                    }else {
                        mod.point = GradeAvg100.B
                    }
                   
                }else if i == 4 {
                    mod.name = GradeTitle.B_M
                    if screenType == 4{
                        mod.point = GradeAvg4.B_M
                    }else if screenType == 5{
                        mod.point = GradeAvg5.B_M
                    }else {
                        mod.point = GradeAvg100.B_M
                    }
                  
                }else if i == 5 {
                    mod.name = GradeTitle.C_P
                    if screenType == 4{
                        mod.point = GradeAvg4.C_M
                    }else if screenType == 5{
                        mod.point = GradeAvg5.C_M
                    }else {
                        mod.point = GradeAvg100.C_M
                    }
                   
                }else if i == 6 {
                    mod.name = GradeTitle.C
                    if screenType == 4{
                        mod.point = GradeAvg4.C
                    }else if screenType == 5{
                        mod.point = GradeAvg5.C
                    }else {
                        mod.point = GradeAvg100.C
                    }
                  
                }else if i == 7 {
                    mod.name = GradeTitle.C_M
                    if screenType == 4{
                        mod.point = GradeAvg4.C_M
                    }else if screenType == 5{
                        mod.point = GradeAvg5.C_M
                    }else {
                        mod.point = GradeAvg100.C_M
                    }
                  
                }else if i == 8 {
                    mod.name = GradeTitle.D_P
                    if screenType == 4{
                        mod.point = GradeAvg4.D_P
                    }else if screenType == 5{
                        mod.point = GradeAvg5.D_P
                    }else {
                        mod.point = GradeAvg100.D_P
                    }
                 
                }else if i == 9 {
                    mod.name = GradeTitle.D
                    if screenType == 4{
                        mod.point = GradeAvg4.D
                    }else if screenType == 5{
                        mod.point = GradeAvg5.D
                    }else {
                        mod.point = GradeAvg100.D
                    }
                  
                }else if i == 10 {
                    mod.name = GradeTitle.D_M
                    if screenType == 4{
                        mod.point = GradeAvg4.D_M
                    }else if screenType == 5{
                        mod.point = GradeAvg5.D_M
                    }else {
                        mod.point = GradeAvg100.D_M
                    }
                    
                }else if i == 11 {
                    mod.name = GradeTitle.F
                    if screenType == 4{
                        mod.point = GradeAvg4.F
                    }else if screenType == 5{
                        mod.point = GradeAvg5.F
                    }else {
                        mod.point = GradeAvg100.F
                    }
                    
                }
                
                if selectedIndex != nil && mod.name == selectedIndex{
                    mod.isChecked = true
                }
                list.append(mod)
            }
            
        }else {
            for i in 0...4 {
                let model = Grade()
                model.id = String(i)
                model.name = String(i)
                if selectedIndex != nil && model.name == selectedIndex{
                    model.isChecked = true
                }
                list.append(model)
            }
            
        }
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SelectionCell
        cell.textLabel?.text = list[indexPath.row].name
        if list[indexPath.row].isChecked {
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        delegate?.callBack(str: list[indexPath.row].name ?? "", point: list[indexPath.row].point)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
