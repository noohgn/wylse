//
//  DataHelper.swift
//  wylse
//
//  Created by Hanul Park on 3/24/15.
//  Copyright (c) 2015 weirdmeetup. All rights reserved.
//

import Foundation
import CoreData

public class DataHelper {
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    // 음식을 추가한다.
    func addFoods(foodName: String, tags: [String], complete: ()->()) {
        let foodEntity = NSEntityDescription.entityForName("Food", inManagedObjectContext: context)
        var newFood = Food(entity: foodEntity!, insertIntoManagedObjectContext: context)
        newFood.name = foodName
        
        for tag in tags {
            let tagEntity = NSEntityDescription.entityForName("Tag", inManagedObjectContext: context)
            var newTag = Tag(entity: tagEntity!, insertIntoManagedObjectContext: context)
            newTag.name = tag
            
            var tags = newFood.mutableSetValueForKey("tags")
            tags.addObject(newTag)
        }
        
        context.save(nil)
        
        complete()
    }
    
    // TODO: 음식정보를 수정한다. (태그도 수정?)
    func modifyFood(foodName: String, complete: ()->()) {
        
    }
    
    // 모든 음식을 가져온다.
    func fetchAllFoods() -> [Food] {
        let foodFetchRequest = NSFetchRequest()
        foodFetchRequest.entity = NSEntityDescription.entityForName("Food", inManagedObjectContext: context)
        
        let allFoods = context.executeFetchRequest(foodFetchRequest, error: nil) as! [Food]
        
        return allFoods
    }
}