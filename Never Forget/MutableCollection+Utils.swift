//
//  MutableCollection+Utils.swift
//  Never Forget
//
//  Created by Jase-Omeileo West on 8/21/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import Foundation

extension MutableCollection where Indices.Iterator.Element == Index
{
    /// Shuffles the contents of this collection.
    mutating func shuffle()
    {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled , unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            swap(&self[firstUnshuffled], &self[i])
        }
    }
}
