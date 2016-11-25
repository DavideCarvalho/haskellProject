{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Produtos where

import Foundation
import Yesod
import Database.Persist.Postgresql
import Data.Text


postProdutosR :: Handler TypedContent
postProdutosR = do 
    produtos <- requireJsonBody :: Handler Produtos
    uid <- runDB $ insert produtos
    sendResponse (object [pack "resp" .= pack ("CREATED " ++ (show $ fromSqlKey uid))])