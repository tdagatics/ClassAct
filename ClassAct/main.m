//
//  main.m
//  ClassAct
//
//  Created by Anthony Dagati on 10/5/14.
//  Copyright (c) 2014 Black Rail Capital. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // insert code here...
        // Declare a variable to hold the number of registered classes
        unsigned int classCount = 0;
        
        // Get a pointer to a list of all registered classes currently loaded by your app
        // The number of registered classes is returned by reference
        Class *classList = objc_copyClassList(&classCount);
        
        // For each class in the list..
        for (int i = 0; i < classCount; i++) {
            
            // Treat the classList as a C array to get a Class from it
            Class currentClass = classList[i];
            
            // Get the class's name as a string
            NSString *className = NSStringFromClass(currentClass);
            
            //Log the class's name
            NSLog(@"The class's name is %@", className);
        }
        
        // We're done with the class list buffer, so free it
        free(classList);
    }
    return 0;
}

