//
//  ViewController.swift
//  A4
//
//  Created by Yeibin Kang on 2021-11-30.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //boiler plate code
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seoulActivities.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var activity = myTableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! SeoulListTableViewCell
        
        
        activity.actTitle.text = seoulActivities[indexPath.row].title
        
        activity.actRate.text = seoulActivities[indexPath.row].rate
        
        activity.actPrice.text = seoulActivities[indexPath.row].price
        
        activity.actDetails.text = seoulActivities[indexPath.row].details
        
        activity.actImage.image = UIImage(named: seoulActivities[indexPath.row].image)

        return activity
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //for selecting a row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row clicked!")
        
        guard let screen2 = storyboard?.instantiateViewController(withIdentifier: "myItineraryScreen") as? myItineraryViewController else{
            print("error!")
            return
        }

        self.selectedR = indexPath.row
        
    }
    
    //Add button action
    @IBAction func addPressed(_ sender: Any) {
        
       //add itinerary to the myList
        //bring the second screen
        guard let screen2 = self.tabBarController?.viewControllers![1] as? myItineraryViewController else{
            print("error")
            return
        }
        
        
        //send an activity's information
        screen2.tempTitle = self.seoulActivities[selectedR].title
        screen2.tempRate = self.seoulActivities[selectedR].rate
        screen2.tempPrice = self.seoulActivities[selectedR].price
        screen2.tempDetails = self.seoulActivities[selectedR].details
        screen2.tempImage = self.seoulActivities[selectedR].image

        screen2.createList(title: screen2.tempTitle, rate: screen2.tempRate, price: screen2.tempPrice, details: screen2.tempDetails, image: screen2.tempImage)

        screen2.myTableView2.reloadData()

    }
    
    
    

    //MARK: outlets

    @IBOutlet weak var myTableView: UITableView!
    
    let db = Firestore.firestore()
    
    var selectedR:Int = 0
    var count:Int = 0
    
    struct Activity{
        var title:String
        var rate:String
        var price:String
        var details:String
        var image:String
    }
    
    var seoulActivities:[SeoulActivity] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.myTableView.dataSource = self
        self.myTableView.delegate = self
        
        db.collection("SeoulActivities").getDocuments{
            (queryResult, error) in
            
            if let err = error{
                print("Error while retrieving documents from FS")
                print(err)
            }else{
                for document in queryResult!.documents{
                    print(document.data())
                    do{
                        let activityFromFS = try document.data(as: SeoulActivity.self)
                        self.seoulActivities.append(activityFromFS!)

                    }catch{
                        print("Error converting document to Seoul Activity object")
                        print(error)
                    }
                    
                }
                print("Done adding activity ")
                print("The number of activities are : \(self.seoulActivities.count)")
                print("Update the tableview!")
                
                
                self.myTableView.reloadData()
            }
        }

    }


}

