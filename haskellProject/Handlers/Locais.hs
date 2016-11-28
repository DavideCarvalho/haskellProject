{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Handlers.Locais where

import Foundation
import Yesod
import Database.Persist.Postgresql
import Data.Text

postInsertLocaisR :: Handler ()
postInsertLocaisR = do
    local <- requireJsonBody :: Handler Locais
    lid <- runDB $ insert local
    sendResponse (object [pack "resp" .= pack ("CREATED " ++ (show $ fromSqlKey lid))])
    
getListLocaisR :: Handler Html
getListLocaisR = do
    locais <- runDB $ selectList [] [Asc LocaisNome]
    sendResponse (object [pack "resp" .= toJSON locais])
    
putUpdateLocaisR :: Handler ()
putUpdateLocaisR = do
    local <- requireJsonBody :: Handler Locais
    lid <- runDB $ insert local
    sendResponse (object [pack "resp" .= pack ("UPDATED " ++ (show $ fromSqlKey lid))])