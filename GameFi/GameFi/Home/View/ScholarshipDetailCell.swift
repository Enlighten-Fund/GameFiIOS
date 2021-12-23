//
//  ScholarshipDetailCell.swift
//  GameFi
//
//  Created by harden on 2021/11/15.
//
import Foundation
import UIKit
let scholarshipDetailCellIdentifier:String = "ScholarshipDetailCell"



class StatsView: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(20)
        }
        self.statsBtn.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
            make.left.equalTo(self.titleLabel.snp.left).offset(0)
            make.right.equalToSuperview()
            make.height.equalTo(20)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    lazy var titleLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.font = UIFont(name: "Avenir Next Medium", size: 12)
        tempLabel.textColor = UIColor(red: 0.58, green: 0.62, blue: 0.78, alpha: 1)
        self.addSubview(tempLabel)
        return tempLabel
    }()
    lazy var statsBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.titleLabel?.textColor = .white
        tempBtn.titleLabel?.font = UIFont(name: "Avenir Next Regular", size: 15)
        tempBtn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        self.addSubview(tempBtn)
        return tempBtn
    }()
}

class AbilityLabelView: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.leftLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalTo(80)
            make.bottom.equalToSuperview()
        }
        self.rightLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.width.equalTo(80)
            make.bottom.equalToSuperview()
        }
    }
    
    func update(leftTitle:String,rithtTitle:String) {
        self.leftLabel.text = leftTitle
        self.rightLabel.text = rithtTitle
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    lazy var leftLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor =  UIColor(red: 0.58, green: 0.62, blue: 0.78, alpha: 1)
        tempLabel.font = UIFont(name: "Avenir Next Regular", size: 12)
        self.addSubview(tempLabel)
        return tempLabel
    }()
    lazy var rightLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = .white
        tempLabel.textAlignment = .right
        tempLabel.font = UIFont(name: "Avenir Next Medium", size: 14)
        self.addSubview(tempLabel)
        return tempLabel
    }()
}

class AbilityView: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        self.partImgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(30)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        self.titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.partImgView.snp.centerY)
            make.left.equalTo(self.partImgView.snp.right)
            make.right.equalToSuperview()
            make.height.equalTo(25)
        }
        self.abilityImgView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview()
            make.height.equalTo((screenWidth - 70) / 2.0 * (311 / 233.0))
        }
        self.energyLabel.snp.makeConstraints { make in
            make.top.equalTo(self.abilityImgView.snp.top).offset(3)
            make.left.equalToSuperview().offset(13)
            make.width.equalTo(35)
            make.height.equalTo(35)
        }
        self.nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.energyLabel.snp.centerY).offset(2)
            make.left.equalTo(self.energyLabel.snp.right).offset(6)
            make.right.equalToSuperview()
            make.height.equalTo(20)
        }
        self.attactBgImgView.snp.makeConstraints { make in
            make.top.equalTo(self.energyLabel.snp.bottom).offset(15)
            make.left.equalToSuperview()
            make.width.equalTo(30)
            make.height.equalTo(35)
        }
        self.attactImgView.snp.makeConstraints { make in
            make.center.equalTo(self.attactBgImgView)
            make.width.equalTo(20)
            make.height.equalTo(25)
        }
        self.attackLabel.snp.makeConstraints { make in
            make.center.equalTo(self.attactBgImgView)
            make.width.equalTo(20)
            make.height.equalTo(25)
        }
        self.defenceBgImgView.snp.makeConstraints { make in
            make.top.equalTo(self.attactBgImgView.snp.bottom)
            make.left.equalToSuperview()
            make.width.equalTo(30)
            make.height.equalTo(35)
        }
        self.defenceImgView.snp.makeConstraints { make in
            make.center.equalTo(self.defenceBgImgView)
            make.width.equalTo(20)
            make.height.equalTo(25)
        }
        self.defLabel.snp.makeConstraints { make in
            make.center.equalTo(self.defenceBgImgView)
            make.width.equalTo(20)
            make.height.equalTo(25)
        }
        self.cardImgView.snp.makeConstraints { make in
            make.bottom.equalTo(self.abilityImgView.snp.bottom).offset(-30)
            make.left.equalToSuperview().offset(16)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
        self.descLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.cardImgView)
            make.left.equalTo(self.cardImgView.snp.right)
            make.right.equalTo(self.abilityImgView)
            make.height.equalTo(80)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func update(abilityModel:AxieAbilityModel) {
        let partIconName = "\(abilityModel.id!.components(separatedBy: "-")[0])-\(abilityModel.id!.components(separatedBy: "-")[1])"
        self.partImgView.image = UIImage.init(named:partIconName)
        if abilityModel.partName != nil {
            self.titleLabel.text = abilityModel.partName
        }
        self.abilityImgView.kf.setImage(with: URL.init(string: "https://storage.googleapis.com/axie-cdn/game/cards/base/\(abilityModel.id!).png"), placeholder:  UIImage.init(named: "portrait"), options: nil) {result, error in
            
        }
        self.energyLabel.text = abilityModel.defaultEnergy
        self.nameLabel.text = abilityModel.skillName
        self.attactBgImgView.image = UIImage.init(named:"bg-\(abilityModel.id!.components(separatedBy: "-")[0])")
        self.attactImgView.image = UIImage.init(named: "icon-atk")
        self.attackLabel.text = abilityModel.defaultAttack
        self.defenceBgImgView.image = UIImage.init(named:"bg-\(abilityModel.id!.components(separatedBy: "-")[0])")
        self.defenceImgView.image = UIImage.init(named: "icon-def")
        self.defLabel.text = abilityModel.defaultDefense
        self.cardImgView.kf.setImage(with: URL.init(string: "https://storage.googleapis.com/axie-cdn/game/cards/effect-icons/\(abilityModel.iconId!).png"), placeholder:  UIImage.init(named: "portrait"), options: nil) {result, error in
            
        }
        self.descLabel.text = abilityModel.description
    }
    
    lazy var partImgView : UIImageView = {
        let temp = UIImageView.init(frame: CGRect.zero)
        self.addSubview(temp)
        return temp
    }()
    
    lazy var titleLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.font = UIFont(name: "Avenir Next Bold", size: 12.2)
        tempLabel.textColor = UIColor(red: 0.58, green: 0.62, blue: 0.78, alpha: 1)
        tempLabel.textAlignment = .left
        tempLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(tempLabel)
        return tempLabel
    }()
    lazy var abilityImgView : UIImageView = {
        let tempView = UIImageView.init(frame: CGRect.zero)
        self.addSubview(tempView)
        return tempView
    }()
    lazy var energyLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.font = UIFont.boldSystemFont(ofSize: 25)
        tempLabel.textColor = .white
        tempLabel.textAlignment = .center
        tempLabel.backgroundColor = .clear
        tempLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(tempLabel)
        return tempLabel
    }()
    lazy var nameLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.font = UIFont(name: "Avenir Next Medium", size: 12)
        tempLabel.textColor = .white
        tempLabel.textAlignment = .left
        tempLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(tempLabel)
        return tempLabel
    }()
    lazy var attactBgImgView : UIImageView = {
        let tempView = UIImageView.init(frame: CGRect.zero)
        self.addSubview(tempView)
        return tempView
    }()
    lazy var attactImgView : UIImageView = {
        let tempView = UIImageView.init(frame: CGRect.zero)
        self.addSubview(tempView)
        return tempView
    }()
    lazy var attackLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.font = UIFont.boldSystemFont(ofSize: 17)
        tempLabel.textColor = .white
        tempLabel.adjustsFontSizeToFitWidth = true
        tempLabel.textAlignment = .center
        self.addSubview(tempLabel)
        return tempLabel
    }()
    lazy var defenceBgImgView : UIImageView = {
        let tempView = UIImageView.init(frame: CGRect.zero)
        self.addSubview(tempView)
        return tempView
    }()
    lazy var defenceImgView : UIImageView = {
        let tempView = UIImageView.init(frame: CGRect.zero)
        self.addSubview(tempView)
        return tempView
    }()
    lazy var defLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.font = UIFont.boldSystemFont(ofSize: 17)
        tempLabel.textColor = .white
        tempLabel.adjustsFontSizeToFitWidth = true
        tempLabel.textAlignment = .center
        self.addSubview(tempLabel)
        return tempLabel
    }()
    lazy var cardImgView : UIImageView = {
        let tempView = UIImageView.init(frame: CGRect.zero)
        self.addSubview(tempView)
        return tempView
    }()
    lazy var descLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.font = UIFont(name: "Avenir Next Regular", size: 11)
        tempLabel.textColor = .white
        tempLabel.numberOfLines = 0
        tempLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(tempLabel)
        return tempLabel
    }()
}


class ScholarshipDetailCell: TableViewCell {
    
    override func makeConstraints(){
        super.makeConstraints()
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = true
        self.contentView.backgroundColor = UIColor(red: 0.14, green: 0.15, blue: 0.21, alpha: 1)
        self.backgroundColor = UIColor(red: 0.14, green: 0.15, blue: 0.21, alpha: 1)
        self.contentView.layer.borderWidth = 0.5
        self.contentView.layer.borderColor = UIColor(red: 0.27, green: 0.3, blue: 0.41, alpha: 1).cgColor
        self.axieImgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(120)
            make.width.equalTo(150)
        }
        self.classLabel.snp.makeConstraints { make in
            make.top.equalTo(self.axieImgView.snp.bottom)
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        self.classBtn.snp.makeConstraints { make in
            make.top.equalTo(self.classLabel.snp.bottom)
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(50)
            make.width.equalTo((SCREEN_WIDTH - 70)/2.0)
        }
        self.idLabel.snp.makeConstraints { make in
            make.top.equalTo(self.axieImgView.snp.bottom)
            make.left.equalTo(self.classBtn.snp.right).offset(10)
            make.height.equalTo(40)
            make.width.equalTo((SCREEN_WIDTH - 70)/2.0)
        }
        self.idBtn.snp.makeConstraints { make in
            make.top.equalTo(self.classLabel.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(50)
            make.width.equalTo((SCREEN_WIDTH - 70)/2.0)
        }
        self.statsLabel.snp.makeConstraints { make in
            make.top.equalTo(self.idBtn.snp.bottom)
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(40)
            make.width.equalTo((SCREEN_WIDTH - 70)/2.0)
        }
        self.statsBgView.snp.makeConstraints { make in
            make.top.equalTo(self.statsLabel.snp.bottom)
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(70)
            make.right.equalToSuperview().offset(-15)
        }
        self.energyView.snp.makeConstraints { make in
            make.top.equalTo(self.statsBgView.snp.top)
            make.left.equalToSuperview().offset(35)
            make.height.equalTo(70)
            make.width.equalTo(60)
        }
        self.speedView.snp.makeConstraints { make in
            make.top.equalTo(self.statsBgView.snp.top)
            make.left.equalTo(self.energyView.snp.right).offset((screenWidth - 100 - 60 * 4) / 3.0)
            make.height.equalTo(70)
            make.width.equalTo(60)
        }
        self.skillView.snp.makeConstraints { make in
            make.top.equalTo(self.statsBgView.snp.top)
            make.left.equalTo(self.speedView.snp.right).offset((screenWidth - 100 - 60 * 4) / 3.0)
            make.height.equalTo(70)
            make.width.equalTo(60)
        }
        self.moraleView.snp.makeConstraints { make in
            make.top.equalTo(self.statsBgView.snp.top)
            make.left.equalTo(self.skillView.snp.right).offset((screenWidth - 100 - 60 * 4) / 3.0)
            make.height.equalTo(70)
            make.width.equalTo(60)
        }
        self.abilityLabel.snp.makeConstraints { make in
            make.top.equalTo(self.statsBgView.snp.bottom)
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(40)
            make.width.equalTo(60)
        }
        
        self.abilityBack.snp.makeConstraints { make in
            make.top.equalTo(self.abilityLabel.snp.bottom)
            make.left.equalToSuperview().offset(15)
            make.height.equalTo((screenWidth - 70) / 2.0 * (311 / 233.0) + 50)
            make.width.equalTo((screenWidth - 70) / 2.0)
        }
        self.abilityMouth.snp.makeConstraints { make in
            make.top.equalTo(self.abilityLabel.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo((screenWidth - 70) / 2.0 * (311 / 233.0) + 50)
            make.width.equalTo((screenWidth - 70) / 2.0)
        }
        self.abilityHorn.snp.makeConstraints { make in
            make.top.equalTo(self.abilityBack.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(15)
            make.height.equalTo((screenWidth - 70) / 2.0 * (311 / 233.0) + 50)
            make.width.equalTo((screenWidth - 70) / 2.0)
        }
        self.abilityTail.snp.makeConstraints { make in
            make.top.equalTo(self.abilityMouth.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo((screenWidth - 70) / 2.0 * (311 / 233.0) + 50)
            make.width.equalTo((screenWidth - 70) / 2.0)
        }
    }

    func update(axieinfoModel:AxieinfoModel) {
        if axieinfoModel.id != nil {
            let axiePic1 = axieinfoModel.id!
            self.axieImgView.kf.setImage(with: URL.init(string: "https://storage.googleapis.com/assets.axieinfinity.com/axies/\(axiePic1)/axie/axie-full-transparent.png"), placeholder:  UIImage.init(named: "portrait"), options: nil) {result, error in
                
            }
        }
        if axieinfoModel.axie_class != nil {
            self.classBtn.setTitle(axieinfoModel.axie_class, for: .normal)
            self.classBtn.setImage(UIImage.init(named: axieinfoModel.axie_class!.lowercased()), for: .normal)
        }
        if axieinfoModel.id != nil {
            self.idBtn.setTitle("#\(axieinfoModel.id!)", for: .normal)
        }

        if axieinfoModel.stats_hp != nil {
            self.energyView.statsBtn.setTitle(axieinfoModel.stats_hp, for: .normal)
        }
        
        if axieinfoModel.stats_speed != nil {
            self.speedView.statsBtn.setTitle(axieinfoModel.stats_speed, for: .normal)
        }
        if axieinfoModel.stats_skill != nil {
            self.skillView.statsBtn.setTitle(axieinfoModel.stats_skill, for: .normal)
        }
        if axieinfoModel.stats_morale != nil {
            self.moraleView.statsBtn.setTitle(axieinfoModel.stats_morale, for: .normal)
        }
        let allAbilityDic = AbilityUtil.sharedInstance.allAbility
        if axieinfoModel.ability_back != nil {
            let dic = allAbilityDic![axieinfoModel.ability_back!]
            if dic != nil {
                let abilityModel : AxieAbilityModel = JsonUtil.dictionaryToModel(dic as! [String : Any], AxieAbilityModel.self) as! AxieAbilityModel
                self.abilityBack.update(abilityModel: abilityModel)
            }
        }
        if axieinfoModel.ability_mouth != nil {
            let dic = allAbilityDic![axieinfoModel.ability_mouth!]
            if dic != nil {
                let abilityModel : AxieAbilityModel = JsonUtil.dictionaryToModel(dic as! [String : Any], AxieAbilityModel.self) as! AxieAbilityModel
                self.abilityMouth.update(abilityModel: abilityModel)
            }
        }
        if axieinfoModel.ability_horn != nil {
            let dic = allAbilityDic![axieinfoModel.ability_horn!]
            if dic != nil {
                let abilityModel : AxieAbilityModel = JsonUtil.dictionaryToModel(dic as! [String : Any], AxieAbilityModel.self) as! AxieAbilityModel
                self.abilityHorn.update(abilityModel: abilityModel)
            }
        }
        if axieinfoModel.ability_tail != nil {
            let dic = allAbilityDic![axieinfoModel.ability_tail!]
            if dic != nil {
                let abilityModel : AxieAbilityModel = JsonUtil.dictionaryToModel(dic as! [String : Any], AxieAbilityModel.self) as! AxieAbilityModel
                self.abilityTail.update(abilityModel: abilityModel)
            }
        }
    }
    
    lazy var axieImgView : UIImageView = {
        let tempImgView = UIImageView.init()
        self.contentView.addSubview(tempImgView)
        return tempImgView
    }()
    
    lazy var classLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        tempLabel.font = UIFont(name: "Avenir Next Medium", size: 15)
        tempLabel.text = "Class"
        self.contentView.addSubview(tempLabel)
        return tempLabel
    }()
    
    lazy var idLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        tempLabel.font = UIFont(name: "Avenir Next Medium", size: 15)
        tempLabel.text = "ID"
        self.contentView.addSubview(tempLabel)
        return tempLabel
    }()
    
    lazy var classBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.titleLabel?.textColor = .white
        tempBtn.backgroundColor = UIColor(red: 0.17, green: 0.18, blue: 0.26, alpha: 1)
        tempBtn.layer.cornerRadius = 5
        tempBtn.layer.masksToBounds = true
        tempBtn.titleLabel?.font = UIFont(name: "Avenir Next Regular", size: 15)
        self.contentView.addSubview(tempBtn)
        return tempBtn
    }()
    
    lazy var idBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.setTitleColor(UIColor(red: 0.55, green: 0.75, blue: 0.28, alpha: 1), for: .normal)
        tempBtn.titleLabel?.font = UIFont(name: "Avenir Next Regular", size: 15)
        tempBtn.backgroundColor = UIColor(red: 0.17, green: 0.18, blue: 0.26, alpha: 1)
        tempBtn.layer.cornerRadius = 5
        tempBtn.layer.masksToBounds = true
        self.contentView.addSubview(tempBtn)
        return tempBtn
    }()
    
    lazy var statsLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        tempLabel.font = UIFont(name: "Avenir Next Medium", size: 15)
        tempLabel.text = "Statistics"
        self.contentView.addSubview(tempLabel)
        return tempLabel
    }()
    
    lazy var statsBgView : UIView = {
        let tempLabelView = UIView.init(frame: CGRect.zero)
        tempLabelView.backgroundColor = UIColor(red: 0.17, green: 0.18, blue: 0.26, alpha: 1)
        tempLabelView.layer.cornerRadius = 5
        tempLabelView.layer.masksToBounds = true
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var energyView : StatsView = {
        let statsView = StatsView.init(frame: CGRect.zero)
        statsView.titleLabel.text = "ENERGY"
        statsView.statsBtn.setImage(UIImage.init(named: "stats_energy"), for: .normal)
        statsView.statsBtn.setImage(UIImage.init(named: "stats_energy"), for: .highlighted)
        self.contentView.addSubview(statsView)
        return statsView
    }()
    lazy var speedView : StatsView = {
        let statsView = StatsView.init(frame: CGRect.zero)
        statsView.titleLabel.text = "SPEED"
        statsView.statsBtn.setImage(UIImage.init(named: "stats_speed"), for: .normal)
        statsView.statsBtn.setImage(UIImage.init(named: "stats_speed"), for: .highlighted)
        self.contentView.addSubview(statsView)
        return statsView
    }()
    
    lazy var skillView : StatsView = {
        let statsView = StatsView.init(frame: CGRect.zero)
        statsView.titleLabel.text = "SKILL"
        statsView.statsBtn.setImage(UIImage.init(named: "stats_skill"), for: .normal)
        statsView.statsBtn.setImage(UIImage.init(named: "stats_skill"), for: .highlighted)
        self.contentView.addSubview(statsView)
        return statsView
    }()
    lazy var moraleView : StatsView = {
        let statsView = StatsView.init(frame: CGRect.zero)
        statsView.titleLabel.text = "MORALE"
        statsView.statsBtn.setImage(UIImage.init(named: "stats_morale"), for: .normal)
        statsView.statsBtn.setImage(UIImage.init(named: "stats_morale"), for: .highlighted)
        self.contentView.addSubview(statsView)
        return statsView
    }()
    lazy var abilityLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        tempLabel.font = UIFont(name: "Avenir Next Medium", size: 15)
        tempLabel.text = "Abilities"
        self.contentView.addSubview(tempLabel)
        return tempLabel
    }()
    lazy var abilityBack : AbilityView = {
        let tempView = AbilityView.init(frame: CGRect.zero)
        tempView.titleLabel.text = "back"
        self.contentView.addSubview(tempView)
        return tempView
    }()
    lazy var abilityMouth : AbilityView = {
        let tempView = AbilityView.init(frame: CGRect.zero)
        tempView.titleLabel.text = "mouth"
        self.contentView.addSubview(tempView)
        return tempView
    }()
    lazy var abilityHorn : AbilityView = {
        let tempView = AbilityView.init(frame: CGRect.zero)
        tempView.titleLabel.text = "horn"
        self.contentView.addSubview(tempView)
        return tempView
    }()
    lazy var abilityTail : AbilityView = {
        let tempView = AbilityView.init(frame: CGRect.zero)
        tempView.titleLabel.text = "tail"
        self.contentView.addSubview(tempView)
        return tempView
    }()
}
