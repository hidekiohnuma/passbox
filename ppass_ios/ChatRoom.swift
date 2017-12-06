import Foundation

class ChatRoom : NSObject{
    var label1:String?
    var label2:String?
    var label3:String?
    var imageName: NSString
    
    init(label1:String?,label2:String?,label3:String?,imageName: String){
        self.label1 = label1
        self.label2 = label2
        self.label3 = label3
        self.imageName = imageName
    }
}