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
    
getListUsuariosR :: Handler Html
getListUsuariosR = do
    usuario <- runDB $ selectList [] [Asc UsuariosNome]
    sendResponse (object [pack "resp" .= toJSON usuario])
    
putUpdateUsuariosR :: UsuariosId -> Handler ()
putUpdateUsuariosR pid = do
    usuario <- requireJsonBody :: Handler Usuarios
    runDB $ update pid [UsuariosNome    =. (usuariosNome usuario)
                      , UsuariosRg      =. (usuariosRg usuario)
                      , UsuariosSenha   =. (usuariosSenha usuario)
                      , UsuariosEmail   =. (usuariosEmail usuario)
                      , UsuariosTipo    =. (usuariosTipo usuario)]
    sendResponse (object [pack "resp" .= pack "UPDATED"])