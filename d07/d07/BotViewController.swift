//
//  BotViewController.swift
//  d07
//
//  Created by Ivan BOHUN on 2/13/20.
//  Copyright © 2020 Ivan BOHUN. All rights reserved.
//

import UIKit
import RecastAI
import ForecastIO
import JSQMessagesViewController

struct User {
    let id: String
    let name: String
}

class BotViewController: JSQMessagesViewController, APIControllerDelegate {

    var apiController: APIController!
    
    let recastToken = "7e4c539ff8e19fe651c92e25fef3282c"
    let darkSkyToken = "8cb8ff647eddc68f24405642078df318"
    
    func receivedResponse(response: String) {
        print(response)
        
        let newMessage = JSQMessage(senderId: firstUser.id, displayName: firstUser.name, text: response)!
        messages.append(newMessage)
        
        finishSendingMessage(animated: true)
    }
    
    let firstUser = User(id: "1", name: "Bot")
    let secondUser = User(id: "2", name: "You")
    
    var currentUser: User {
        return secondUser
    }
    
    var messages = [JSQMessage]()
    
    func received(text: String) {
        let newMessage = JSQMessage(senderId: firstUser.id, displayName: firstUser.name, text: text)!

        messages.append(newMessage)

        DispatchQueue.main.async { [weak self] in
            self?.finishSendingMessage(animated: true)
        }
    }
    
}

extension BotViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiController = APIController(delegate: self, recastToken: recastToken, darkSkyToken: darkSkyToken)
        
        automaticallyScrollsToMostRecentMessage = true
        
        self.senderId = secondUser.id
        self.senderDisplayName = secondUser.name
        
        let startMessage = JSQMessage(senderId: firstUser.id, displayName: firstUser.name, text: "Hello, I'm bot! Send me a name of the city to know the weather")!
        messages.append(startMessage)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        
        let message = messages[indexPath.row]
        
        if currentUser.id == message.senderId {
            return bubbleFactory?.outgoingMessagesBubbleImage(with: .blue)
        } else {
            return bubbleFactory?.incomingMessagesBubbleImage(with: .blue)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.row]
    }
    
    override func didPressAccessoryButton(_ sender: UIButton!) {
        return
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        let newMessage = JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text)!
        messages.append(newMessage)
        
        finishSendingMessage(animated: true)

        apiController.searchForWeatherAt(text: text)
    }
    
}
