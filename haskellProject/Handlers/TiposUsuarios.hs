{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Handlers.TiposUsuarios where

import Foundation
import Yesod
import Database.Persist.Postgresql
import Data.Text

postInsertTiposUsuariosR :: Handler ()
postInsertTiposUsuariosR = do
    tiposuario <- requireJsonBody :: Handler TiposUsuarios
    uid <- runDB $ insert tiposuario
    sendResponse (object [pack "resp" .= pack ("CREATED " ++ (show $ fromSqlKey uid))])
    
getListTiposUsuariosR :: Handler Html
getListTiposUsuariosR = do
    tiposuario <- runDB $ selectList [] [Asc TiposUsuariosDescricao]
    sendResponse (object [pack "resp" .= toJSON tiposuario])
    
putUpdateTiposUsuariosR :: TiposUsuariosId -> Handler ()
putUpdateTiposUsuariosR tid = do
    tipo <- requireJsonBody :: Handler TiposUsuarios
    runDB $ update tid [TiposUsuariosDescricao =. (tiposUsuariosDescricao tipo)]
    sendResponse (object [pack "resp" .= pack "UPDATED"])