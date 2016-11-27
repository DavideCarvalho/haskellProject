{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Handlers.Produtos where

import Foundation
import Yesod
import Database.Persist.Postgresql
import Data.Text

postProdutosR :: Handler ()
postProdutosR = do
    produto <- requireJsonBody :: Handler Produtos
    pid <- runDB $ insert produto
    sendResponse (object [pack "resp" .= pack ("CREATED " ++ (show $ fromSqlKey pid))])
    
getListProdutosR :: Handler Html
getListProdutosR = do
    addHeader "Access-Control-Allow-Origin" "*"
    addHeader "Access-Control-Allow-Methods" "GET, OPTIONS"
    produtos <- runDB $ selectList [] [Asc ProdutosNome]
    sendResponse (object [pack "resp" .= toJSON produtos])