# SQAdsView
快速集成启动广告页
    let adsView = SQAdsView(frame: UIScreen.main.bounds, location: .TopRightCorner, type: .oval)
    let path = Bundle.main.path(forResource: "w640", ofType: "jpeg")
    let image = UIImage(contentsOfFile: path!)
    adsView.imageView.image = image!
    window?.addSubview(adsView)
    adsView.start()
    
网络图片加载
    adsView.imageView.kf.setImage(with: imageURL?.url(), placeholder: nil, options: [], progressBlock: nil, completionHandler: { (image, error, type, url) in
             self.window?.addSubview(startView)
             adsView.start()
    })
