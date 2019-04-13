//
//  Result.swift
//  MVP_ConnpassEventSearch
//
//  Created by Daiki Katayama on 2019/04/04.
//  Copyright © 2019 Daiki Katayama. All rights reserved.
//

enum Result<T: Equatable>: Equatable {
    case success(T)
    case failure
}
