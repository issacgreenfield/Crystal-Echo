
import Foundation

class MyClass {
    var timerIterations: Int = 0
    
    func startTimer() {
        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "onTimer:", userInfo: nil, repeats: true)
    }
    func stopTimer(timer: NSTimer)
    {
//        NSTimer.invalidate()
        timer.invalidate()
    }
    
    @objc func onTimer(timer:NSTimer!) {
        print("\(timerIterations)")
        timerIterations
    }
}
let booboo: Int
booboo = 4


var anInstance = MyClass()
anInstance.startTimer()
CFRunLoopRun()

if anInstance.timerIterations == 10
{

}else
{
    anInstance.timerIterations++
}
















//var anInstance = MyClass()
//anInstance.timer
//anInstance.startTimer(anInstance.timer)
//
//if anInstance.timerIterations == 10
//{
//    anInstance.stopTimer(anInstance.timer)
//}else
//{
//    anInstance.timerIterations++
//}
//




//if anInstance.timerIterations == 10
//{
//    CFRunLoopStop()
//}else
//{
//    CFRunLoopRun()
//    anInstance.timerIterations++
//}


