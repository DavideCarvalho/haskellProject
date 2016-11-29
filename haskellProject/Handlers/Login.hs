{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Handlers.Login where

import Foundation
import Yesod.Core
import Data.Text
import Database.Persist.Postgresql

-- FUNCAO QUE VERIFICA 
postLoginR :: Handler ()
postLoginR = undefined

-- FUNÇÃO QUE DESTROI A SESSÃO
postLogoutR:: Handler ()
postLogoutR = do
    deleteSession "_ID"
    sendResponse (object [pack "resp" .= pack ("SUCESSFULL")])
    
    
    