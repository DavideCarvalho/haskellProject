{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Handlers.TiposUsuarios where

import Foundation
import Yesod
import Database.Persist.Postgresql
import Data.Text

postTiposUsuariosR :: Handler ()
postTiposUsuariosR = do
    tiposuario <- requireJsonBody :: Handler TiposUsuarios
    uid <- runDB $ insert tiposuario
    sendResponse (object [pack "resp" .= pack ("CREATED " ++ (show $ fromSqlKey uid))])
    
getListTiposUsuariosR :: Handler Html
getListTiposUsuariosR = do
    tiposuario <- runDB $ selectList [] [Asc TiposUsuariosDescricao]
    sendResponse (object [pack "resp" .= toJSON tiposuario])