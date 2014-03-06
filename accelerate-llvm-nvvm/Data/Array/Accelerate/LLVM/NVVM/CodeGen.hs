{-# OPTIONS -fno-warn-orphans #-}
-- |
-- Module      : Data.Array.Accelerate.LLVM.NVVM.CodeGen
-- Copyright   : [2013] Trevor L. McDonell, Sean Lee, Vinod Grover
-- License     : BSD3
--
-- Maintainer  : Trevor L. McDonell <tmcdonell@nvidia.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)
--

module Data.Array.Accelerate.LLVM.NVVM.CodeGen
  where

-- accelerate
import Data.Array.Accelerate.LLVM.CodeGen

--import Data.Array.Accelerate.LLVM.NVVM.CodeGen.Fold
import Data.Array.Accelerate.LLVM.NVVM.Target
import Data.Array.Accelerate.LLVM.NVVM.CodeGen.Generate
import Data.Array.Accelerate.LLVM.NVVM.CodeGen.Map
import Data.Array.Accelerate.LLVM.NVVM.CodeGen.Transform


instance Skeleton NVVM where
  map           = mkMap
  generate      = mkGenerate
  transform     = mkTransform
--  fold          = mkFold
--  fold1         = mkFold1
