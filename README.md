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

> FileManager: 使用 FileManager 能够对沙盒中的文件夹、文件进行操作。通过例如以下方式能够获取 NSFileManager 的单例：
>
> Bundle: iOS 应用都是通过 bundle 进行封装的，能够狭隘地将 bundle 理解为上述沙盒中的 AppName.app 文件。在 Finder 中，会把 bundle 当做一个文件显示从而防止用户误操作导致程序
> 文件损坏。但事实上内部是一个文件夹，包括了图像、媒体资源、编译好的代码、nib 文件等。这个文件夹称为 main bundle。

# SwiftUI

1. 在原项目中使用SwiftUI 创建的View

```
        let swiftUIVC = UIHostingController(rootView: LandmarkList())
        navigationController?.pushViewController(swiftUIVC, animated: true)
```

2. 在SwiftUI 项目中使用 原生的View

3. SwiftUI 使用 State 关键字来标记 变化的属性, 被标记的属性值发生变化,就会更新 View

4. 传值: 声明一个可变属性就可以, 

5. 使用循环的时候, 要定一个 id



