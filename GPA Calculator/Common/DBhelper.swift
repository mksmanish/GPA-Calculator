//
//  DBhelper.swift
//  GPA Calculator
//
//  Created by manish on 21/08/21.
//

import Foundation
import SQLite3
class DBhelper {
   static let shared = DBhelper()
    var db :OpaquePointer?
    var path: String = "myDb.sqlite"
    init() {
        self.db = createdb()
        self.createtable()
    }
    func createdb() -> OpaquePointer? {
        let filepath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask,appropriateFor:nil, create:false).appendingPathExtension(path)
        var db : OpaquePointer? = nil
        if sqlite3_open(filepath.path, &db) != SQLITE_OK {
            print("there is error in creating")
            return nil
        }else{
            print("database has been created \(path)")
            return db
        }
        
    }
    
    func createtable() {
        let query = "CREATE TABLE IF NOT EXISTS grade(Id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,result TEXT,avg INTEGER,list TEXT);"
        var createTab : OpaquePointer? = nil
        if sqlite3_prepare_v2(self.db, query, -1, &createTab, nil) == SQLITE_OK {
            if sqlite3_step(createTab) == SQLITE_DONE {
                print("table creation success")
            }else {
                print("table creation fail")
            }
        }else {
            
            print("prepare creation  fail")
        }
    }
    
    func insert(name:String,result : String , avg :Int ,list: [Grade]) {
        let query = "INSERT INTO grade (id,name,result,avg,list) VALUES (? ,? ,? ,? ,?)"
        var statement : OpaquePointer? = nil
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) ==  SQLITE_OK{
            sqlite3_bind_int(statement, 1,  1)
            sqlite3_bind_text(statement, 2, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 3, (result as NSString).utf8String, -1, nil)
            sqlite3_bind_int(statement, 4, Int32(avg))
            let data = try! JSONEncoder().encode(list)
            let listString = String(data:data,encoding: .utf8)
            sqlite3_bind_text(statement, 5, (listString! as NSString).utf8String, -1, nil)
            if sqlite3_step(statement) ==  SQLITE_DONE {
                print("data inserted success")
            }else {
                print("data not inserted success")
            }
        }else{
            print("prepare creation fail")
        }
    }
    
    func read(avg :Int) -> [dbGrade] {
        var mainList = [dbGrade]()
        let query = "SELECT * FROM grade;"
        var statement : OpaquePointer? = nil
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) ==  SQLITE_OK{
            while sqlite3_step(statement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(statement, 0))
                let name = String(describing:String(cString:sqlite3_column_text(statement,1)))
                let result = String(describing:String(cString:sqlite3_column_text(statement,2)))
                let avg = Int(sqlite3_column_int(statement, 3))
                let listdata = String(describing:String(cString:sqlite3_column_text(statement,4)))
                
                let model = dbGrade()
                model.id = id
                model.name = name
                model.result = result
                model.AvgTYpe = avg
                
                let data = try! JSONDecoder().decode([Grade].self, from: listdata.data(using: .utf8)!)
                model.list = data
                
                mainList.append(model)
            }
        }
        
        return mainList
    }
    func delete(id:Int) {
        let query = "DELETE FROM grade where id = \(id)"
        var statement : OpaquePointer? = nil
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) ==  SQLITE_OK{
            if sqlite3_step(statement) == SQLITE_DONE {
                print("data deletion success")
            }else {
                print("data deletion failed")
            }
        }else {
            print("prepare creation  fail")
        }
        
    }
}
