{-# LANGUAGE CPP #-}
-- |
-- Module      : Crypto.Cipher.Blowfish
-- License     : BSD-style
-- Maintainer  : Vincent Hanquez <vincent@snarc.org>
-- Stability   : stable
-- Portability : good
--
module Crypto.Cipher.Blowfish
    ( Blowfish64
    , Blowfish128
    , Blowfish256
    , Blowfish448
    ) where

import Data.Byteable
import Crypto.Cipher.Types
import Crypto.Cipher.Blowfish.Primitive

-- | 64 bit keyed blowfish state
newtype Blowfish64 = Blowfish64 Context

-- | 128 bit keyed blowfish state
newtype Blowfish128 = Blowfish128 Context

-- | 256 bit keyed blowfish state
newtype Blowfish256 = Blowfish256 Context

-- | 448 bit keyed blowfish state
newtype Blowfish448 = Blowfish448 Context

#define INSTANCE_CIPHER(CSTR, NAME, KEYSIZE) \
instance Cipher CSTR where \
    { cipherName _ = NAME \
    ; cipherKeySize _ = KeySizeFixed KEYSIZE \
    ; cipherInit k = either error CSTR $ initBlowfish (toBytes k) \
    }; \
instance BlockCipher CSTR where \
    { blockSize _ = 8 \
    ; ecbEncrypt (CSTR bf) = encrypt bf \
    ; ecbDecrypt (CSTR bf) = decrypt bf \
    };
    
INSTANCE_CIPHER(Blowfish64, "blowfish64", 8)
INSTANCE_CIPHER(Blowfish128, "blowfish128", 16)
INSTANCE_CIPHER(Blowfish256, "blowfish256", 32)
INSTANCE_CIPHER(Blowfish448, "blowfish448", 56)
