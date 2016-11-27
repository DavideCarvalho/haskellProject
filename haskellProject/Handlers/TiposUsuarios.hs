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
    
getListTiposUsuariosR :: Handler ()
getListTiposUsuariosR = do
    tiposuario <- runDB $ selectList [] [Asc TiposUsuariosDescricao]
    sendResponse (object [pack "resp" .= toJSON tiposuario])

putUpdateTiposUsuariosR :: Handler ()
putUpdateTiposUsuariosR = do
    tiposuario <- requireJsonBody :: Handler TiposUsuarios
    uid <- runDB $ insert tiposuario
    sendResponse (object [pack "resp" .= pack ("UPDATED " ++ (show $ fromSqlKey uid))])