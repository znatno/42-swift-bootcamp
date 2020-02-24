//
//  ViewController.swift
//  ibohun2020
//
//  Created by znatno on 02/14/2020.
//  Copyright (c) 2020 znatno. All rights reserved.
//

import UIKit
import ibohun2020

class ViewController: UIViewController {

    var articleManager: ArticleManager!
    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        articleManager = ArticleManager()
        articles = articleManager.getAllArticles()
        
        // MARK: - Load custom articles
        
        let articleOne = articleManager.newArticle()
        articleOne.title = "A COOL project"
        articleOne.content = "asdfqe trhargasfeF "
        articleOne.language = "en"
        
        let articleTwo = articleManager.newArticle()
        articleTwo.title = "slava UKRAINI"
        articleTwo.content = "heroiam slava! slava natsiyi! smert voroham!!1"
        articleTwo.language = "uk"
        
        let articleThree = articleManager.newArticle()
        articleThree.title = "Volodymyr"
        articleThree.content = "988 rik khereshchennia Kyivskoyi Rusi"
        articleThree.language = "uk"
        
        let articleFour = articleManager.newArticle()
        articleFour.title = "Grzegorz Brzerzynczykievycz"
        articleFour.content = "Powiat Lekolody"
        articleFour.language = "pl"
        
        let articleFive = articleManager.newArticle()
        articleFive.title = "natqegu"
        articleFive.content = "tupa stalkersza"
        articleFive.language = "meme"

        // articleManager.save()
        
        // MARK: - Tests for Evaluation
        
        print("\n PRINT ALL \n")
        
        let all = articleManager.getAllArticles()
        print(all)
        
        print("\n PRINT WITH SPECIFIED LANG \n")
        
        let lang = articleManager.getArticles(withLang: "meme")
        print(lang)
        
        print("\n PRINT WITH SEARCH KEYWORD \n")
        
        let word = articleManager.getArticles(containString: "988")
        print(word)
        
        // print("\n DUMP OR REMOVE \n")
        
        // dump(articles)
        
        // MARK: Remove all
        
        /*
        for x in all {
            articleManager.removeArticle(article: x)
        }
        */
        
        // articleManager.save()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

