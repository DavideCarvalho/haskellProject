{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Handlers.Login where

import Foundation
import Yesod.Core
import Data.Text
import Database.Persist.Postgresql

postLoginR :: Handler ()
postLoginR = undefined
-- do usuario <- requireJsonBody :: Handler Usuarios pegar 'atributo' por 'atributo'

postLogoutR:: Handler ()
postLogoutR = do
    deleteSession "_ID"
    sendResponse (object [pack "resp" .= pack ("SUCESSFULL")])