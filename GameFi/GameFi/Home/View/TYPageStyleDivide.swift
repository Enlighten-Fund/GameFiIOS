//
//  TYPageStyleDivide.swift
//  GameFi
//
//  Created by harden on 2021/12/17.
//

class TYPageStyleDivide {
    
    var labelHeight: CGFloat = 44            //标签高度
    var labelMargin: CGFloat = 0            //标签间隔
    var labelFont: CGFloat = 15              //标签字体大小
    var labelSelFont: CGFloat = 15          //选中字体大小
    var labelCenterWidth: CGFloat = 50      //居中模式下label的默认宽度
    
    var labelLayout: LabelLayout = .divide   //默认可以滚动
    var moveAnimation: MoveAnimation = .scroll  //底部线运动d动画
    
    var isShowBottomLine: Bool = true        //是否显示底部的线
    var isShowColorScale: Bool = true        //是否显示文字颜色动画
    var bottomAlginLabel: Bool = true        //bottomline跟随文字标签宽度  默认跟随label的宽度 false跟随labelText的宽度
    var isShowFontScale: Bool = false        //是否显示font变化动画

    var selectColor: UIColor = UIColor(red: 0.36, green: 0.56, blue: 1, alpha: 1)  //字体颜色必须为rgb格式 默认红色
    var normalColor: UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)   //字体颜色必须为rgb格式  默认黑色
    var bottomLineColor: UIColor = UIColor(red: 0.25, green: 0.43, blue: 0.84, alpha: 1)
}
