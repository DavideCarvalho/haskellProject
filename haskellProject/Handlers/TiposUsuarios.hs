{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Handlers.TiposUsuarios where

import Foundation
import Yesod
import Database.Persist.Postgresql
import Data.Text

-- FUNÇÃO PARA INSERIR UM TIPOUSUARIO NO BD
postInsertTiposUsuariosR :: Handler ()
postInsertTiposUsuariosR = do
    tiposuario <- requireJsonBody :: Handler TiposUsuarios
    uid <- runDB $ insert tiposuario
    sendResponse (object [pack "resp" .= pack ("CREATED " ++ (show $ fromSqlKey uid))])

-- FUNÇÃO QUE LISTA TODOS OS TIPOSUSUARIO DO BD    
getListTiposUsuariosR :: Handler Html
getListTiposUsuariosR = do
    tiposuario <- runDB $ selectList [] [Asc TiposUsuariosDescricao]
    sendResponse (object [pack "resp" .= toJSON tiposuario])

-- FUNÇÃO QUE EDITA DADOS DE UM TIPOUSUARIO PROCURANDO POR ID (tid)
putUpdateTiposUsuariosR :: TiposUsuariosId -> Handler ()
putUpdateTiposUsuariosR tid = do
    tipo <- requireJsonBody :: Handler TiposUsuarios
    runDB $ update tid [TiposUsuariosDescricao =. (tiposUsuariosDescricao tipo)]
    sendResponse (object [pack "resp" .= pack "UPDATED"])