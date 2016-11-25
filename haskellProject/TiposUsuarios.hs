{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module TiposUsuarios where

import Foundation
import Yesod
import Database.Persist.Postgresql
import Data.Text

postTiposUsuariosR :: Handler TypedContent
postTiposUsuariosR = do 
    tiposusuarios <- requireJsonBody :: Handler TiposUsuarios
    uid <- runDB $ insert tiposusuarios
    sendResponse (object [pack "resp" .= pack ("CREATED " ++ (show $ fromSqlKey uid))])