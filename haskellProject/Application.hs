{-# LANGUAGE OverloadedStrings    #-}
{-# LANGUAGE TemplateHaskell      #-}
{-# LANGUAGE ViewPatterns         #-}

{-# OPTIONS_GHC -fno-warn-orphans #-}
module Application where

import Foundation
import Yesod
import Network.Wai.Middleware.Cors

import Handlers.Usuarios
import Handlers.Locais
import Handlers.Produtos
import Handlers.TiposUsuarios
import Handlers.Login
import Handlers.Reservas

mkYesodDispatch "App" resourcesApp

addCORStoWOFF :: W.Middleware
addCORStoWOFF app = fmap updateHeaders . app
  where
    updateHeaders (W.ResponseFile    status headers fp mpart) = W.ResponseFile    status (new headers) fp mpart
    updateHeaders (W.ResponseBuilder status headers builder)  = W.ResponseBuilder status (new headers) builder
    updateHeaders (W.ResponseSource  status headers src)      = W.ResponseSource  status (new headers) src
    new headers | woff      = cors : headers
                | otherwise =        headers
      where woff = lookup HT.hContentType headers == Just "application/font-woff"
            cors = ("Access-Control-Allow-Origin", "*")