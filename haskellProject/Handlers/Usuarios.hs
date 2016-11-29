{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Handlers.Usuarios where

import Foundation
import Yesod
import Database.Persist.Postgresql
import Data.Text

-- FUNÇÃO PARA INSERIR UM USUARIO NO BD
postInsertUsuariosR :: Handler ()
postInsertUsuariosR = do
    usuario <- requireJsonBody :: Handler Usuarios
    uid <- runDB $ insert usuario
    sendResponse (object [pack "resp" .= pack ("CREATED " ++ (show $ fromSqlKey uid))])

-- FUNÇÃO QUE LISTA TODOS OS USUARIOS DO BD   
getListUsuariosR :: Handler Html
getListUsuariosR = do
    usuario <- runDB $ selectList [] [Asc UsuariosNome]
    sendResponse (object [pack "resp" .= toJSON usuario])

-- FUNÇÃO QUE EDITA DADOS DE UM USUARIO PROCURANDO POR ID (uid)   
putUpdateUsuariosR :: UsuariosId -> Handler ()
putUpdateUsuariosR uid = do
    usuario <- requireJsonBody :: Handler Usuarios
    runDB $ update uid [UsuariosNome    =. (usuariosNome usuario)
                      , UsuariosRg      =. (usuariosRg usuario)
                      , UsuariosSenha   =. (usuariosSenha usuario)
                      , UsuariosEmail   =. (usuariosEmail usuario)
                      , UsuariosTipo    =. (usuariosTipo usuario)]
    sendResponse (object [pack "resp" .= pack "UPDATED"])