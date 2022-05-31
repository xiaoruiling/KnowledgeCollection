# KnowledgeCollection
#  MapKit 总结

1. 设置权限: info.plist 文件中加入相对应的key值,会有弹框提示,选择权限后,才能正确使用地图
2. 获取当前位置, 设置时区, 然后设置CLLocationManager 的代理, 通过代理方法获取当前的位置
3. 地图上的数据源处理包含下面几个方面:
  - 显示annotationView ,自定义或者系统自带的, 一般包含标题/自标题/ 左边视图/右边视图/详细视图等
  - 地图的响应处理,在MapView 的delegate 中,包含地图发生移动/地图设置annotationView/annotationView 的一些响应包含(选中/跳转到详情等)
  - 设置地图annotationView 注意复用, prepareForDisplay/layoutSubviews/prepareForReuse
  
  - 自定义annotationView,时,最好复写 setSelected:animatied方法, 不推荐复写 setSelected 方法, 因为select属性是不能直接赋值的, setSelected 方法是mapview 系统内部控制,在适当的时机调用的, 而且
    击某一个annation时或者设置selectAnnotation:animated:/selectedAnnotations 是去调用复写的setSelected:animatied方法, 

    ```
    - (void)setSelected:(BOOL)select : 这个方法是设置select 属性的值的,所以当数据源有变化刷新的时候会调用
    A Boolean value indicating whether the annotation view is currently selected
    
    -(void)setSelected:(BOOL)selected animated:(BOOL)animated : 这个方法才是获取 annotation view 的状态,
    Sets the selection state of the annotation view
    
    ```

4. 地图上添加overlays,系统提供的有圆形/正方形/直线/多边形/等,可以设置颜色,标题等,也可以自定义形状
   - 添加 overlays 先创建好需要的overlay,添加到mapView 上面,但是,只有这一步,地图上是不会显示的,还需要进行第二步
   - 就是在MapView 的delegate mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) 方法中去实现返回响应的render, 这样地图上才会显示正确的形状
   ```
       func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            let render = MKCircleRenderer(overlay: overlay)
            render.strokeColor = .red
            render.fillColor = .green
            return render
        } else if overlay is MKPolygon {
            let render = MKPolygonRenderer(overlay: overlay)
            render.strokeColor = .orange.withAlphaComponent(0.2)
            render.fillColor = .red.withAlphaComponent(0.2)
            render.lineWidth = 3
            return render
        } else {
            return MKOverlayRenderer()
        }
    }
   ```
5. MapKit 还提供了地图快照生成的接口


# FileManager / Bundle

/AppName.app :应用程序的程序包文件夹。因为应用程序必须经过签名，所以不能在执行时对这个文件夹中的内容进行改动。否则会导致应用程序无法启动。
/Documents/ 保存应用程序的关键数据文件和用户数据文件等。
iTunes 同步时会备份该文件夹。

/Library/Caches 保存应用程序使用时产生的支持文件和缓存文件，还有日志文件最好也放在这个文件夹。iTunes 同步时不会备份该文件夹。
/Library/Preferences 保存应用程序的偏好设置文件（使用 NSUserDefaults 类设置时创建。不应该手动创建）。
/tmp/ 保存应用执行时所须要的暂时数据，iphone 重新启动时，会清除该文件夹下全部文件。

FileManager: 使用 FileManager 能够对沙盒中的文件夹、文件进行操作。通过例如以下方式能够获取 NSFileManager 的单例：

Bundle: iOS 应用都是通过 bundle 进行封装的，能够狭隘地将 bundle 理解为上述沙盒中的 AppName.app 文件。在 Finder 中，会把 bundle 当做一个文件显示从而防止用户误操作导致程序文件损坏。但事实上内部是一个文件夹，包括了图像、媒体资源、编译好的代码、nib 文件等。这个文件夹称为 main bundle。


# SwiftUI

1. 在原项目中使用SwiftUI 创建的View

```
        let swiftUIVC = UIHostingController(rootView: LandmarkList())
        navigationController?.pushViewController(swiftUIVC, animated: true)
```

2. 在SwiftUI 项目中使用 原生的View

3. SwiftUI 使用 ```State``` 关键字来标记 变化的属性, 被标记的属性值发生变化,就会更新 ```View```
   state: 存储属性的状态值,可以传给子视图的时候,如果当前视图的值改变,但是传递给的子视图的值是不会变的
   binding: 跟state 作用一样,但是,唯一的区别是,传递给子视图之后, 如果当前的视图值改变,那么传递给的子视图的值也会改变,但是需要用```$```这个来取值
   
    SceneStorage: 

4. 传值: 声明一个可变属性就可以, 

5. 使用循环的时候, 要定一个 id

6. Previews in Xcode: Platform/Device/interfaceOrientation

7. ObservalbleObject: 定义一个可被用于 publish 的对对象,此时被观察对象包含的属性要用 ```@Published``` 修饰, 不想被观察的则正常定义即可.
   @ObservedObject: 修饰可被观察的对象, 这个对象也可以传递给子视图,赋值给子视图的同样的一个被@ObservedObject修饰的此对象,当对象的属性发生变化的时候,当前视图及相关的子视图都会发生变化.
   
8. 在SwiftUI 项目中, 使用 UIKit 创建视图, 此时需要两个类, 一个是 UIKit 创建的类 AUIView, 另一个则是 stuct A 
   实现如下: 
   ```
struct CommonView: UIViewRepresentable {
        
    @Binding var textColor: Color // 可用于 更新数据
    
    func updateUIView(_ uiView: CommonUIView, context: Context) {
        
        uiView.backgroundColor = UIColor(textColor)
    }
    
    // 初始化
    func makeUIView(context: Context) -> CommonUIView {
        return CommonUIView(frame: CGRect(x: 0
                                          , y: 300,
                                          width: 300,
                                          height: 100))
    }
}
   ```
   ```
   class CommonUIView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
   ```
   
   UIViewController 等 同理
   
9. 
   

# RXSwift

1. cell 重用时, 导致重复订阅问题解决办法
  a). 把主动销毁的能力收回，销毁垃圾袋交给cell.disposeBag,在我们重用响应的时候，及时销毁，重置！
  b). 基类封装, 在 prepareForReuse 中 重置disposeBage
  c). 自定义,扩展 重用响应prepareForReuse,
  d). 把此次响应加入到特定的销毁袋，这个销毁袋通过关联属性的方式保证了一定的性能，同时这个销毁袋是观察了cell的重写响应，
  一旦有重写那么就直接销毁重置，达到自动重置效果

2. 重复订阅问题的解决思路: a). 不加入到销毁序列  b). 在合适的机会去重置 disposeBage  c). 在合适的机会掉哟过 complete或者error信号达到,及时回收



#Swift Package Manager

1. 传递依赖：引入的依赖库A里引用了库B, 但是库B中又引用别的依赖库C，此时A不需要再添加这些依赖库C, SPM 会自己解决这些传递依赖
2. A package consists of Swift source files and a manifest file. 

3. 生成的 Package 导入到项目中，需要在 Framework 里面添加

4. `swift package init`: 初始化， 会创建 package.swift 文件及一些sources files 
   `swift build`: This will download, resolve and compile dependencies mentioned in the manifest file Package.swift.
5.


#ios 防止截屏
 截屏是系统行为，在应用中没办法在截屏前阻止截屏，但是又一些比较特别的方法
 1. 截屏之后再删除，这个需要相册权限，例如: 爱奇艺
 2. 截屏之后，原先的界面给提示，例如： 微信/支付宝
 3. 使用私有类去处理

# 一些容易出错的点

1. 数组赋值时, 是浅拷贝, 修改一个地方的数组的值,其它的地方也会有问题, 解决方法有:
 a). 数组里面的model 对象 实现 NSCopying 和 NSMutableCopying, 实现copyWithZone和mutableCopyWithZone方法。
 b). 数组里面的model对象 A数组序列化为一个Data，再将Data解归档为一个新的数组。此时的数组就是一个全新的数组。不过类需要实现NSCoding协议，实现initWithCoder 和 encodeWithCoder方法。
 
2. 

# 遇到的问题

1.  Xcode 上遇到奇怪的问题,或者自己设置的是正确的,但是不生效, 解决办法: 1. Xcode 重启  2. 清理缓存。3. 重启加清理缓存 4. 卸载应用,重新安装
2. 
   
# ios 一个项目设置多个target
参考: ![https://www.jianshu.com/p/b051f9f083bf]

设置target 有两种方法

第一种: 操作简单, 需要修改的地方少
1. 选择顶部菜单栏：File ->New -> Target... 弹出选择框, 
2. 选择 Application -> App -> 然后填写taget name 等相关信息, 然后点击Finish 就OK, 此时文件结构如下
   TestCocoapods -> shared等主项目文件夹
                 -> 同shared 同级的目录下是新创建的target 的目录
3. 此方法创建的target 会有单独的类, 如果不想使用可以把 此 target 里面的类删掉或勾选掉不使用,使用主项目中的类, 不过使用主项目中的类,需要配置下, 选中需要用的类->Xcode 右侧, 找到Target Membership , 将 新建 的类勾选中 就OK 
4. 此方法下设置AppIcon 或者 Launch Screen, 需要创建AppIcon 和 Launch, 但两者的名字可以跟 主项目中的名字一样

第二种: 操作繁碎, 需要修改的地方也多

1. 选中主工程-》找到TARGETS, 选中主 target 然后点击右键, 选择 Duplicate ,会生成一个新的target, 名字为 主target name + copy
2. 然后点击新生成的 target 修改名字, 例如 修改为 target1
3. 找到Xcode 最上面 Scheme ,选择 target1, 然后 Edit Scheme, 此时有两个地方需要设置,
    1. 在弹出的页面上找到 info -》 Executable -> 设置成 target1.app
    2. 找到 Manager Schemes, 然后点击, 弹出 Manager Schemes 列表, 点击 新生成的 target ,修改为 target1
4. 此方法创建的 target 没有单独的类, 原则上可以 跟主 target 共享所有类, 对于想要使用的类, 仍然需要配置下, 选中需要用的类->Xcode 右侧, 找到Target Membership , 将 新建 的类勾选中 就OK 
5. 设置AppIcon 或者 Launch Screen 的时候, 要分别设置, 有多少个 target 就相应的创建多少个 AppIcon 和 Launch Screen(注意两者的名字要不一样) 然后再在每个 target 下面的 General-> App Icons and launch Images 下面 选择相对应的 AppIcon 和 Launch Screen

创建完 target 之后, 需要设置宏定义, 以方便在项目中区别不同的逻辑
设置宏定义:
1. OC 项目: Target -> Build Settings -> 搜索 macros, 在Preprocessor Macros 中可以分别设置 Debug模式和Release模式下的全局宏定义

2. Swift 项目: 在swift项目中没有宏定义的概念，也不能使用宏定义。Swift中对应OC中的宏定义有个flag（标识符）可供我们使用，在Build Setting中搜索：other swift flags
   PS：需要注意，这里添加标识的时候，需要在你自定义的标识符前加 “-D”；例如你的标识符为：MYFLAG，那么添加的时候要是：-DMYFLAG，而且不能像OC那样进行赋值。

设置完之后, 就可以使用#if #endif来判断了


# EventKit and EventKitUI

可以使用系统的日历(event) 和提醒(reminder)

1. 获取 event 和 reminder 的权限, 在 info.plist 中添加, 
NSCalendarsUsageDescription/ NSRemindersUsageDescription / NSContactsUsageDescription , 否则会崩溃
2. 这两个库中最重要的是 EKEventStore,  通常要把 evenStore 设置成单例
>   The EKEventStore class is the main point of contact for accessing Calendar data. You must create a EKEventStore object in order to retrieve/add/delete events or reminders from the Calendar database.
3. 创建 event, 可以用系统的 EKEventEditViewController
4. 创建 reminder , 没有可以编辑的页面, 只能通过代码设置
5. 对event 编辑时,要设置 editdelegate, 不然,点击 保存或者 取消 ,editViewController 会无法消失, 因为消失的代码在代理里面处理

   
   




