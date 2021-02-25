//
//  VoteModel.swift
//  MapVote
//
//  Created by LingoStar on 2021/02/22.
//

import Foundation
import MapKit

let dummyCategories:[Category] = [Category]()

struct Category: Codable {
    let categoryName: String
    var items: [Item]
}

struct Item : Codable {
    
    let itemName: String
    let pinImageUrl: String
    var latitude: Double = 0.0
    var longitude : Double = 0.0
    
    func makeAnnotation() -> Annotation {
        return Annotation(item: self)
    }
    
    enum CodingKeys : String , CodingKey {
        case itemName
        case pinImageUrl = "pinImage"
    }
}

class Annotation: NSObject, MKAnnotation {
    
    @objc dynamic var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)
    }
    
    var title: String? {
        return item.itemName
    }
    
    let item:Item
    
    init(item:Item) {
        self.item = item
    }
}

var categoryData : [Category] = []

func getJson(completion: @escaping ([Category]) -> Void){
    if let url = URL(string: "https://www.dropbox.com/s/bqhy21g0qvrhtom/Category.json?dl=1") {
       URLSession.shared.dataTask(with: url) { data, response, error in
          if let data = data {
              do {
                
                 let categoryItem = try JSONDecoder().decode([Category].self, from: data)
                
                categoryData = categoryItem

                completion(categoryItem)

              } catch let error {
                 print(error)
              }
           }
       }.resume()
    }
}


func createCategoryDummyData() -> [Category]{
    
    let politicsData : [Item] = [
        Item(itemName: "민주당", pinImageUrl: "theminjoo_logo", latitude: 36.5085153116395, longitude: 127.25339880040323),
        Item(itemName: "민주당", pinImageUrl: "theminjoo_logo", latitude: 36.51154098158622, longitude: 127.24874279646995),
        Item(itemName: "민주당", pinImageUrl: "theminjoo_logo", latitude: 36.51509731960058, longitude: 127.2421385355717),
        Item(itemName: "국민의힘", pinImageUrl: "peoplepowerparty_logo", latitude: 36.51509731960058, longitude: 127.2421385355717),
        Item(itemName: "국민의힘", pinImageUrl: "peoplepowerparty_logo", latitude: 36.50182656892, longitude: 127.26165412652605),
        Item(itemName: "국민의힘", pinImageUrl: "peoplepowerparty_logo", latitude: 36.514221520182, longitude: 127.24649734776456),
        Item(itemName: "열린민주당", pinImageUrl: "openminjoo_logo", latitude: 36.5006320897654, longitude: 127.25184679909215),
        Item(itemName: "열린민주당", pinImageUrl: "openminjoo_logo", latitude: 36.51315993184142, longitude: 127.2365249138082),
        Item(itemName: "정의당", pinImageUrl: "justice_logo", latitude: 36.509736210237556, longitude: 127.22866584333926),
        Item(itemName: "정의당", pinImageUrl: "justice_logo", latitude: 36.50859493604809, longitude: 127.26730076959407)]
    
    
    
    let hobbyData : [Item] = [
        Item(itemName: "reading", pinImageUrl: "reading_logo", latitude: 36.51664006987988, longitude: 127.26384647265553),
        Item(itemName: "reading", pinImageUrl: "reading_logo", latitude: 36.50608529449449, longitude: 127.25157268467761),
        Item(itemName: "reading", pinImageUrl: "reading_logo", latitude: 36.51122489106196, longitude: 127.23736770663983),
        Item(itemName: "soccer", pinImageUrl: "soccer_logo", latitude: 36.513294430884336, longitude: 127.2370243839078),
        Item(itemName: "soccer", pinImageUrl: "soccer_logo", latitude: 36.513294430884336, longitude: 127.2370243839078),
        Item(itemName: "soccer", pinImageUrl: "soccer_logo", latitude: 36.51346689003826, longitude: 127.25560672677898),
        Item(itemName: "soccer", pinImageUrl: "soccer_logo", latitude: 36.52002005311437, longitude: 127.24904067952889),
        Item(itemName: "piano", pinImageUrl: "piano_logo", latitude: 36.51101793403611, longitude: 127.2689963133282),
        Item(itemName: "piano", pinImageUrl: "piano_logo", latitude: 36.50204926471498, longitude: 127.26745136103405),
        Item(itemName: "baseball", pinImageUrl: "baseball_logo", latitude: 36.50601630430007, longitude: 127.26633556215492),
        Item(itemName: "baseball", pinImageUrl: "baseball_logo", latitude: 36.501428318381606, longitude: 127.24852569543086),
        Item(itemName: "climbing", pinImageUrl: "climbing_logo", latitude: 36.497978525847174, longitude: 127.25556381143748),
        Item(itemName: "climbing", pinImageUrl: "climbing_logo", latitude: 36.51508798730051, longitude: 127.24904067952889),
        Item(itemName: "biking", pinImageUrl: "biking_logo", latitude: 36.50618877967086, longitude: 127.26174362061403),
        Item(itemName: "biking", pinImageUrl: "biking_logo", latitude: 36.508120477570024, longitude: 127.23625190776072)]
    

    let sellerData : [Item] = [
        Item(itemName: "trumpet", pinImageUrl: "trumpet_logo", latitude: 36.509569219360635, longitude: 127.23110206678025),
        Item(itemName: "trumpet", pinImageUrl: "trumpet_logo", latitude: 36.51191474381813, longitude: 127.22934253777862),
        Item(itemName: "trumpet", pinImageUrl: "trumpet_logo", latitude: 36.510224593643926, longitude: 127.26749427637556),
        Item(itemName: "radio", pinImageUrl: "radio_logo", latitude: 36.5029116819165, longitude: 127.27101333437888),
        Item(itemName: "radio", pinImageUrl: "radio_logo", latitude: 36.5106385113848, longitude: 127.2637606416647),
        Item(itemName: "radio", pinImageUrl: "radio_logo", latitude: 36.50636125465736, longitude: 127.24414833059743),
        Item(itemName: "shoes", pinImageUrl: "shoes_logo", latitude: 36.50198027092386, longitude: 127.23539360093064),
        Item(itemName: "shoes", pinImageUrl: "shoes_logo", latitude: 36.509845167103634, longitude: 127.25560672677898),
        Item(itemName: "pants", pinImageUrl: "pants_logo", latitude: 36.51646761779719, longitude: 127.2669792922775),
        Item(itemName: "pants", pinImageUrl: "pants_logo", latitude: 36.49390757297461, longitude: 127.26496227122682)]
    
    let politicsCategory = Category(categoryName: "politics", items: politicsData)
    let hobbyCategory = Category(categoryName: "hobby", items: hobbyData)
    let sellerCategory = Category(categoryName: "seller", items: sellerData)

    return [politicsCategory, hobbyCategory, sellerCategory]
}
