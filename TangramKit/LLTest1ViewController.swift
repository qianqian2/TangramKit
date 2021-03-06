//
//  LLTest1ViewController.swift
//  TangramKit
//
//  Created by apple on 16/7/14.
//  Copyright © 2016年 youngsoft. All rights reserved.
//

import UIKit

class LLTest1ViewController: UIViewController {
    
    override func loadView() {
        
        
        /*
         一个视图可以通过对frame的设置来完成其在父视图中的布局。这种方法的缺点是要明确的指出视图所在的位置origin和视图所在的尺寸size，而且在代码中会出现大量的常数，以及需要进行大量的计算。TangramKit的出现就是为了解决布局时的大量常数的使用，以及大量的计算，以及自动适配的问题。需要明确的是用TangramKit进行布局时并不是不要指定视图的位置和尺寸，而是可以通过一些特定的上下文来省略或者隐式的指定视图的位置和尺寸。因此不管何种布局方式，视图布局时都必须要指定视图的位置和尺寸。
         */
        
        let rootLayout = TGLinearLayout(.vert)
        rootLayout.backgroundColor = .white
        self.view = rootLayout;
        
        let vertTitleLabel = self.createSectionLabel(NSLocalizedString("vertical(from top to bottom)",comment:""))
        vertTitleLabel.tg_top.equal(10)  //顶部距离前面的视图10
        rootLayout.addSubview(vertTitleLabel);
        
        let vertLayout = createVertSubviewLayout()
        vertLayout.tg_size(width:.fill, height: .wrap) //宽度和父视图保持一致，高度由子视图决定
        //您也可以使用如下方法来分别设置:
        // vertLayout.tg_width.equal(.fill)
        // vertLayout.tg_height.equal(.wrap)
        //您可以用如下的便捷方式来进行设置。~= 是equal方法的运算符赋值方式。
        //vertLayout.tg_width ~= .fill
        //vertLayout.tg_height ~= .wrap
        rootLayout.addSubview(vertLayout)
        
        
        let horzTitleLabel = self.createSectionLabel(NSLocalizedString("horizontal(from left to right)",comment:""))
        horzTitleLabel.tg_top.equal(10)  //顶部距离前面的视图10
        rootLayout.addSubview(horzTitleLabel);

        
        let horzLayout = createHorzSubviewLayout()
        horzLayout.tg_width.equal(.fill)    //宽度填充父视图宽度。
        horzLayout.tg_height.equal(.fill)   //高度填充父视图的剩余高度
        //您可以用如下方法分别设置
        //horzLayout.tg_size(width:.fill, height: .fill) //宽度由子视图决定，高度填充父视图的剩余高度
        rootLayout.addSubview(horzLayout)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

// MARK: - Layout Construction
extension LLTest1ViewController
{
    
    func createSectionLabel(_ title:String) ->UILabel
    {
        let sectionLabel = UILabel()
        sectionLabel.text = title;
        sectionLabel.font = CFTool.font(17)
        sectionLabel.sizeToFit()             //sizeToFit函数的意思是让视图的尺寸刚好包裹其内容。注意sizeToFit方法必要在设置字体、文字后调用才正确。
        return sectionLabel
    }
    
    func createLabel(_ title:String, color backgroundColor:UIColor) -> UILabel
    {
        let v = UILabel()
        v.text = title;
        v.font = CFTool.font(15)
        v.numberOfLines = 0
        v.textAlignment = .center
        v.adjustsFontSizeToFitWidth = true
        v.backgroundColor =  backgroundColor
        v.layer.shadowOffset = CGSize(width:3, height:3)
        v.layer.shadowColor = CFTool.color(4).cgColor
        v.layer.shadowRadius = 2
        v.layer.shadowOpacity = 0.3
        
        return v
    }

    
    /**
     * 创建一个垂直的线性子布局。
     */
    func createVertSubviewLayout() ->TGLinearLayout
    {
        //创建垂直布局视图。
        let vertLayout = TGLinearLayout(.vert)
        vertLayout.backgroundColor = CFTool.color(0)
        
        /*
         对于垂直线性布局里面的子视图来说:
         1.如果不设置任何边距则每个子视图的左边都跟父视图左对齐，而上下则依次按加入的顺序排列。
         2.tg_left, tg_right的意义是子视图距离父视图的左右边距。
         3.tg_top, tg_bottom的意义是子视图和兄弟视图之间的上下间距。
         4.如果同时设置了tg_left,tg_right则除了能确定左右边距，还能确定自身的宽度。
         5.如果同时设置了tg_top,tg_bottom则只能确定和其他兄弟视图之间的上下间距，但不能确定自身的高度。
         6.tg_centerX表示子视图的水平中心点在父视图的水平中心点上的偏移。
         7.tg_centerY的设置没有意义。
         */
        
        let v1 = self.createLabel(NSLocalizedString("left margin", comment:""), color: CFTool.color(5))
        v1.tg_origin(x:10, y:10)             //设置左边距和上边距都为10
        v1.tg_size(width: 200, height: 35)   //设置视图的宽度和高度
        //您也可以用如下方式分别设置:
        // v1.tg_top.equal(10)        //上边边距10
        // v1.tg_left.equal(10)       //左边边距10
        // v1.tg_width.equal(200)     //宽度200
        // v1.tg_height.equal(35)     //高度35
        //您也可以采用运算符的方式进行设置：
        // v1.tg_top ~= 10
        // v1.tg_left ~= 10
        // v1.tg_width ~= 200
        // v1.tg_height ~= 35
        vertLayout.addSubview(v1)
        
        
        
        let v2 = self.createLabel(NSLocalizedString("horz center", comment:""), color: CFTool.color(6))
        v2.tg_top.equal(10)
        v2.tg_centerX.equal(0)   //水平居中的偏移,如果不等于0则会产生居中偏移
        v2.tg_width.equal(200)
        v2.tg_height.equal(35)   //等价于 v2.tg_size(width:200, height:35)
        vertLayout.addSubview(v2)
        
        
        let v3 = self.createLabel(NSLocalizedString("right margin", comment:""), color: CFTool.color(7))
        v3.tg_top.equal(10)
        v3.tg_right.equal(10)  //右边边距10,因为这里只设置了右边边距，所以垂直线性布局会将子视图进行右对齐。
        v3.tg_size(width: 200, height: 35)   //设置视图的宽度和高度
        vertLayout.addSubview(v3)
        
        
        /*
         对于布局里面的子视图来说我们仍然可以使用frame方法来进行布局，但是frame中的origin部分的设置将不起作用，size部分仍然会起作用。
         
         通过frame设置子视图尺寸和通过tg_width, tg_height来设置子视图布局尺寸的异同如下：
         1.二者都可以用来设置子视图的尺寸。
         2.通过frame设置视图的尺寸会立即生效，而通过后者设置尺寸时则只有在完成布局后才生效。
         3.如果同时设置了二者，最终起作用的是后者。
         4.不管通过何种方式设置尺寸，在布局完成时都可以通过frame属性读取到最终布局的位置和尺寸。
         */
        
        
        let v4 = self.createLabel(NSLocalizedString("left right", comment:""), color: CFTool.color(8))
        v4.tg_top.equal(10)
        v4.tg_bottom.equal(10) // 注意这里虽然设置了上下的间距，但是对于垂直线性布局来说，同时设置上下间距并不能决定子视图的高度，只是表明子视图离兄弟视图的距离而已
        v4.tg_left.equal(10)
        v4.tg_right.equal(10)  //上面两行代码将左右边距设置为10。对于垂直线性布局来说如果子视图同时设置了左右边距则宽度会自动算出，因此不需要设置tg_width的值了
        v4.tg_height.equal(35)  //这里仍然要设置子视图的高度。
        vertLayout.addSubview(v4)
        
        
        return vertLayout
        
    }
    
    /**
     * 创建一个水平的线性子布局。
     */
    func createHorzSubviewLayout() ->TGLinearLayout
    {
        //创建水平布局视图。
        let horzLayout = TGLinearLayout(.horz)
        horzLayout.backgroundColor = CFTool.color(0)
        
        /*
         对于水平线性布局里面的子视图来说:
         1.如果不设置任何边距则每个子视图的上边都跟父视图上对齐，而左右则依次按加入的顺序排列。
         2.tg_top, tg_bottom的意义是子视图距离父视图的上下边距。
         3.tg_left, tg_right的意义是子视图和兄弟视图之间的左右间距。
         4.如果同时设置了tg_top,tg_bottom则除了能确定上下边距，还能确定自身的高度。
         5.如果同时设置了tg_left,tg_right则只能确定和其他兄弟视图之间的左右间距，但不能确定自身的宽度。
         6.tg_centerY表示子视图的垂直中心点在父视图的垂直中心点上的偏移。
         7.tg_centerX的设置没有意义。
         */
        
        
        let v1 = self.createLabel(NSLocalizedString("top margin", comment:""), color: CFTool.color(5))
        v1.tg_top.equal(10)      //上边边距10
        v1.tg_left.equal(10)     //左边边距10
        v1.tg_width.equal(60)
        v1.tg_height.equal(60)
        horzLayout.addSubview(v1)
        
        
        
        let v2 = self.createLabel(NSLocalizedString("vert center", comment:""), color: CFTool.color(6))
        v2.tg_left.equal(10)
        v2.tg_centerY.equal(0)   //垂直居中，如果不等于0则会产生居中偏移
        v2.tg_width.equal(60)
        v2.tg_height.equal(60)   //设置布局尺寸
        horzLayout.addSubview(v2)
        
        
        let v3 = self.createLabel(NSLocalizedString("bottom margin", comment:""), color: CFTool.color(7))
        v3.tg_bottom.equal(10)
        v3.tg_left.equal(10)
        v3.tg_right.equal(5)  //对于水平线性布局来说，同时设置左右间距并不能决定子视图的宽度，因此需要明确的设定宽度。
        v3.tg_width.equal(60)
        v3.tg_height.equal(60)   //设置布局尺寸
        horzLayout.addSubview(v3)
        
        
        let v4 = self.createLabel(NSLocalizedString("top bottom", comment:""), color: CFTool.color(8))
        v4.tg_left.equal(10)
        v4.tg_right.equal(10)
        v4.tg_top.equal(10)
        v4.tg_bottom.equal(10) //上面两行代码将上下边距设置为10,对于水平线性布局来说如果子视图同时设置了上下边距则高度会自动算出,因此不需要设置tg_height的值了。
        v4.tg_width.equal(60)
        horzLayout.addSubview(v4)
        
        
        return horzLayout;
    }
    
}
