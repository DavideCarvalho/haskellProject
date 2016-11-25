{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Usuarios where

import Foundation
import Yesod
import Database.Persist.Postgresql
import Data.Text

postUsuariosR :: Handler TypedContent
postUsuariosR = do 
    usuarios <- requireJsonBody :: Handler Usuarios
    uid <- runDB $ insert usuarios
    sendResponse (object [pack "resp" .= pack ("CREATED " ++ (show $ fromSqlKey uid))])