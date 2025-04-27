//
//  AsyncImageCacher.swift
//  AsyncImage
//
//  Created by Omar Elsayed on 22/04/2025.
//

import Foundation

final class _AsyncImageCacher<Key: Hashable, Value>: @unchecked Sendable {
    private let cache = NSCache<CacherKey, CachedValue>()

    func cache(_ value: Value, forKey key: Key) {
        let valueToCache = CachedValue(value: value)
        let keyToCache = CacherKey(key: key)

        cache.setObject(valueToCache, forKey: keyToCache)
    }

    func fetchCachedValue(forKey key: Key) -> Value? {
        guard let cachedValue = cache.object(forKey: CacherKey(key: key)) else { return nil }
        return cachedValue.value
    }

    func removeCachedValue(forKey key: Key) {
        cache.removeObject(forKey: CacherKey(key: key))
    }

    func removeAllCachedValues() {
        cache.removeAllObjects()
    }
}

extension _AsyncImageCacher {
    final class CacherKey: NSObject {
        let key: Key

        init(key: Key) { self.key = key }

        override var hash: Int { key.hashValue }

        override func isEqual(_ object: Any?) -> Bool {
            guard let other = object as? CacherKey else { return false }
            return key == other.key
        }
    }

    final class CachedValue {
        let value: Value

        init(value: Value) { self.value = value }
    }
}
