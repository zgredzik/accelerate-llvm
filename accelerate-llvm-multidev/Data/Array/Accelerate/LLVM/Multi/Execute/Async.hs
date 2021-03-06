{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TypeFamilies    #-}
{-# OPTIONS -fno-warn-orphans #-}
-- |
-- Module      : Data.Array.Accelerate.LLVM.Multi.Execute.Async
-- Copyright   : [2014] Trevor L. McDonell, Sean Lee, Vinod Grover, NVIDIA Corporation
-- License     : BSD3
--
-- Maintainer  : Trevor L. McDonell <tmcdonell@cse.unsw.edu.au>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)
--

module Data.Array.Accelerate.LLVM.Multi.Execute.Async (

  Async, Stream,
  A.wait, A.after, A.streaming, A.async,

) where

-- accelerate
import qualified Data.Array.Accelerate.LLVM.Execute.Async       as A
import qualified Data.Array.Accelerate.LLVM.PTX.Execute.Async   as PTX ( Async(..) )
import qualified Data.Array.Accelerate.LLVM.PTX.Execute.Stream  as PTX

import Data.Array.Accelerate.LLVM.State
import Data.Array.Accelerate.LLVM.PTX.Target                    ( PTX(..) )
import Data.Array.Accelerate.LLVM.Multi.Target

-- standard library
import Control.Monad.State


type Async a = PTX.Async a
type Stream  = PTX.Stream

-- The Multi-device backend does everything synchronously.
--
instance A.Async Multi where
  type AsyncR Multi a = Async a
  type StreamR Multi  = Stream

  {-# INLINE wait #-}
  wait a =
    A.wait a `with` ptxTarget

  {-# INLINE after #-}
  after stream a =
    A.after stream a `with` ptxTarget

  {-# INLINE streaming #-}
  streaming first second = do
    PTX{..} <- gets (ptxTarget . llvmTarget)
    PTX.streaming ptxContext ptxStreamReservoir first (\event arr -> second (PTX.Async event arr))

  {-# INLINE async #-}
  async stream action = do
    r <- action
    A.async stream (return r) `with` ptxTarget

