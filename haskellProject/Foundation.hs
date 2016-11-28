{-# LANGUAGE OverloadedStrings, TypeFamilies, QuasiQuotes,
             TemplateHaskell, GADTs, FlexibleContexts,
             MultiParamTypeClasses, DeriveDataTypeable, EmptyDataDecls,
             GeneralizedNewtypeDeriving, ViewPatterns, FlexibleInstances #-}
module Foundation where

import Yesod
import Data.Text
import Database.Persist.Postgresql
    (ConnectionPool, SqlBackend, runSqlPool)

data App = App {connPool :: ConnectionPool}

share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
Locais                  json
    nome                Text
    localizacao         Text
    descricao           Text

TiposUsuarios           json
    descricao           Text
    
Usuarios                json
    nome                Text
    rg                  Text
    senha               Text
    email               Text
    fk_tipo             TiposUsuariosId
    UniqueRg rg
    UniqueEmail email
    
Produtos                json
    nome                Text
    descricao           Text
    preco               Double
    fk_local            LocaisId
    
Reservas                json
    fk_usuario          UsuariosId
    ic_atendido         Bool
    
ReservasProdutos        json
    fk_reserva          ReservasId
    fk_produto          ProdutosId
    qt_produto          Int
    UniqueReservasProdutos fk_reserva fk_produto

|]

mkYesodData "App" $(parseRoutesFile "routes")

instance Yesod App where
    authRoute _ = Just LoginR
    
    isAuthorized LoginR _ = return Authorized
    isAuthorized InsertUsuariosR _ = return Authorized
    isAuthorized _ _ = estaAutenticado

estaAutenticado :: Handler AuthResult
estaAutenticado = do
   msu <- lookupSession "_ID"
   case msu of
       Just _ -> return Authorized
       Nothing -> return AuthenticationRequired 
    
instance YesodPersist App where
   type YesodPersistBackend App = SqlBackend
   runDB f = do
       master <- getYesod
       let pool = connPool master
       runSqlPool f pool
       
type Form a = Html -> MForm Handler (FormResult a, Widget)

instance RenderMessage App FormMessage where
    renderMessage _ _ = defaultFormMessage