{-# LANGUAGE OverloadedStrings #-}

module Main where

import           Data.Maybe
import           Network.Simple.TCP hiding (recv, send)
import           Network.Socket hiding (connect)
import           Prelude

decrypt :: String -> Maybe String
decrypt _ = Nothing

networkHandler :: (Socket, SockAddr) -> IO ()
networkHandler (connectionSocket, remoteAddr) = do
    putStrLn $ "Connection established to " ++ show remoteAddr
    _ <- sendTo connectionSocket "GET /\n" remoteAddr
    _ <- sendTo connectionSocket "\n" remoteAddr
    msg <- recv connectionSocket 1024
    putStrLn msg

main :: IO ()
main = connect "www.google.com" "80" networkHandler
