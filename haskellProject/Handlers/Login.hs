{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Handlers.Login where

import Foundation
import Yesod.Core
import Data.Text
import Database.Persist.Postgresql

postLoginR :: Handler ()
postLoginR = do
	log <- requireJsonBody :: Handler Usuarios
	email <- -- passar de log para email
	password <- -- passar de log para password
	-- precisa receber o email e o password separados, como faz?!
	usuario <- runDB $ selectFirst [UsuariosEmail ==. email, UsuariosSenha ==. password] []
	case usuario of
		Just (Entity uid usuario) -> do
			setSession "_ID" (pack $ show $ fromSqlKey uid)
			sendResponse (object [pack "resp" .= pack ("SUCCESSFULL LOGIN")])
		Nothing ->  do
			sendResponse (object [pack "resp" .= pack ("FAILED LOGIN")])
		
postLogoutR :: Handler ()
postLogoutR = do
    deleteSession "_ID"
    sendResponse (object [pack "resp" .= pack ("SUCCESSFULL LOGOUT")])