{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Handlers.Usuarios where

import Foundation
import Yesod
import Database.Persist.Postgresql
import Data.Text

postInsertUsuariosR :: Handler ()
postInsertUsuariosR = do
    usuario <- requireJsonBody :: Handler Usuarios
    uid <- runDB $ insert usuario
    sendResponse (object [pack "resp" .= pack ("CREATED " ++ (show $ fromSqlKey uid))])
    
getListUsuariosR :: Handler ()
getListUsuariosR = do
    usuario <- runDB $ selectList [] [Asc UsuariosNome]
    sendResponse (object [pack "resp" .= toJSON usuario])

putUpdateUsuariosR :: Handler ()
putUpdateUsuariosR = do
    usuario <- requireJsonBody :: Handler Usuarios
    uid <- runDB $ insert usuario
    sendResponse (object [pack "resp" .= pack ("UPDATED " ++ (show $ fromSqlKey uid))])