//
//  myActivity.swift
//  A4
//
//  Created by Yeibin Kang on 2021-12-04.
//

import Foundation
import FirebaseFirestoreSwift

struct myActivity: Codable{
    
    var myTitle:String
    var myRate:String
    var myPrice:String
    var myDetails:String
    var myImage:String
    
    @DocumentID var id:String?
}
