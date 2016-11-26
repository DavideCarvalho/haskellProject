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