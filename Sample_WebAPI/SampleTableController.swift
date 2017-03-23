//
//  SampleTableController.swift
//  Sample_WebAPI
//
//  Created by Product DEV on 1/3/17.
//  Copyright © 2017 Digiclinic. All rights reserved.
//

import UIKit

class SampleTableController: UITableViewController {

    var TableData: Array<String> = Array<String>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //get_data_from_url(jasonURL: "https://jsonplaceholder.typicode.com/posts/")
        //get_Json()
        get_Digiclinci_Api()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TableData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = TableData[indexPath.row]

        return cell
    }
    
    
    func do_table_refresh()
    {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func extract_json(jsonData:NSData!)
    {
        do{
         let json: AnyObject? =  try JSONSerialization.jsonObject(with: jsonData! as Data, options: .allowFragments) as AnyObject
            if let countries_list = json as? NSArray
            {
                for i in 0 ..< countries_list.count-1
                {
                    if let country_obj = countries_list[i] as? NSDictionary
                    {
                        if let country_name = country_obj["id"] as? String
                        {
                            if let country_code = country_obj["user"] as? String
                            {
                                TableData.append(country_name + " [" + country_code + "]")
                            }
                        }
                    }
                }
            }
                do_table_refresh();
        
        }catch {
            print("Error")
        }
    }
    
    
    func get_Digiclinci_Api() {
        
        
        
        
        let urlString = "https://dcstub.azurewebsites.net/api/token"
        
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod="POST"
        let poststringBody = "grant_type=password&username=demopatient&password=Password1&client_id=DigiClinic.Mobile"
        
        request.httpBody = poststringBody.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if statusCode == 200
            {
                print("Success: \(data)")
            }
            
            print(statusCode)
            
            
        
        }
        
        task.resume()
        
        
        
    }
    
    func get_Json() {
        let urlString = "http://www.learnswiftonline.com/Samples/subway.json"
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
           
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            print(statusCode)
            
            
                do {
                    
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String:Any]
                 
                    let stations = parsedData?["stations"] as! [[String:AnyObject]]
                    
                    print(stations)
                    
                    
                    
                    print("");print("");print("");print("");print("");
                    
                    
                    for station in stations {
                        print("\(station["buildYear"]!) - \(station["stationName"]!) ")
                    }
                    
                     print("");print("");print("");print("");print("");
                    
                } catch let error as NSError {
                    print(error)
                }
            
            }.resume()

      
        
    }
    
    
    
    func get_data_from_url(jasonURL: String)
    {
    
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        let url = URL(string: jasonURL)!
        print("jasonURL: \(jasonURL)")
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
           
            if error != nil {
                
                print(error!.localizedDescription)
                
            } else {
                
                
                print("1")
                print("data: \(data)")
                
                do {
                    if let dictionaryOK = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: String]
                    {
                        print("2")
                        print(dictionaryOK)
                        print("3")
                    }
                } catch {
                    print(error)
                    print("4")
                }
                
                print("5")
                
                do {
                    
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: AnyObject]
                    {
                       
                      
                        print(json)
                        
                        self.extract_json(jsonData: data! as NSData)
                        
//                        var convertedString = String(data: data!, encoding: String.Encoding.utf8);
//                        
//                        let allContent = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
//                        
//                        
//                        if let arrJSON = allContent["id"] {
//                            for index in 0...arrJSON.count-1 {
//                                let x = arrJSON[index] as! String;
//                            }
//                        }
                        
                        print("Test")
                        
                        
                        
                        
                    }
                    
                } catch {
                    print("error in JSONSerialization")
                  }
            }
       })
        task.resume()
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
