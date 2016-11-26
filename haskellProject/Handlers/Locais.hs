{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Handlers.Locais where

import Foundation
import Yesod
import Database.Persist.Postgresql
import Data.Text

postLocaisR :: Handler ()
postLocaisR = do
    local <- requireJsonBody :: Handler Locais
    lid <- runDB $ insert local
    sendResponse (object [pack "resp" .= pack ("CREATED " ++ (show $ fromSqlKey lid))])
    
getListLocaisR :: Handler Html
getListLocaisR = do
    addHeader "Access-Control-Allow-Origin" "*"
    addHeader "Access-Control-Allow-Methods" "GET, OPTIONS"
    locais <- runDB $ selectList [] [Asc LocaisNome]
    sendResponse (object [pack "resp" .= toJSON locais])