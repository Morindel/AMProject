//
//  Completions.swift
//  AMProject
//
//  Created by Jakub Kołodziej on 21/10/2018.
//  Copyright © 2018 Jakub Kołodziej. All rights reserved.
//

typealias VoidCompletion = () -> Void
typealias BoolCompletion = (Bool) -> Void
typealias SingleItemCompletion<T> = (T) -> Void
typealias ArrayItemCompletion<T> = ([T]) -> Void
