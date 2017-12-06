import Foundation

class BaggageOrderList : NSObject{
    var label1:String?
    var label2:String?
    var label2_2:String?
    var label3:String?
    var label4:String?
    var label5:String?
    var label6:String?
    var imageName: NSString
    
    init(label1:String?,label2:String?,label2_2:String?,label3:String?,label4:String?,label5:String?,label6:String?,imageName: String){
        self.label1 = label1
        self.label2 = label2
        self.label2_2 = label2_2
        self.label3 = label3
        self.label4 = label4
        self.label5 = label5
        self.label6 = label6
        self.imageName = imageName
    }
}