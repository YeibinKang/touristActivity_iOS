//
//  myItineraryViewController.swift
//  A4
//
//  Created by Yeibin Kang on 2021-12-02.
//

import UIKit

import FirebaseFirestore
import FirebaseFirestoreSwift

class myItineraryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //boiler plate codes
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return myActivities.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        var myActivityList = myTableView2.dequeueReusableCell(withIdentifier: "myCell2", for: indexPath) as! myListTableViewCell
        
        
        myActivityList.myTitle.text = myActivities[indexPath.row].myTitle
        myActivityList.myRate.text = myActivities[indexPath.row].myRate
        myActivityList.myPrice.text = myActivities[indexPath.row].myPrice
        myActivityList.myDetails.text = myActivities[indexPath.row].myDetails
        myActivityList.myImage.image = UIImage(named:myActivities[indexPath.row].myImage)
        
        
        
        return myActivityList
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    //deleting by swiping a selected row
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        
        let currActivity = self.myActivities[indexPath.row]
        
        print("curr name: \(currActivity.myTitle)")
        print("Curr id: \(currActivity.id)")
        print("We are going to delete: \(currActivity.myTitle) with id of  \(currActivity.id!)")
        
        
        
        db2.collection("myActivities").document(currActivity.id!).delete{
            (error) in
            if let err = error{
                print(err)
            }else{
                print("Document deleted")
            }
        }
        
        if editingStyle == .delete{
            myActivities.remove(at: indexPath.row)
            myTableView2.deleteRows(at: [indexPath], with: .fade)
            print("The itinerary is deleted!")
        }
        

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.myTableView2.dataSource = self
        self.myTableView2.delegate = self
        
        
        //bring a data from firestore db
        db2.collection("myActivities").getDocuments{
            (queryResult, error) in
            
            if let err = error{
                print("Error while retrieving document from FS")
                print(err)
            }else{
                for document in queryResult!.documents{
                    print(document.data())
                    do{
                        let myActivityFromFS = try document.data(as: myActivity.self)
                        
                        self.myActivities.append(myActivityFromFS!)

                        
                    }catch{
                        print(error)
                    }
                }
                
                self.myTableView2.reloadData()
            }
        }
        
        
    }
    
    func createList(title:String, rate:String, price:String, details:String, image:String){
        
        //유저가 계속 추가를 할 때 마다
            //보낸 정보를 토대로 obj 만들어야 함.
            //만든 후, add Row 함수를 부른다.
        //create an activity
        var activityToAdd = myActivity(myTitle: tempTitle, myRate: tempRate, myPrice: tempPrice, myDetails: tempDetails, myImage: tempImage)
     
  
        do{
            let ret = try db2.collection("myActivities").addDocument(from: activityToAdd)
            
            print("Saving success!")
            print("Saved data name : \(activityToAdd.myTitle)")
            activityToAdd.id = ret.documentID
            
            addRow(activity: activityToAdd)
            
        }catch{
            print(error)
        }
        
        
        
        
    }
    
    func addRow(activity:myActivity){
        //not creating the list in here
            //need to check is the data duplicated or not
            //addRow should be called after creating the list
        print("Add row")
        
        if(myActivities.count == 0){
            //insert the first activity
            myActivities.append(activity)
            print(activity.myTitle)
        }else{
            
            //TODO: already exist filter doesn't work
            
            //check the activity item is already exist or not
            var activityExist = myActivities.contains(where: {$0.myTitle == activity.myTitle})


            if(activityExist){
                    print("already exist")
                }else{
                    myActivities.append(activity)
                    print("\(activity.myTitle) will be added in the row")
                }

            
            print(" is it already exist?: \(activityExist)")

        
        }


        print("a number of list is \(myActivities.count)")

    }
    
    
    //delete all elements in the list
    @IBAction func deleteAllPressed(_ sender: Any) {
        
        for (index, element) in myActivities.enumerated(){
            db2.collection("myActivities").document(element.id ?? "N/A").delete{
                (error) in
                if let err = error{
                    print(err)
                }else{
                    
                }
            }
        }
        
        
        myActivities.removeAll()
        
        myTableView2.reloadData()
        
        
    }
    
    
    //MARK: outlets
    
    
    @IBOutlet weak var myTableView2: UITableView!
    
    let db2 = Firestore.firestore()
    
    var tempTitle:String!=""
    var tempRate:String!=""
    var tempPrice:String!=""
    var tempDetails:String!=""
    var tempImage:String!=""
    
    var count:Int = 0
    
    var myActivities:[myActivity] = []
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
