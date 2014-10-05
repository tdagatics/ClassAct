//
//  main.m
//  ClassAct
//
//  Created by Anthony Dagati on 10/5/14.
//  Copyright (c) 2014 Black Rail Capital. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NSArray *BNRHierarchyForClass(Class cls) {
    // Declare an array to hold the list of this class and all of its superclasses, building a hierarchy
    NSMutableArray *classHierarchy = [NSMutableArray array];
    
    // Keep climbing the class hierarchy until we get to a class with no superclass
    for (Class c = cls; c != Nil; c = class_getSuperclass(c)) {
        NSString *className = NSStringFromClass(c);
        [classHierarchy insertObject:className atIndex:0];
    }
    return classHierarchy;
}

NSArray *BNRMethodsForClass(Class cls) {
    
    unsigned int methodCount = 0;
    
    Method *methodList = class_copyMethodList(cls, &methodCount);
    
    NSMutableArray *methodArray = [NSMutableArray array];
                     
    for (int m = 0; m < methodCount; m++) {
        // Get the current method
        Method currentMethod = methodList[m];
        // Get the selector for the current method
        SEL methodSelector = method_getName(currentMethod);
        // Add its string representation to the array
        [methodArray addObject:NSStringFromSelector(methodSelector)];
    }
    
    return methodArray;
}

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

