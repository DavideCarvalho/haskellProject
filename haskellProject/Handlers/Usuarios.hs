{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Handlers.Usuarios where

import Foundation
import Yesod
import Database.Persist.Postgresql
import Data.Text

postUsuariosR :: Handler ()
postUsuariosR = do
    usuario <- requireJsonBody :: Handler Usuarios
    uid <- runDB $ insert usuario
    sendResponse (object [pack "resp" .= pack ("CREATED " ++ (show $ fromSqlKey uid))])
    
getListUsuariosR :: Handler Html
getListUsuariosR = do
    usuario <- runDB $ selectList [] [Asc UsuariosNome]
    sendResponse (object [pack "resp" .= toJSON usuario])