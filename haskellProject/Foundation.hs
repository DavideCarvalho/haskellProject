{-# LANGUAGE OverloadedStrings, TypeFamilies, QuasiQuotes,
             TemplateHaskell, GADTs, FlexibleContexts,
             MultiParamTypeClasses, DeriveDataTypeable, EmptyDataDecls,
             GeneralizedNewtypeDeriving, ViewPatterns, FlexibleInstances #-}
module Foundation where

import Yesod
import Data.Text
import Database.Persist.Postgresql
    ( ConnectionPool, SqlBackend, runSqlPool)

data App = App {connPool :: ConnectionPool }

share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
Locais               json
    nome             Text
    localizacao      Text
    descricao        Text

TiposUsuarios       json
    descricao        Text
    
Usuarios             json
    nome             Text
    rg               Text
    senha            Text
    email            Text
    fk_tipo          TiposUsuariosId
    UniqueRg rg
    UniqueEmail email
    
Produtos             json
    nome             Text
    descricao        Text
    preco            Double
    fk_local         LocaisId
    
Reservas             json
    fk_usuario       UsuariosId
    
ReservasProdutos    json
    fk_reserva       ReservasId
    fk_produto       ProdutosId
    UniqueReservasProdutos fk_reserva fk_produto

|]

mkYesodData "App" $(parseRoutesFile "routes")

instance Yesod App where
    authRoute _ = Just LoginR
    
    ---- TEMPORARIO
    isAuthorized LoginR _ = return Authorized
    isAuthorized ListProdutosR _ = return Authorized
    isAuthorized ProdutosR _ = return Authorized
    isAuthorized ListLocaisR _ = return Authorized
    isAuthorized LocaisR _ = return Authorized
    isAuthorized ListTiposUsuariosR _ = return Authorized
    isAuthorized TiposUsuariosR _ = return Authorized
    isAuthorized ListUsuariosR _ = return Authorized
    isAuthorized UsuariosR _ = return Authorized
    isAuthorized ListReservasR _ = return Authorized
    isAuthorized ReservasR _ = return Authorized
    

instance YesodPersist App where
   type YesodPersistBackend App = SqlBackend
   runDB f = do
       master <- getYesod
       let pool = connPool master
       runSqlPool f pool
       logWare <- makeLogWare foundation
       appPlain <- toWaiAppPlain foundation
       return $ logWare $ defaultMiddlewaresNoLogging $ simpleCors appPlain
       
       
       
type Form a = Html -> MForm Handler (FormResult a, Widget)

instance RenderMessage App FormMessage where
    renderMessage _ _ = defaultFormMessage