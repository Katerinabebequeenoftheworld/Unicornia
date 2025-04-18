import Foundation
import SwiftUI

struct WardrobeItem {
    let imageName: String
    let price: Int
    let isPurchased: Bool
}

class WardrobeService: ObservableObject {
    static let shared = WardrobeService()
    
    // Переменные для работы гардероба
    
    var itemIndex: Int
    @Published var itemName: String = "none"
    @Published var visibleItems: [WardrobeItem] = []
    @Published var purchasedItemStatus: Bool = false
    
    private var items: [WardrobeItem] = []
    private var userDefaults = UserDefaults.standard
    
    private init() { // Старторая настройка сервиса гардероба
        userDefaults.set(true, forKey: "none")
        
        itemIndex = userDefaults.object(forKey: "selectedAccessory") as? Int ?? 0
        loadItems()
        updateItemPurchasedStatus()
        setVisibleItems()
        updateItemName()
    }
    
    func loadItems() { // Список аксессуаров и их стоимости
        items = [
            WardrobeItem(imageName: "none", price: 0, isPurchased: getItemPurchasedStatus(item: "none")),
            WardrobeItem(imageName: "wardrobe_item_2", price: 200, isPurchased: getItemPurchasedStatus(item: "wardrobe_item_2")),
            WardrobeItem(imageName: "wardrobe_item_3", price: 300, isPurchased: getItemPurchasedStatus(item: "wardrobe_item_3")),
            WardrobeItem(imageName: "wardrobe_item_4", price: 500, isPurchased: getItemPurchasedStatus(item: "wardrobe_item_4")),
            WardrobeItem(imageName: "wardrobe_item_5", price: 250, isPurchased: getItemPurchasedStatus(item: "wardrobe_item_5")),
            WardrobeItem(imageName: "wardrobe_item_6", price: 350, isPurchased: getItemPurchasedStatus(item: "wardrobe_item_6")),
        ]
    }
    
    // Получение названия картинки выбранного элемента
    func getItemName() -> String {
        items[itemIndex].imageName
    }
    
    // Смещение элемента влево в циклическом меню
    func setPreviousItem() {
        if itemIndex == 0 {
            itemIndex = items.count - 1
        } else {
            itemIndex -= 1
        }
        
        setVisibleItems() // Обновление меню
        updateItemPurchasedStatus() // Обновление статуса куплено/некуплено
        
        if getCurrentItemPurchasedStatus() {
            updateItemName() // Обновление надетого аксессуара
            updateUD() // Сохранение изменений в память
        }
    }
    
    // Смещение элемента вправо в циклическом меню
    func setNextItem() {
        if itemIndex < items.count - 1 {
            itemIndex += 1
        } else {
            itemIndex = 0
        }
        
        setVisibleItems()
        updateItemPurchasedStatus()
        
        if getCurrentItemPurchasedStatus() {
            updateItemName()
            updateUD()
        }
    }
    
    // Получение цены выбранного элемента
    func getItemPrice() -> Int {
        items[itemIndex].price
    }
    
    // Сохранение в память покупку нового элемента и обновление отображений
    func setItemPurchasedStatus() {
        userDefaults.set(true, forKey: getItemName())
        updateItemName()
        updateItemPurchasedStatus()
        loadItems()
        updateUD()
    }
    
    // Получение статуса купленности выбранного элемента
    func getCurrentItemPurchasedStatus() -> Bool {
        userDefaults.object(forKey: getItemName()) as? Bool ?? false
    }
    
    // Получение статуса купленности элемента item
    func getItemPurchasedStatus(item: String) -> Bool {
        userDefaults.object(forKey: item) as? Bool ?? false
    }
    
    // Обновление элементов в меню
    func updateVisibleItems() {
        itemIndex = userDefaults.object(forKey: "selectedAccessory") as? Int ?? 0
        setVisibleItems()
        updateItemPurchasedStatus()
    }
    
    // Обновление надетого аксессуара
    private func updateItemName() {
        itemName = items[itemIndex].imageName
    }
    
    // Сохранение в память изменений
    private func updateUD() {
        userDefaults.set(itemIndex, forKey: "selectedAccessory")
    }
    
    // Обновление статуса купленного выбранного элемента
    private func updateItemPurchasedStatus() {
        purchasedItemStatus = getCurrentItemPurchasedStatus()
    }
    
    // Получение 5 элементов циклического меню
    private func setVisibleItems() {
        visibleItems = (-2...2).map { getCycleElement(at: itemIndex + $0, in: items) }
    }
    
    // Калькулятор циклической индексации массива
    private func getCycleElement(at index: Int, in array: [WardrobeItem]) -> WardrobeItem {
        let adjustedIndex = (index % array.count + array.count) % array.count
        return array[adjustedIndex]
    }
}
