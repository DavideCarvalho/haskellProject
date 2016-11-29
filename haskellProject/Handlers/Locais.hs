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
    
putUpdateLocaisR :: LocaisId -> Handler ()
putUpdateLocaisR lid = do
    local <- requireJsonBody :: Handler Locais
    runDB $ update lid [LocaisNome          =. (locaisNome local)
                      , LocaisLocalizacao   =. (locaisLocalizacao local)
                      , LocaisDescricao     =. (locaisDescricao local)]
    sendResponse (object [pack "resp" .= pack "UPDATED"])