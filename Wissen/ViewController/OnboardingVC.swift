//
//  OnboardingVC.swift
//  Wissen
//
//  Created by Isaac Almanza on 2/24/19.
//  Copyright © 2019 Isaac Almanza. All rights reserved.
//

import UIKit



class OnboardingVC: UIViewController {

	var slides: [Slide] = [];

	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var pageControl: UIPageControl!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		scrollView.delegate = self
		
		slides = createSlides()
		setupSlideScrollView(slides: slides)
		
		pageControl.numberOfPages = slides.count
		pageControl.currentPage = 0
		view.bringSubview(toFront: pageControl)
    }
	
	
	@IBAction func onClick(_ sender: UIButton) {
		
	}

	
	
	func setupSlideScrollView(slides : [Slide]) {
		scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 1)
		scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: 1)
		scrollView.isPagingEnabled = true
		
		for i in 0 ..< slides.count {
			slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
			scrollView.addSubview(slides[i])
		}
	}
	
	
	func createSlides() -> [Slide] {
		
		let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
		slide1.imageView.image = UIImage(named: "ic_onboarding_1")
		slide1.labelTitle.text = "A real-life bear"
		slide1.labelDesc.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
		
		let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
		slide2.imageView.image = UIImage(named: "ic_onboarding_1")
		slide2.labelTitle.text = "A real-life bear"
		slide2.labelDesc.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
		
		let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
		slide3.imageView.image = UIImage(named: "ic_onboarding_1")
		slide3.labelTitle.text = "A real-life bear"
		slide3.labelDesc.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
		
		return [slide1, slide2, slide3]
	}
	

}


extension OnboardingVC : UIScrollViewDelegate {
	
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		/*
		*
		*/
		setupSlideScrollView(slides: slides)
	}

	
	/*
	* default function called when view is scolled. In order to enable callback
	* when scrollview is scrolled, the below code needs to be called:
	* slideScrollView.delegate = self or
	*/
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
		pageControl.currentPage = Int(pageIndex)
		
		let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
		let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
		
		// vertical
		let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
		let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
		
		let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
		let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
		
		
		/*
		* below code changes the background color of view on paging the scrollview
		*/
		//        self.scrollView(scrollView, didScrollToPercentageOffset: percentageHorizontalOffset)
		
		
		/*
		* below code scales the imageview on paging the scrollview
		*/
		let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
		
		if(percentOffset.x > 0 && percentOffset.x <= 0.25) {
			
			//slides[0].imageView.transform = CGAffineTransform(scaleX: (0.25-percentOffset.x)/0.25, y: (0.25-percentOffset.x)/0.25)
			//slides[1].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.25, y: percentOffset.x/0.25)
			
		} else if(percentOffset.x > 0.25 && percentOffset.x <= 0.50) {
			//slides[1].imageView.transform = CGAffineTransform(scaleX: (0.50-percentOffset.x)/0.25, y: (0.50-percentOffset.x)/0.25)
			//slides[2].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.50, y: percentOffset.x/0.50)
			
		} else if(percentOffset.x > 0.50 && percentOffset.x <= 0.75) {
			//slides[2].imageView.transform = CGAffineTransform(scaleX: (0.75-percentOffset.x)/0.25, y: (0.75-percentOffset.x)/0.25)
			//slides[3].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.75, y: percentOffset.x/0.75)
			
		} else if(percentOffset.x > 0.75 && percentOffset.x <= 1) {
			//slides[3].imageView.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.25, y: (1-percentOffset.x)/0.25)
			//slides[4].imageView.transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
		}
	}
}
